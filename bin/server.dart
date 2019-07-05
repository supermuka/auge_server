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
import 'dart:async';

import 'package:grpc/grpc.dart';

import 'package:auge_server/src/service/general/common_service.dart';
import 'package:auge_server/src/service/general/history_item_service.dart';
import 'package:auge_server/src/service/general/organization_service.dart';
import 'package:auge_server/src/service/general/user_service.dart';
import 'package:auge_server/src/service/general/user_profile_organization_service.dart';
import 'package:auge_server/src/service/general/group_service.dart';
import 'package:auge_server/src/service/general/organization_configuration_service.dart';
import 'package:auge_server/src/service/objective/objective_service.dart';
import 'package:auge_server/src/service/objective/measure_service.dart';
import 'package:auge_server/src/service/initiative/initiative_service.dart';
import 'package:auge_server/src/service/initiative/state_service.dart';
import 'package:auge_server/src/service/initiative/stage_service.dart';
import 'package:auge_server/src/service/initiative/work_item_service.dart';

Future<void> main(List<String> args) async {
  final server = new Server([
    CommonService(),
    OrganizationService(),
    OrganizationConfigurationService(),
    HistoryItemService(),
    UserService(),
    UserProfileOrganizationService(),
    GroupService(),
    ObjectiveService(),
    MeasureService(),
    StateService(),
    StageService(),
    InitiativeService(),
    WorkItemService()]);
  await server.serve(port: 9091);
  print('Server listening on port ${server.port}...');
}
