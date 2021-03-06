import 'package:auge_shared/domain/general/group.dart' as group_m;
import 'package:auge_shared/protos/generated/general/organization.pb.dart';
import 'package:test/test.dart';

import 'package:grpc/grpc.dart';

import 'package:auge_shared/protos/generated/google/protobuf/empty.pb.dart';
import 'package:auge_shared/protos/generated/google/protobuf/wrappers.pb.dart';
import 'package:auge_shared/protos/generated/general/organization.pbgrpc.dart';
import 'package:auge_shared/protos/generated/general/user.pbgrpc.dart';
import 'package:auge_shared/protos/generated/general/user_access.pbgrpc.dart';
import 'package:auge_shared/protos/generated/general/group.pbgrpc.dart';

import 'package:auge_shared/domain/general/authorization.dart';

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
        StringValue idResponsePb = await stub
            .createOrganization(OrganizationRequest()..organization = (Organization()
          ..name = name
          ..code = code));
        expect(idResponsePb.hasValue(), isTrue);
        id = idResponsePb.value;

      });

      test('Call operation updateOrganization', () async {
        name = 'Unit Test 2';
        code = '123456';

        await stub
            .updateOrganization(OrganizationRequest()..organization = (Organization()
          ..name = name
          ..code = code));

        Organization organizationPb = (await stub.getOrganizations(OrganizationGetRequest()..id = id)).organizations.first;

        expect(organizationPb.name, equals(name));
        expect(organizationPb.code, equals(code));
        expect(organizationPb.name, equals(name));

      });

      test('Call operation deleteOrganization', () async {

        Empty emptyPb = await stub.deleteOrganization(OrganizationDeleteRequest()..organizationId = id);

        expect(emptyPb, isNotNull);
        expect((await stub
              .getOrganizations(OrganizationGetRequest()
            ..id = '86ce1031-3df2-4ea4-9c42-05a0974aec4f' /*id*/)).organizations, isEmpty);

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
/*
      test('Call operation createUser', () async {
        IdResponse idResponsePb = await stub
            .createUser(UserRequest()..user = (User()
          ..name = 'Unit Test'
          ..eMail = 's@levius.com'));
        expect(idResponsePb.hasId(), isTrue);

        id = idResponsePb.id;
      });

      test('Call operation updateUser', () async {
        // Partial data
        String name = 'Unit Test 2';
        String eMail = 'samuel.schwebel@levius.com.br';

        await stub
            .updateUser(UserRequest()..user = (User()
          ..id = id
          ..name = name
          ..eMail = eMail));

        User userPb = await stub.getUser(UserGetRequest()..id = id);

        expect(userPb.name, equals(name));
        expect(userPb.eMail, equals(eMail));

      });

      test('Call operation deleteUser', () async {

        Empty emptyPb = await stub
            .deleteUser(UserRequest()..user = (User()
          ..id = id));

        expect(emptyPb, isNotNull);

        try {

           await stub.getUser(UserGetRequest()..id = id);

        } on GrpcError catch (e) {
          expect(e.code, StatusCode.notFound);
        }
      });

 */
    });

    group('User Organization Access Service.', () {
      UserAccessServiceClient stub;

      setUp(() {
        stub = new UserAccessServiceClient(channel);
      });

      UserAccessesResponse userAccessesResponse;
      test('Call operation getUserAccesses', () async {
        userAccessesResponse = await stub
            .getUserAccesses(UserAccessGetRequest()
          ..organizationId = organizationId);

        expect(userAccessesResponse.userAccesses, isNotNull);
      });

      test('Call operation deleteUserAccesses - all items', () async {
        for (final i in userAccessesResponse.userAccesses) {
          await stub.deleteUserAccess(UserAccessDeleteRequest()
            ..userAccessId = i.id);
        }
      });

      test('Call operation createUserAccess', () async {
        StringValue idResponse = await stub
            .createUserAccess(UserAccessRequest()
          ..userAccess = (UserAccess()
            ..organization = (Organization()
              ..id = organizationId)
            ..user = (User()
              ..id = userId)
            ..accessRole = SystemRole.admin.index));

        expect(idResponse.hasValue(), isTrue);

        id = idResponse.value;
      });

      test('Call operation updateUserProfileOrganization', () async {
        await stub
            .updateUserAccess(UserAccessRequest()
          ..userAccess = (UserAccess()
            ..id = id
            ..organization = (Organization()
              ..id = organizationId)
            ..user = (User()
              ..id = userId)
            ..accessRole = SystemRole.standard.index));
      });

      test('Call operation deleteUserProfileOrganization', () async {
        Empty emptyPb = await stub
            .deleteUserAccess(UserAccessDeleteRequest()
          ..userAccessId = id);

        expect(emptyPb, isNotNull);
        expect((await stub
            .getUserAccesses(UserAccessGetRequest()
          ..id = id)), isEmpty);
      });
    });

    group('Group Service.', ()
    {
      GroupServiceClient stub;

      int groupTypeId = group_m.GroupType.company.index;

      String name = 'Unit Test';
      bool inactive = true;

      setUp(() {
        stub = new GroupServiceClient(channel);

      });


      test('Call operation createGroup', () async {
          StringValue idResponsePb = await stub
            .createGroup(GroupRequest()..group = (Group()
          ..name = 'Unit Test'
          ..inactive = true
          ..organization = (Organization()..id = organizationId)
          ..groupTypeIndex = groupTypeId));

        id = idResponsePb.value;

        Group groupPb = (await stub.getGroups(GroupGetRequest()..id = id)).groups.first;

        expect(groupPb.name, equals(name));
        expect(groupPb.inactive, equals(inactive));
      });

      test('Call operation getGroups', () async {
        GroupsResponse groupsResponse = await stub
            .getGroups(GroupGetRequest()..organizationId = organizationId);

        expect(groupsResponse.groups, isNotNull);
        expect(groupsResponse.groups.length, greaterThanOrEqualTo(1));
      });

      test('Call operation getGroup', () async {
        Group group = (await stub
            .getGroups(GroupGetRequest()..id = id)).groups.first;

        expect(group, isNotNull);
        expect(group.id, id);
        expect(group.name, name);
        expect(group.inactive, inactive);
        expect(group.organization.id, organizationId);
        expect(group.groupTypeIndex, groupTypeId);
      });

      test('Call operation updateGroup', () async {
        // Partial data
        String name = 'Unit Test 2';

        await stub
            .updateGroup(GroupRequest()..group = (Group()
          ..id = id
          ..name = name
          ..inactive = inactive
          ..organization = (Organization()..id = organizationId)
          ..groupTypeIndex = groupTypeId));

        Group groupPb = (await stub.getGroups(GroupGetRequest()..id = id)).groups.first;

        expect(groupPb.name, equals(name));
        expect(groupPb.inactive, equals(inactive));

      });

      test('Call operation deleteGroup', () async {

        Empty emptyPb = await stub
            .deleteGroup(GroupDeleteRequest()..groupId = id);

        expect(emptyPb, isNotNull);
        expect((await stub
            .getGroups(GroupGetRequest()
          ..id = id)).groups.first, isNotEmpty);
/*
        try {
          (await stub
              .getGroups(GroupGetRequest()
            ..id = id)).groups.first;
        } on GrpcError catch (e) {
          expect(e.code, StatusCode.notFound);
        }
        */
      });
    });
  });
}