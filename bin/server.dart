// Copyright (c) 2018, the gRPC project authors. Please see the AUTHORS file
// for details. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// Dart implementation of the gRPC helloworld.Greeter server.
///

import 'dart:async';

import 'package:grpc/grpc.dart';

import 'package:auge_server/src/service/general/common_service.dart';
import 'package:auge_server/src/service/general/history_item_service.dart';
import 'package:auge_server/src/service/general/organization_service.dart';
import 'package:auge_server/src/service/general/organization_configuration_service.dart';
import 'package:auge_server/src/service/general/organization_directory_service_service.dart';
import 'package:auge_server/src/service/general/user_service.dart';
import 'package:auge_server/src/service/general/user_identity_service.dart';
import 'package:auge_server/src/service/general/user_access_service.dart';
import 'package:auge_server/src/service/general/group_service.dart';
import 'package:auge_server/src/service/objective/objective_service.dart';
import 'package:auge_server/src/service/objective/measure_service.dart';
import 'package:auge_server/src/service/work/work_service.dart';
import 'package:auge_server/src/service/work/state_service.dart';
import 'package:auge_server/src/service/work/work_stage_service.dart';
import 'package:auge_server/src/service/work/work_item_service.dart';

/*
final Interceptor interceptor = (call, method) {

  if (method.name == "Unary") {
    return null;
  }
  return GrpcError.unauthenticated('Request is unauthenticated');
};

 */

Future<void> main(List<String> args) async {
/*
  ServerTlsCredentials serverTlsCredentials;

  final String certificateFile = '/etc/auge_server/certificate/cert.pem';
  final String privateKeyFile = '/etc/auge_server/certificate/privkey.pem';

  if (await File(certificateFile).exists() && await File(privateKeyFile).exists()) {
    final certificate = File(certificateFile).readAsBytesSync();

    final privateKey = File(privateKeyFile).readAsBytesSync();

    serverTlsCredentials = ServerTlsCredentials(
        certificate: certificate, privateKey: privateKey);

    print('Certificate and private key found.');
  } else {
    print('Certificate and/or private key not found.');
  }
*/
  final server = Server([
    CommonService(),
    OrganizationService(),
    OrganizationConfigurationService(),
    OrganizationDirectoryServiceService(),
    HistoryItemService(),
    UserService(),
    UserIdentityService(),
    UserAccessService(),
    GroupService(),
    ObjectiveService(),
    MeasureService(),
    StateService(),
    WorkStageService(),
    WorkService(),
    WorkItemService()]);
  await server.serve(port: 9091 /*, security: serverTlsCredentials */);

  print('Server listening on port ${server.port}...');
}
