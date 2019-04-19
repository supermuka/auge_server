import 'package:test/test.dart';

import 'package:grpc/grpc.dart';

import 'package:auge_server/src/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_server/src/protos/generated/general/common.pb.dart';
import 'package:auge_server/src/protos/generated/general/organization.pbgrpc.dart';
import 'package:auge_server/src/protos/generated/general/user.pbgrpc.dart';
import 'package:auge_server/src/protos/generated/general/user_profile_organization.pbgrpc.dart';
import 'package:auge_server/src/protos/generated/general/group.pbgrpc.dart';

import 'package:auge_server/model/general/authorization.dart';

void main() {

  group('Test Services.', () {
    ClientChannel channel;

    String id;
    String organizationId;
    String userId;

    setUp(() {
      channel = new ClientChannel('localhost',
        port: 50051,
        options: const ChannelOptions(
            credentials: const ChannelCredentials.insecure()));
    });

    tearDown(() async {
      await channel.shutdown();
    });

    group('Organization Service.', () {
      OrganizationServiceClient stub;

      String name = 'Unit Test';
      String code = '123';

      setUp(() async {
        stub = await new OrganizationServiceClient(channel);
      });

      test('Call operation getOrganizations', () async {

          OrganizationsResponse organizationsResponse = await stub
              .getOrganizations(OrganizationGetRequest());
          expect(organizationsResponse.organizations, isNotNull);

          if (organizationsResponse.organizations.length != 0)
            organizationId = organizationsResponse.organizations.first.id;

      });

      test('Call operation getOrganization', () async {
        OrganizationsResponse organizationsResponse = await stub
            .getOrganizations(OrganizationGetRequest());
        expect(organizationsResponse.organizations.length, isNotNull);
      });

      test('Call operation createOrganization', () async {
        IdResponse idResponsePb = await stub
            .createOrganization(Organization()
          ..name = name
          ..code = code);
        expect(idResponsePb.hasId(), isTrue);
        id = idResponsePb.id;

      });

      test('Call operation updateOrganization', () async {
        name = 'Unit Test 2';
        code = '123456';

        await stub
            .updateOrganization(Organization()
          ..id = id
          ..name = name
          ..code = code);

        Organization organizationPb = await stub.getOrganization(OrganizationGetRequest()..id = id);

        expect(organizationPb.name, equals(name));
        expect(organizationPb.code, equals(code));
        expect(organizationPb.name, equals(name));

      });


      test('Call operation deleteOrganization', () async {

        Empty emptyPb = await stub.deleteOrganization(Organization()
          ..id = id);

        expect(emptyPb, isNotNull);

        try {
          await stub
              .getOrganization(OrganizationGetRequest()
            ..id = '86ce1031-3df2-4ea4-9c42-05a0974aec4f' /*id*/);
        } on GrpcError catch (e) {
            expect(e.code, StatusCode.notFound);
        }
      });
    });

    group('User Service.', () {

      UserServiceClient stub;

      setUp(() {
        stub = new UserServiceClient(channel);
      });

      test('Call operation getUsers', () async {
        UsersResponse usersResponse = await stub
            .getUsers(UserGetRequest() /* ..organizationId = organizationId */);
        expect(usersResponse.users, isNotNull);
        if (usersResponse.users.length != 0) userId = usersResponse.users.first.id;

      });

      test('Call operation createUser', () async {
        IdResponse idResponsePb = await stub
            .createUser(User()
          ..name = 'Unit Test'
          ..eMail = 's@levius.com');
        expect(idResponsePb.hasId(), isTrue);

        id = idResponsePb.id;
      });

      test('Call operation updateUser', () async {
        // Partial data
        String name = 'Unit Test 2';
        String eMail = 'samuel.schwebel@levius.com.br';

        await stub
            .updateUser(User()
          ..id = id
          ..name = name
          ..eMail = eMail);

        User userPb = await stub.getUser(UserGetRequest()..id = id);

        expect(userPb.name, equals(name));
        expect(userPb.eMail, equals(eMail));

      });

      test('Call operation deleteUser', () async {

        Empty emptyPb = await stub
            .deleteUser(User()
          ..id = id);

        expect(emptyPb, isNotNull);

        try {

           await stub.getUser(UserGetRequest()..id = id);

        } on GrpcError catch (e) {
          expect(e.code, StatusCode.notFound);
        }
      });
    });

    group('User Profile Organization Service.', ()
    {
      UserProfileOrganizationServiceClient stub;

      setUp(() {
        stub = new UserProfileOrganizationServiceClient(channel);
      });

      UsersProfileOrganizationsResponse usersProfileOrganizationsResponse;
      test('Call operation getUsersProfileOrganizations', () async {
         usersProfileOrganizationsResponse = await stub
            .getUsersProfileOrganizations(UserProfileOrganizationGetRequest()..organizationId = organizationId);

        expect(usersProfileOrganizationsResponse.usersProfileOrganizations, isNotNull);
      });

      test('Call operation deleteUserProfileOrganization - all items', () async {

        for (final i in usersProfileOrganizationsResponse.usersProfileOrganizations) {
          await stub.deleteUserProfileOrganization(
              UserProfileOrganization()
                ..id = i.id);
        }
      });

      test('Call operation createUserProfileOrganization', () async {

        IdResponse idResponse = await stub
            .createUserProfileOrganization(UserProfileOrganization()
          ..organization = (Organization()..id = organizationId)
          ..user = (User()..id = userId)
          ..authorizationRole = SystemRole.admin.index );

        expect(idResponse.hasId(), isTrue);

        id = idResponse.id;
      });

      test('Call operation updateUserProfileOrganization', () async {

        await stub
            .updateUserProfileOrganization(UserProfileOrganization()
          ..id = id
          ..organization = (Organization()..id = organizationId)
          ..user = (User()..id = userId)
          ..authorizationRole = SystemRole.standard.index );

      });

      test('Call operation deleteUserProfileOrganization', () async {

        Empty emptyPb = await stub
            .deleteUserProfileOrganization(UserProfileOrganization()
          ..id = id);

        expect(emptyPb, isNotNull);

        try {
          UserProfileOrganization userProfileOrganization = await stub
              .getUserProfileOrganization(UserProfileOrganizationGetRequest()
            ..id = id);

          expect(userProfileOrganization, isNotEmpty);

        } on GrpcError catch (e) {
          expect(e.code, StatusCode.notFound);
         // rethrow;
        }
      });

    });

    group('Group Service.', ()
    {
      GroupServiceClient stub;

      String groupTypeId;

      String name = 'Unit Test';
      bool active = true;

      setUp(() {
        stub = new GroupServiceClient(channel);

      });

      test('Call operation getGroupTypes', () async {
        GroupTypesResponse groupTypesResponse = await stub
            .getGroupTypes(Empty());

        expect(groupTypesResponse.groupTypes, isNotNull);

        groupTypeId = groupTypesResponse.groupTypes.first.id;
      });

      test('Call operation createGroup', () async {
          IdResponse idResponsePb = await stub
            .createGroup(Group()
          ..name = 'Unit Test'
          ..active = true
          ..organization = (Organization()..id = organizationId)
          ..groupType = (GroupType()..id = groupTypeId));

        id = idResponsePb.id;

        Group groupPb = await stub.getGroup(GroupGetRequest()..id = id);

        expect(groupPb.name, equals(name));
        expect(groupPb.active, equals(active));
      });

      test('Call operation getGroups', () async {
        GroupsResponse groupsResponse = await stub
            .getGroups(GroupGetRequest()..organizationId = organizationId);

        expect(groupsResponse.groups, isNotNull);
        expect(groupsResponse.groups.length, greaterThanOrEqualTo(1));
      });

      test('Call operation getGroup', () async {
        Group group = await stub
            .getGroup(GroupGetRequest()..id = id);

        expect(group, isNotNull);
        expect(group.id, id);
        expect(group.name, name);
        expect(group.active, active);
        expect(group.organization.id, organizationId);
        expect(group.groupType.id, groupTypeId);
      });

      test('Call operation updateGroup', () async {
        // Partial data
        String name = 'Unit Test 2';
        bool active  = false;

        await stub
            .updateGroup(Group()
          ..id = id
          ..name = name
          ..active = active
          ..organization = (Organization()..id = organizationId)
          ..groupType = (GroupType()..id = groupTypeId));

        Group groupPb = await stub.getGroup(GroupGetRequest()..id = id);

        expect(groupPb.name, equals(name));
        expect(groupPb.active, equals(active));

      });

      test('Call operation deleteGroup', () async {

        Empty emptyPb = await stub
            .deleteGroup(Group()
          ..id = id);

        expect(emptyPb, isNotNull);

        try {
           await stub
              .getGroup(GroupGetRequest()
            ..id = id);
        } on GrpcError catch (e) {
          expect(e.code, StatusCode.notFound);
        }
      });
    });
  });
}