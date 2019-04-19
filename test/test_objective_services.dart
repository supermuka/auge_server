import 'package:test/test.dart';

import 'package:grpc/grpc.dart';

import 'package:auge_server/src/protos/generated/google/protobuf/empty.pb.dart';

import 'package:auge_server/src/protos/generated/general/common.pb.dart';
import 'package:auge_server/src/protos/generated/general/organization.pb.dart';
import 'package:auge_server/src/protos/generated/general/history_item.pb.dart';
import 'package:auge_server/src/protos/generated/general/organization.pbgrpc.dart';
import 'package:auge_server/src/protos/generated/general/user.pbgrpc.dart';

import 'package:auge_server/src/protos/generated/objective/objective.pbgrpc.dart';
import 'package:auge_server/src/protos/generated/objective/measure.pbgrpc.dart';

void main() {

  group('Test Objective Module Services.', ()
  {

    ClientChannel channel;
    OrganizationServiceClient organizationStub;
    UserServiceClient userStub;
    ObjectiveServiceClient objectiveStub;
    MeasureServiceClient measureStub;

    String id;
    String organizationId;
    String userId;
    String objectiveId;
    String measureId;

    setUp(() async {
      channel = ClientChannel('localhost',
          port: 50051,
          options: const ChannelOptions(
              credentials: const ChannelCredentials.insecure()));

      organizationStub = new OrganizationServiceClient(channel);
      userStub = new UserServiceClient(channel);
      objectiveStub = new ObjectiveServiceClient(channel);
      measureStub = new MeasureServiceClient(channel);

    });

    tearDown(() async {
      await channel.shutdown();
    });

    group('Organization Service.', () {
      test('Call operation getOrganizations', () async {
        OrganizationsResponse organizationsResponse = await organizationStub
            .getOrganizations(OrganizationGetRequest());
        expect(organizationsResponse.organizations, isNotNull);

        if (organizationsResponse.organizations.length != 0)
          organizationId = organizationsResponse.organizations.first.id;
      });
    });

    group('User Service.', () {
      test('Call operation getUsers', () async {
        UsersResponse usersResponse = await userStub
            .getUsers(UserGetRequest());
        expect(usersResponse.users, isNotNull);
        if (usersResponse.users.length != 0)
          userId = usersResponse.users.first.id;

      });
    });

    group('Objective Service.', () {
      test('Call operation getObjectives', () async {
        ObjectivesResponse objectivesResponse = await objectiveStub
            .getObjectives(ObjectiveGetRequest()
          ..organizationId = organizationId);
        expect(objectivesResponse.objectives, isNotEmpty);

        if (objectivesResponse.objectives.length != 0)
          id = objectivesResponse.objectives.first.id;
      });

      test('Call operation getOrganization', () async {
        Objective objective = await objectiveStub
            .getObjective(ObjectiveGetRequest()
          ..id = id);
        expect(objective, isNotNull);
      });

      String name = 'Unit test';
      String description = 'Description test';

      test('Call operation createObjective', () async {
        IdResponse idResponsePb = await objectiveStub
            .createObjective(Objective()
          ..name = name
          ..description = description
          ..organization = (Organization()..id = organizationId)
          ..historyItemLog = (HistoryItem()..user = (User()..id = userId)..changedValues.putIfAbsent('id',() => 'f9ea90d6-79ab-42c2-b238-0323c4b20a78')));
        expect(idResponsePb.hasId(), isTrue);

        id = idResponsePb.id;

        Objective objective = await objectiveStub
            .getObjective(ObjectiveGetRequest()
          ..id = id);

        expect(objective, isNotNull);
        expect(objective.id, id);
        expect(objective.name, name);
        expect(objective.description, description);
      });

      name = 'Unit test 2';
      description = 'Description test 2';

      test('Call operation updateObjective', () async {
        await objectiveStub
          ..updateObjective(Objective()
            ..id = id
            ..name = name
            ..description = description
            ..organization = (Organization()..id = organizationId)
            ..archived = false
            ..isDeleted = false
            ..historyItemLog = (HistoryItem()..user = (User()..id = userId)..changedValues.putIfAbsent('id',() => 'f9ea90d6-79ab-42c2-b238-0323c4b20a78')));

        Objective objective = await objectiveStub
            .getObjective(ObjectiveGetRequest()
          ..id = id);

        expect(objective, isNotNull);
        expect(objective.id, id);
        expect(objective.name, name);
        expect(objective.description, description);
      });

      test('Call operation softDeleteObjective', () async {
        Empty emptyPb = await objectiveStub
            .softDeleteObjective(Objective()
          ..id = id
          ..version = 1
          ..historyItemLog = (HistoryItem()..user = (User()..id = userId)..changedValues.putIfAbsent('id',() => 'f9ea90d6-79ab-42c2-b238-0323c4b20a78')));

        expect(emptyPb, isNotNull);

        try {
          Objective objective = await objectiveStub
              .getObjective(ObjectiveGetRequest()
            ..id = id);

          expect(objective, isNull);
        } on GrpcError catch (e) {
          expect(e.code, StatusCode.notFound);
        }
      });
    });

    group('Measure Service.', () {

      String name = 'Unit test';
      String description = 'Description test';

      test('Call operation createObjective to measure', () async {
        IdResponse idResponsePb = await objectiveStub
            .createObjective(Objective()
          ..name = name
          ..description = description
          ..organization = (Organization()..id = organizationId)
          ..historyItemLog = (HistoryItem()..user = (User()..id = userId)..changedValues.putIfAbsent('id',() => 'f9ea90d6-79ab-42c2-b238-0323c4b20a78')));
        expect(idResponsePb.hasId(), isTrue);

        objectiveId = idResponsePb.id;
      });

      name = 'Unit test';
      description = 'Description test';

      test('Call operation createMeasure', () async {

        IdResponse idResponsePb = await measureStub
            .createMeasure(Measure()
          ..name = name
          ..description = description
          ..objectiveId = objectiveId
          ..historyItemLog = (HistoryItem()..user = (User()..id = userId)..changedValues.putIfAbsent('id',() => 'f9ea90d6-79ab-42c2-b238-0323c4b20a78')));
        expect(idResponsePb.hasId(), isTrue);

        id = idResponsePb.id;

        Measure measure = await measureStub
            .getMeasure(MeasureGetRequest()
          ..id = id);

        expect(measure, isNotNull);
        expect(measure.id, id);
        expect(measure.name, name);
        expect(measure.description, description);
      });

      test('Call operation getMeasures', () async {
        MeasuresResponse measuresResponse = await measureStub
            .getMeasures(MeasureGetRequest()
          ..objectiveId = objectiveId);
        expect(measuresResponse.measures, isNotEmpty);

        if (measuresResponse.measures.length != 0)
          id = measuresResponse.measures.first.id;
      });

      test('Call operation getMeasure', () async {
        Measure measure = await measureStub
            .getMeasure(MeasureGetRequest()
          ..id = id);
        expect(measure, isNotNull);
      });

      name = 'Unit test';
      description = 'Description test';

      test('Call operation createMeasure', () async {
        IdResponse idResponsePb = await measureStub
            .createMeasure(Measure()
          ..name = name
          ..description = description
          ..objectiveId = objectiveId
          ..historyItemLog = (HistoryItem()..user = (User()..id = userId)..changedValues.putIfAbsent('id',() => 'f9ea90d6-79ab-42c2-b238-0323c4b20a78')));
        expect(idResponsePb.hasId(), isTrue);

        id = idResponsePb.id;

        measureId = id;

        Measure measure = await measureStub
            .getMeasure(MeasureGetRequest()
          ..id = id);

        expect(measure, isNotNull);
        expect(measure.id, id);
        expect(measure.name, name);
        expect(measure.description, description);
      });

      name = 'Unit test 2';
      description = 'Description test 2';

      test('Call operation updateMeasure', () async {
        await measureStub
          ..updateMeasure(Measure()
            ..id = id
            ..name = name
            ..description = description
            ..objectiveId = objectiveId
            ..isDeleted = false
            ..historyItemLog = (HistoryItem()..user = (User()..id = userId)..changedValues.putIfAbsent('id',() => 'f9ea90d6-79ab-42c2-b238-0323c4b20a78')));

        Measure measure = await measureStub
            .getMeasure(MeasureGetRequest()
          ..id = id);

        expect(measure, isNotNull);
        expect(measure.id, id);
        expect(measure.name, name);
        expect(measure.description, description);
      });

      // MeasureProgress
      String comment = 'Unit test';

      test('Call operation createMeasureProgress', () async {
        IdResponse idResponsePb = await measureStub
            .createMeasureProgress(MeasureProgress()
          ..comment = comment
          ..measureId = measureId
          ..historyItemLog = (HistoryItem()..user = (User()..id = userId)..changedValues.putIfAbsent('id',() => 'f9ea90d6-79ab-42c2-b238-0323c4b20a78')));
        expect(idResponsePb.hasId(), isTrue);

        id = idResponsePb.id;

        MeasureProgress measureProgress = await measureStub
            .getMeasureProgress(MeasureProgressGetRequest()
          ..id = id);

        expect(measureProgress, isNotNull);
        expect(measureProgress.id, id);
        expect(measureProgress.comment, comment);
      });

      /*
      comment = 'Unit test 2';

      test('Call operation updateMeasureProgress', () async {
        await measureStub
          ..updateMeasureProgress(MeasureProgressRequest()
            ..id = id
            ..comment = comment
            ..isDeleted = false
            ..historyItemLog = (HistoryItemRequest()..userId = userId..changedValues.putIfAbsent('id',() => 'f9ea90d6-79ab-42c2-b238-0323c4b20a78')));

        MeasureProgress measureProgress = await measureStub
            .getMeasureProgress(MeasureProgressGetRequest()
          ..id = id);

        expect(measureProgress, isNotNull);
        expect(measureProgress.id, id);
        expect(measureProgress.comment, comment);
      });

      test('Call operation softDeleteMeasureProgress', () async {
        Empty emptyPb = await measureStub
            .softDeleteMeasureProgress(MeasureProgressRequest()
          ..id = id
          ..version = 1
          ..historyItemLog = (HistoryItemRequest()..userId = userId..changedValues.putIfAbsent('id',() => 'f9ea90d6-79ab-42c2-b238-0323c4b20a78')));

        expect(emptyPb, isNotNull);

        try {
          MeasureProgress measureProgress = await measureStub
              .getMeasureProgress(MeasureProgressGetRequest()
            ..id = id);

          expect(measureProgress, isNull);
        } on GrpcError catch (e) {
          expect(e.code, StatusCode.notFound);
        }
      });

      test('Call operation deleteMeasureProgress', () async {
        Empty emptyPb = await measureStub
            .deleteMeasureProgress(MeasureProgressRequest()
          ..id = id);

        expect(emptyPb, isNotNull);

        try {
          MeasureProgress measureProgress = await measureStub
              .getMeasureProgress(MeasureProgressGetRequest()
            ..id = id
            ..isDeleted = true);

          expect(measureProgress, isNull);
        } on GrpcError catch (e) {
          expect(e.code, StatusCode.notFound);
        }
      });

      test('Call operation softDeleteMeasure', () async {
        Empty emptyPb = await measureStub
            .softDeleteMeasure(MeasureRequest()
          ..id = id
          ..version = 1
          ..historyItemLog = (HistoryItemRequest()..userId = userId..changedValues.putIfAbsent('id',() => 'f9ea90d6-79ab-42c2-b238-0323c4b20a78')));

        expect(emptyPb, isNotNull);

        try {
          Measure measure = await measureStub
              .getMeasure(MeasureGetRequest()
            ..id = id);
          expect(measure, isNull);
        } on GrpcError catch (e) {
          expect(e.code, StatusCode.notFound);
        }
      });

      test('Call operation deleteMeasure', () async {
        Empty emptyPb = await measureStub
            .deleteMeasure(MeasureRequest()
          ..id = id);

        expect(emptyPb, isNotNull);

        try {
          Measure measure = await measureStub
              .getMeasure(MeasureGetRequest()
            ..id = id
            ..isDeleted = true);

          expect(measure, isNull);
        } on GrpcError catch (e) {
          expect(e.code, StatusCode.notFound);
        }
      });

      test('Call operation softDeleteObjective', () async {
        Empty emptyPb = await objectiveStub
            .softDeleteObjective(ObjectiveRequest()
          ..id = id
          ..version = 1
          ..historyItemLog = (HistoryItemRequest()..userId = userId..changedValues.putIfAbsent('id',() => 'f9ea90d6-79ab-42c2-b238-0323c4b20a78')));

        expect(emptyPb, isNotNull);

        try {
          Objective objective = await objectiveStub
              .getObjective(ObjectiveGetRequest()
            ..id = id);
          expect(objective, isNull);
        } on GrpcError catch (e) {
          expect(e.code, StatusCode.notFound);
        }
      });

      test('Call operation deleteObjective', () async {
        Empty emptyPb = await objectiveStub
            .deleteObjective(ObjectiveRequest()
          ..id = id);

        expect(emptyPb, isNotNull);

        try {
          Objective objective = await objectiveStub
              .getObjective(ObjectiveGetRequest()
            ..id = id
            ..isDeleted = true);

          expect(objective, isNull);
        } on GrpcError catch (e) {
          expect(e.code, StatusCode.notFound);
        }
      });
*/
    });

  });
}