import 'dart:io';

import 'package:args/args.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;

import 'package:rpc/rpc.dart';

import 'package:auge_server/augeapi.dart';
import 'package:auge_server/initiativeaugeapi.dart';
import 'package:auge_server/objectiveaugeapi.dart';

const _API_PREFIX = '/'; // '/api';
final ApiServer _apiServer =
  new ApiServer(apiPrefix: _API_PREFIX, prettyPrint: true);

main(List<String> args) async {
  var parser = new ArgParser()
    ..addOption('port', abbr: 'p', defaultsTo: '8091')
    ..addOption('https', abbr: 's', defaultsTo: 'true');

  var result = parser.parse(args);

  var port = int.tryParse(result['port']);

  bool httpsEnabled = result['https'] == 'true';

  if (port == null) {
    stdout.writeln(
        'Could not parse port value "${result['port']}" into a number.');
    // 64: command line usage error
    exitCode = 64;
    return;
  }

  // RPC
/*
  rpcLogger.onRecord.listen((event) {
    print('${event.level.name}: ${event.time}: ${event.message}');
  });
*/
  _apiServer.addApi(new AugeApi());
  _apiServer.addApi(new InitiativeAugeApi());
  _apiServer.addApi(new ObjectiveAugeApi());
  _apiServer.enableDiscoveryApi();


  // Create a Shelf handler for your RPC API.
  var apiHandler = createRpcHandler(_apiServer);



  var handler = const shelf.Pipeline()
      .addMiddleware(shelf.logRequests())
    //  .addMiddleware(createCorsHeadersMiddleware(corsHeaders: {'Access-Control-Allow-Origin': '*',  'Access-Control-Allow-Methods': '*', 'Access-Control-Allow-Headers': '*'}))
    //  .addMiddleware(auth(AugeConf.basicAuth))
      .addHandler(apiHandler);

  //var server = await io.serve(handler, 'localhost', port);
  SecurityContext securityContext;
  if (httpsEnabled) {
    String certificateLocalization = '/etc/letsencrypt/live/auge.levius.com.br/';
    try {
      securityContext = new SecurityContext()
        ..useCertificateChain(
            certificateLocalization + 'fullchain.pem')
        ..usePrivateKey(certificateLocalization + 'privkey.pem');

      /*
       ..useCertificateChain('lib/assets/cert/localhost.cert')
       ..usePrivateKey('lib/assets/cert/localhost.key');
*/
    } catch (e) {
      stdout.writeln('Not found certificate on ${certificateLocalization} or certificate invalid.\nTrying simple http.');
      securityContext = null;
    }
  }
    // ..useCertificateChain('lib/assets/cert/localhost.cert')
    // ..usePrivateKey('lib/assets/cert/localhost.key');

    //..useCertificateChain('lib/assets/cert/certificate_ca_bundle.crt')
    //..usePrivateKey('lib/assets/cert/private.key');


    //..usePrivateKey('lib/assets/cert/private-encrypted.key',
     // password: 'supermuka');

  String host = '0.0.0.0';
  // String host = '127.0.0.1';
  //String host = 'localhost';

  HttpServer server = await io.serve(handler, host, port, securityContext: securityContext );

  String httpHttps = (securityContext == null) ? 'http' : 'https';

  print('Serving at ${httpHttps}://${server.address.host}:${server.port}');
}
/*
shelf.Response _echoRequest(shelf.Request request) =>
    new shelf.Response.ok('Request for "${request.url}"');
*/
// Reference: shelf_rpc package (archived)

/// Creates a Shelf [Handler] that translates Shelf [Request]s to rpc's
/// [HttpApiRequest] executes the request on the given [ApiServer] and then
/// translates the returned rpc's [HttpApiResponse] to a Shelf [Response].
shelf.Handler createRpcHandler(ApiServer apiServer) {
  return (shelf.Request request) {
    try {
      var apiRequest = new HttpApiRequest(request.method, request.requestedUri,
          request.headers, request.read());
      return apiServer.handleHttpApiRequest(apiRequest).then(
              (apiResponse) {

                Map<String, String> dynamicToStringHeaders = new Map();

                // To correct the inconsistence, dynamic value to String value;

                apiResponse.headers.forEach((f, g) => dynamicToStringHeaders.putIfAbsent(f, () => g.toString()));




/*
            return new shelf.Response(apiResponse.status, body: apiResponse.body,
                headers: apiResponse.headers);
  */


                return new shelf.Response(apiResponse.status, body: apiResponse.body, headers: dynamicToStringHeaders);


          });
    } catch (e) {
      // Should never happen since the apiServer.handleHttpRequest method
      // always returns a response.
      print('${e.runtimeType}, ${e}');
      return new shelf.Response.internalServerError(body: e.toString());
    }
  };
}

// reference: https://github.com/butlermatt/basic-error
/*
shelf.Middleware authenticateApiCliente2() =>
  (innerHandler) {
    return (request) {
      var aHeader = request.headers['authorization'];
      print('Auth: $aHeader');
      if (aHeader == null) {
        var resp = new shelf.Response(
            HttpStatus.unauthorized, body: 'unauthorized',
            headers: {'www-authenticate': 'Basic realm="superRealm"'});
        return resp;
      }

      var auth = aHeader.split(' ');
      if (auth[0] != 'Basic') {
        return new shelf.Response(HttpStatus.unauthorized, body: 'unauthorized',
            headers: {'www-authenticate': 'Basic realm="superRealm"'});
      }

      var userInfo = utf8.decode(base64.decode(auth[1]));
      if (userInfo != 'muka:123') {
        return new shelf.Response(HttpStatus.unauthorized, body: 'unauthorized',
            headers: {'www-authenticate': 'Basic realm="superRealm"'});
      }


      var reqBody = request.readAsString();
      print('Body was: $reqBody');
      return new shelf.Response.ok(
          'Request for "${request.url}"\nBody: $reqBody');
    };
  };
  */


/// Middleware which adds [CORS headers](https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS)
/// to shelf responses. Also handles preflight (OPTIONS) requests.
shelf.Middleware createCorsHeadersMiddleware({Map<String, String> corsHeaders}) {
  if (corsHeaders == null) {
    // By default allow access from everywhere.
    corsHeaders = {'Access-Control-Allow-Origin': '*'};
  }

  // Handle preflight (OPTIONS) requests by just adding headers and an empty
  // response.
  shelf.Response handleOptionsRequest(shelf.Request request) {
    if (request.method == 'OPTIONS') {
      return new shelf.Response.ok(null, headers: corsHeaders);
    } else {
      return null;
    }
  }

  shelf.Response addCorsHeaders(shelf.Response response) => response.change(headers: corsHeaders);

  return shelf.createMiddleware(requestHandler: handleOptionsRequest, responseHandler: addCorsHeaders);
}


// TODO (Levius) review CORS definition and a better form to implement authorization (if exists)

/// Authorization Middleware
shelf.Middleware auth(basicAuth) {

  // Handle preflight (OPTIONS) requests by just adding headers and an empty
  // response.
  shelf.Response handleRequest(shelf.Request request) {

    if (request.headers['authorization'] != basicAuth) {
      return new shelf.Response(HttpStatus.unauthorized, body: 'unauthorized' /*,
          headers: {'www-authenticate': 'Basic realm="superRealm"'} */);
    } else {
      return null;
    }
  }

 /* shelf.Response addCorsHeaders(shelf.Response response) => response; */

  return shelf.createMiddleware(requestHandler: handleRequest /*, responseHandler: addCorsHeaders */);
}