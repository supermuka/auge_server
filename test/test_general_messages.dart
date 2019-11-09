import 'package:test/test.dart';

import 'package:auge_server/src/protos/generated/general/organization.pb.dart' as organization_pb;
import 'package:auge_server/src/protos/generated/general/user.pb.dart' as user_pb;
import 'package:auge_server/src/protos/generated/general/user_access.pb.dart' as user_access_pb;
import 'package:auge_server/src/protos/generated/general/group.pb.dart' as group_pb;

import 'package:auge_server/model/general/organization.dart' as organization_m;
import 'package:auge_server/model/general/user.dart' as user_m;
import 'package:auge_server/model/general/user_access.dart' as user_access_m;
import 'package:auge_server/model/general/group.dart' as group_m;

void main() {

  group('Test General Messages.', () {

    organization_m.Organization model = organization_m.Organization();
    organization_pb.Organization proto;

    setUp(() {
      model.id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
      model.version = 0;
      model.name = 'Name test';
      model.code = '00.000.0000/000';
    });

    tearDown(() async {
    });

    group('Organization.', () {

      void callExcept() {
        expect(model.id, equals(proto.id));
        expect(model.version, equals(proto.version));
        expect(model.name, equals(proto.name));
        expect(model.code, equals(proto.code));
      }

      test('Organization entity. Call writeToProtoBuf.', () async {

        proto = model.writeToProtoBuf();

        callExcept();

      });

      test('Organization entity. Call readToProtoBuf.', () async {

        model = organization_m.Organization();
        model.readFromProtoBuf(proto);

        callExcept();

      });

      test('Organization entity. Call fromProtoBufToModelMap', () async {
        Map<String, dynamic> m = organization_m.Organization.fromProtoBufToModelMap(proto);
        expect(m[organization_m.Organization.idField], equals(proto.id));
        expect(m[organization_m.Organization.versionField], equals(proto.version));
        expect(m[organization_m.Organization.nameField], equals(proto.name));
        expect(m[organization_m.Organization.codeField], equals(proto.code));
      });

    });

    group('User.', () {

      user_m.User model = user_m.User();
      user_pb.User proto;

      setUp(() {

        model.id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.version = 0;
        model.name = 'Name test';

        model.userProfile = user_m.UserProfile();
        model.userProfile.idiomLocale = 'pt_BR';
        model.userProfile.image = 'BASE64IMAGE';


      });

      void callExcept() {
        expect(model.id, equals(proto.id));
        expect(model.version, equals(proto.version));
        expect(model.name, equals(proto.name));

        expect(model.userProfile.idiomLocale, equals(proto.userProfile.idiomLocale));
        expect(model.userProfile.image, equals(proto.userProfile.image));

      }

      test('User entity. Call writeToProtoBuf', () async {

        proto = model.writeToProtoBuf();

        callExcept();

      });

      test('User entity. Call fromProtoBufToModelMap', () async {
        Map<String, dynamic> m = user_m.User.fromProtoBufToModelMap(proto);
        expect(m[user_m.User.idField], equals(proto.id));
        expect(m[user_m.User.versionField], equals(proto.version));
        expect(m[user_m.User.nameField], equals(proto.name));

        expect(m[user_m.User.userProfileField][user_m.UserProfile.idiomLocaleField], equals(proto.userProfile.idiomLocale));
        expect(m[user_m.User.userProfileField][user_m.UserProfile.imageField], equals(proto.userProfile.image));

      });
    });

    group('User Profile Organization.', () {

      user_access_m.UserAccess model = user_access_m.UserAccess();
      user_access_pb.UserAccess proto;

      void callExcept() {
        expect(model.id, equals(proto.id));
        expect(model.version, equals(proto.version));
        expect(model.accessRole, equals(proto.accessRole));
        expect(model.organization.id, equals(proto.organization.id));
        expect(model.user.id, equals(proto.user.id));
      }

      setUp(() {
        model.id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.version = 0;
        model.accessRole = 0;
        model.organization = organization_m.Organization()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.user = user_m.User()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
      });

      test('UserProfileOrganization entity. Call writeToProtoBuf.', () async {
        proto = model.writeToProtoBuf();
        callExcept();
      });

      test('UserProfileOrganization entity. Call readToProtoBuf.', () async {
        model = user_access_m.UserAccess();
        model.readFromProtoBuf(proto, {});
        callExcept();
      });

      test('UserProfileOrganization entity. Call fromProtoBufToModelMap', () async {
        Map<String, dynamic> m = user_access_m.UserAccess.fromProtoBufToModelMap(proto);
        expect(m[user_access_m.UserAccess.idField], equals(proto.id));
        expect(m[user_access_m.UserAccess.versionField], equals(proto.version));
        expect(m[user_access_m.UserAccess.userField][user_m.User.idField], equals(proto.user.id));
        expect(m[user_access_m.UserAccess.organizationField][organization_m.Organization.idField], equals(proto.organization.id));
      });
    });

    group('Group.', () {

      group_m.Group model = group_m.Group();
      group_pb.Group proto;

      setUp(() {

        model.id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.version = 0;
        model.name = 'Unit Test Group';
        model.inactive = true;
        model.organization = organization_m.Organization()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.groupType =  group_m.GroupType.businessUnit;
        model.superGroup = group_m.Group()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.leader = user_m.User()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.members.add(user_m.User()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e');

      });

      void callExcept() {
        expect(model.id, equals(proto.id));
        expect(model.version, equals(proto.version));
        expect(model.name, equals(proto.name));
        expect(model.inactive, equals(proto.inactive));
        expect(model.organization.id, equals(proto.organization.id));
        expect(model.groupType.index, equals(proto.groupTypeIndex));
        expect(model.superGroup.id, equals(proto.superGroup.id));
        expect(model.leader.id, equals(proto.leader.id));
        expect(model.members.first.id, equals(proto.members.first.id));
      }

      test('Group entity. Call writeToProtoBuf.', () async {

        proto = model.writeToProtoBuf();

        callExcept();

      });

      test('Group entity. Call readToProtoBuf.', () async {

        model = group_m.Group();
        model.readFromProtoBuf(proto, {});

        callExcept();

      });

      test('Group entity. Call fromProtoBufToModelMap', () async {
        Map<String, dynamic> m = group_m.Group.fromProtoBufToModelMap(proto);
        expect(m[group_m.Group.idField], equals(proto.id));
        expect(m[group_m.Group.versionField], equals(proto.version));
        expect(m[group_m.Group.nameField], equals(proto.name));
        expect(m[group_m.Group.inactiveField], equals(proto.inactive));
        expect(m[group_m.Group.organizationField][organization_m.Organization.idField], equals(proto.organization.id));
        expect(m[group_m.Group.groupTypeField][group_m.Group.groupTypeField], equals(proto.groupTypeIndex));
        expect(m[group_m.Group.superGroupField][group_m.Group.idField], equals(proto.superGroup.id));
        expect(m[group_m.Group.leaderField][user_m.User.idField], equals(proto.leader.id));
        expect(m[group_m.Group.membersField].first[user_m.User.idField], equals(proto.members.first.id));
      });

    });
  });
}