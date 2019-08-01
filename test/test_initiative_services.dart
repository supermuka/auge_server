import 'package:test/test.dart';

import 'package:grpc/grpc.dart';

import 'package:auge_server/src/protos/generated/google/protobuf/empty.pb.dart';

import 'package:auge_server/src/protos/generated/google/protobuf/wrappers.pb.dart';
import 'package:auge_server/src/protos/generated/general/organization.pb.dart';
import 'package:auge_server/src/protos/generated/general/organization.pbgrpc.dart';
import 'package:auge_server/src/protos/generated/general/user.pbgrpc.dart';

import 'package:auge_server/src/protos/generated/initiative/initiative.pbgrpc.dart';
import 'package:auge_server/src/protos/generated/initiative/work_item.pbgrpc.dart';
import 'package:auge_server/src/protos/generated/initiative/stage.pbgrpc.dart';
import 'package:auge_server/src/protos/generated/initiative/state.pbgrpc.dart';
import 'package:auge_server/src/protos/generated/general/group.pbgrpc.dart';

void main() {

  group('Test Initiative Module Services.', ()
  {
    ClientChannel channel;
    OrganizationServiceClient organizationStub;
    UserServiceClient userStub;
    StateServiceClient stateStub;
    StageServiceClient stageStub;
    InitiativeServiceClient initiativeStub;
    GroupServiceClient groupStub;
    WorkItemServiceClient workItemStub;

    String id;
    String organizationId;
    String userId;
    String initiativeId;
    String stateId;
    String stageId;
    String groupId;
    String workItemId;
    Stage stage;

    setUp(() async {
      channel = ClientChannel('localhost',
          port: 50051,
          options: const ChannelOptions(
              credentials: const ChannelCredentials.insecure()));

      organizationStub = OrganizationServiceClient(channel);
      userStub = UserServiceClient(channel);
      stateStub = StateServiceClient(channel);
      stageStub = StageServiceClient(channel);
      initiativeStub = InitiativeServiceClient(channel);
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

    group('State Service.', () {
      test('Call operation getStates', () async {
        StatesResponse statesResponse = await stateStub
            .getStates(Empty());
        expect(statesResponse.states, isNotNull);

        if (statesResponse.states.length != 0)
          stateId = statesResponse.states.first.id;
      });

      test('Call operation getState', () async {
         State state = await stateStub
            .getState(StateGetRequest()..id = stateId);
        expect(state.id, isNotNull);
        expect(state.id, stateId);
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

    group('Initiative and WorkItem Service.', ()
    {
      String name = 'Unit test';
      String description = 'Description test';

      test('Call operation createInitiative', () async {

        StringValue idResponsePb = await initiativeStub
            .createInitiative(InitiativeRequest()..initiative = (Initiative()
          ..name = name
          ..description = description
          ..organization = (Organization()
            ..id = organizationId)
          ..group = (Group()
            ..id = groupId)
          ..leader = (User()
            ..id = userId)
          ..stages.add(Stage()
            ..id = 'f9ea90d6-79ab-42c2-b238-0323c4b20a78'
            ..name = 'Test Stage'
            ..state = (State()
              ..id = stateId))));

        expect(idResponsePb.hasValue(), isTrue);

        id = idResponsePb.value;
        initiativeId = id;
      });

      test('Call operation getInitiative', () async {
        Initiative initiative = await initiativeStub
            .getInitiative(InitiativeGetRequest()
          ..id = id);
        expect(initiative, isNotNull);

        expect(initiative, isNotNull);
        expect(initiative.id, id);
        expect(initiative.name, name);
        expect(initiative.description, description);

        stage = initiative.stages.first;
      });

      test('Call operation getInitiatives', () async {
        InitiativesResponse initiativesResponse = await initiativeStub
            .getInitiatives(InitiativeGetRequest()
          ..organizationId = organizationId);

        expect(initiativesResponse.initiatives, isNotEmpty);
        expect(initiativesResponse.initiatives.length, greaterThanOrEqualTo(1));
      });


      test('Call operation updateInitiative', () async {
        name = 'Unit test 2';
        description = 'Description test 2';

        await initiativeStub
          ..updateInitiative(InitiativeRequest()..initiative = (Initiative()
            ..id = initiativeId
            ..name = name
            ..description = description
            ..organization = (Organization()
              ..id = organizationId)));

        Initiative initiative = await initiativeStub
            .getInitiative(InitiativeGetRequest()
          ..id = initiativeId);

        expect(initiative, isNotNull);
        expect(initiative.id, initiativeId);
        expect(initiative.name, name);
        expect(initiative.description, description);
      });

      test('Call operation getStages', () async {
        StagesResponse stagesResponse = await stageStub
            .getStages(StageGetRequest()
          ..initiativeId = initiativeId);
        expect(stagesResponse.stages, isNotNull);

        if (stagesResponse.stages.length != 0)
          stageId = stagesResponse.stages.first.id;
      });

      test('Call operation getStage', () async {
        Stage stage = await stageStub
            .getStage(StageGetRequest()
          ..id = stageId);
        expect(stage.id, isNotNull);
        expect(stage.id, stageId);
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
          ..stage = stage)..initiativeId = initiativeId);

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
          ..initiativeId = initiativeId);

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
            ..stage = stage)..initiativeId = initiativeId);

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