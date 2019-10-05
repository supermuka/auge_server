import 'package:test/test.dart';

import 'package:grpc/grpc.dart';


import 'package:auge_server/src/protos/generated/google/protobuf/wrappers.pb.dart';
import 'package:auge_server/src/protos/generated/general/organization.pb.dart';
import 'package:auge_server/src/protos/generated/general/organization.pbgrpc.dart';
import 'package:auge_server/src/protos/generated/general/user.pbgrpc.dart';

import 'package:auge_server/src/protos/generated/work/work_work_item.pbgrpc.dart';
import 'package:auge_server/src/protos/generated/work/work_stage.pbgrpc.dart';
import 'package:auge_server/src/protos/generated/general/group.pbgrpc.dart';

import 'package:auge_server/model/general/group.dart' as group_m;

void main() {

  group('Test Work Module Services.', ()
  {
    ClientChannel channel;
    OrganizationServiceClient organizationStub;
    UserServiceClient userStub;
    WorkStageServiceClient stageStub;
    WorkServiceClient workStub;
    GroupServiceClient groupStub;
    WorkItemServiceClient workItemStub;

    String id;
    String organizationId;
    String userId;
    String workId;
    String stateId;
    String stageId;
    String groupId;
    String workItemId;
    WorkStage workStage;

    setUp(() async {
      channel = ClientChannel('localhost',
          port: 50051,
          options: const ChannelOptions(
              credentials: const ChannelCredentials.insecure()));

      organizationStub = OrganizationServiceClient(channel);
      userStub = UserServiceClient(channel);
      stageStub = WorkStageServiceClient(channel);
      workStub = WorkServiceClient(channel);
      groupStub = GroupServiceClient(channel);
      workItemStub = WorkItemServiceClient(channel);
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

    group('Group Service.', () {
      test('Call operation getGroups', () async {
        GroupsResponse groupsResponse = await groupStub
            .getGroups(GroupGetRequest()
          ..organizationId = organizationId);

        expect(groupsResponse.groups, isNotNull);
        expect(groupsResponse.groups.length, greaterThanOrEqualTo(1));

        groupId = groupsResponse.groups.first.id;
      });
    });

    group('Work and WorkItem Service.', ()
    {
      String name = 'Unit test';
      String description = 'Description test';

      test('Call operation createWork', () async {

        StringValue idResponsePb = await workStub
            .createWork(WorkRequest()..work = (Work()
          ..name = name
          ..description = description
          ..organization = (Organization()
            ..id = organizationId)
          ..group = (Group()
            ..id = groupId)
          ..leader = (User()
            ..id = userId)
          ..workStages.add(WorkStage()
            ..id = 'f9ea90d6-79ab-42c2-b238-0323c4b20a78'
            ..name = 'Test Stage'
            ..stateIndex = group_m.GroupType.businessUnit.index)));

        expect(idResponsePb.hasValue(), isTrue);

        id = idResponsePb.value;
        workId = id;
      });

      test('Call operation getWork', () async {
        Work work = await workStub
            .getWork(WorkGetRequest()
          ..id = id);
        expect(work, isNotNull);

        expect(work, isNotNull);
        expect(work.id, id);
        expect(work.name, name);
        expect(work.description, description);

        workStage = work.workStages.first;
      });

      test('Call operation getWorks', () async {
        WorksResponse worksResponse = await workStub
            .getWorks(WorkGetRequest()
          ..organizationId = organizationId);

        expect(worksResponse.works, isNotEmpty);
        expect(worksResponse.works.length, greaterThanOrEqualTo(1));
      });


      test('Call operation updateWork', () async {
        name = 'Unit test 2';
        description = 'Description test 2';

        await workStub
          ..updateWork(WorkRequest()..work = (Work()
            ..id = workId
            ..name = name
            ..description = description
            ..organization = (Organization()
              ..id = organizationId)));

        Work work = await workStub
            .getWork(WorkGetRequest()
          ..id = workId);

        expect(work, isNotNull);
        expect(work.id, workId);
        expect(work.name, name);
        expect(work.description, description);
      });

      test('Call operation getStages', () async {
        WorkStagesResponse stagesResponse = await stageStub
            .getWorkStages(WorkStageGetRequest()
          ..workId = workId);
        expect(stagesResponse.workStages, isNotNull);

        if (stagesResponse.workStages.length != 0)
          stageId = stagesResponse.workStages.first.id;
      });

      test('Call operation getStage', () async {
        WorkStage workStage = await stageStub
            .getWorkStage(WorkStageGetRequest()
          ..id = stageId);
        expect(workStage.id, isNotNull);
        expect(workStage.id, stageId);
      });

      test('Call operation createWorkItem', () async {
        name = 'Unit test';
        description = 'Description test';

        StringValue idResponsePb = await workItemStub
            .createWorkItem(WorkItemRequest()..workItem = (WorkItem()
          ..name = name
          ..description = description
          ..checkItems.add(WorkItemCheckItem()
            ..id = 'f9ea90d6-79ab-42c2-b238-0323c4b20a78'
            ..name = 'Check Item Test')
          ..workStage = workStage)..workId = workId);

        expect(idResponsePb.hasValue(), isTrue);

        workItemId = idResponsePb.value;

      });

      test('Call operation getWorkItem', () async {
        WorkItem workItem = await workItemStub
            .getWorkItem(WorkItemGetRequest()
          ..id = workItemId);
        expect(workItem, isNotNull);

        expect(workItem.id, workItem.id);
        expect(workItem.name, name);
        expect(workItem.description, description);
      });

      test('Call operation getWorkItems', () async {
        WorkItemsResponse workItemsResponse = await workItemStub
            .getWorkItems(WorkItemGetRequest()
          ..workId = workId);

        expect(workItemsResponse.workItems, isNotEmpty);
        expect(workItemsResponse.workItems.length, greaterThanOrEqualTo(1));
      });

      test('Call operation updateWorkItem', () async {
        name = 'Unit test 2';
        description = 'Description test 2';

        await workItemStub
          ..updateWorkItem(WorkItemRequest()..workItem = (WorkItem()
            ..id = workItemId
            ..version = 0
            ..name = name
            ..description = description
            ..workStage = workStage)..workId = workId);

        WorkItem workItem = await workItemStub
            .getWorkItem(WorkItemGetRequest()
          ..id = workItemId);

        expect(workItem, isNotNull);
        expect(workItem.id, workItemId);
        expect(workItem.name, name);
        expect(workItem.description, description);
      });
    });
  });
}