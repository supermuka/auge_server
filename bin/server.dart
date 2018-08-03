import 'dart:io';

import 'package:args/args.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;

import 'package:rpc/rpc.dart';

import 'package:auge_server/augeapi.dart';
import 'package:auge_server/initiativeaugeapi.dart';
import 'package:auge_server/objectiveaugeapi.dart';
import 'package:auge_server/augeconf.dart';


const _API_PREFIX = '/'; // '/api';
final ApiServer _apiServer =
  new ApiServer(apiPrefix: _API_PREFIX, prettyPrint: true);

main(List<String> args) async {
  var parser = new ArgParser()
    ..addOption('port', abbr: 'p', defaultsTo: '8091');

  var result = parser.parse(args);

  var port = int.tryParse(result['port']);

  if (port == null) {
    stdout.writeln(
        'Could not parse port value "${result['port']}" into a number.');
    // 64: command line usage error
    exitCode = 64;
    return;
  }

  // RPC
  _apiServer.addApi(new AugeApi());
  _apiServer.addApi(new InitiativeAugeApi());
  _apiServer.addApi(new ObjectiveAugeApi());
  _apiServer.enableDiscoveryApi();

  // Create a Shelf handler for your RPC API.
  var apiHandler = createRpcHandler(_apiServer);

  var handler = const shelf.Pipeline()
      .addMiddleware(shelf.logRequests())
      .addMiddleware(createCorsHeadersMiddleware(corsHeaders: {'Access-Control-Allow-Origin': '*',  'Access-Control-Allow-Methods': '*', 'Access-Control-Allow-Headers': '*'}))
      .addMiddleware(auth(AugeConf.basicAuth))
      .addHandler(apiHandler);

  var server = await io.serve(handler, 'localhost', port);
  print('Serving at http://${server.address.host}:${server.port}');
}

shelf.Response _echoRequest(shelf.Request request) =>
    new shelf.Response.ok('Request for "${request.url}"');

/// shelf_rpc (archived)
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
            return new shelf.Response(apiResponse.status, body: apiResponse.body,
                headers: apiResponse.headers);
          });
    } catch (e) {
      // Should never happen since the apiServer.handleHttpRequest method
      // always returns a response.
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