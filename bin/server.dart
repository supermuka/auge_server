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