import 'package:test/test.dart';

import 'package:auge_server/src/protos/generated/general/organization.pb.dart' as organization_pb;
import 'package:auge_server/src/protos/generated/general/user.pb.dart' as user_pb;
import 'package:auge_server/src/protos/generated/general/user_profile_organization.pb.dart' as user_profile_organization_pb;
import 'package:auge_server/src/protos/generated/general/group.pb.dart' as group_pb;

import 'package:auge_server/model/general/organization.dart' as organization_m;
import 'package:auge_server/model/general/user.dart' as user_m;
import 'package:auge_server/model/general/user_profile_organization.dart' as user_profile_organization_m;
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
        model.password = '123456789';
        model.eMail = 'test@levius.com.br';
        model.userProfile = user_m.UserProfile();
        model.userProfile.idiomLocale = 'pt_BR';
        model.userProfile.image = 'BASE64IMAGE';
        model.userProfile.isSuperAdmin = true;

      });

      void callExcept() {
        expect(model.id, equals(proto.id));
        expect(model.version, equals(proto.version));
        expect(model.name, equals(proto.name));
        expect(model.password, equals(proto.password));
        expect(model.eMail, equals(proto.eMail));
        expect(model.userProfile.idiomLocale, equals(proto.userProfile.idiomLocale));
        expect(model.userProfile.image, equals(proto.userProfile.image));
        expect(model.userProfile.isSuperAdmin, equals(proto.userProfile.isSuperAdmin));
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
        expect(m[user_m.User.passwordField], equals(proto.password));
        expect(m[user_m.User.eMailField], equals(proto.eMail));
        expect(m[user_m.User.userProfileField][user_m.UserProfile.idiomLocaleField], equals(proto.userProfile.idiomLocale));
        expect(m[user_m.User.userProfileField][user_m.UserProfile.imageField], equals(proto.userProfile.image));
        expect(m[user_m.User.userProfileField][user_m.UserProfile.isSuperAdminField], equals(proto.userProfile.isSuperAdmin));
      });
    });

    group('User Profile Organization.', () {

      user_profile_organization_m.UserProfileOrganization model = user_profile_organization_m.UserProfileOrganization();
      user_profile_organization_pb.UserProfileOrganization proto;

      void callExcept() {
        expect(model.id, equals(proto.id));
        expect(model.version, equals(proto.version));
        expect(model.authorizationRole, equals(proto.authorizationRole));
        expect(model.organization.id, equals(proto.organization.id));
        expect(model.user.id, equals(proto.user.id));
      }

      setUp(() {
        model.id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.version = 0;
        model.authorizationRole = 0;
        model.organization = organization_m.Organization()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.user = user_m.User()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
      });

      test('UserProfileOrganization entity. Call writeToProtoBuf.', () async {
        proto = model.writeToProtoBuf();
        callExcept();
      });

      test('UserProfileOrganization entity. Call readToProtoBuf.', () async {
        model = user_profile_organization_m.UserProfileOrganization();
        model.readFromProtoBuf(proto);
        callExcept();
      });

      test('UserProfileOrganization entity. Call fromProtoBufToModelMap', () async {
        Map<String, dynamic> m = user_profile_organization_m.UserProfileOrganization.fromProtoBufToModelMap(proto);
        expect(m[user_profile_organization_m.UserProfileOrganization.idField], equals(proto.id));
        expect(m[user_profile_organization_m.UserProfileOrganization.versionField], equals(proto.version));
        expect(m[user_profile_organization_m.UserProfileOrganization.userField][user_m.User.idField], equals(proto.user.id));
        expect(m[user_profile_organization_m.UserProfileOrganization.organizationField][organization_m.Organization.idField], equals(proto.organization.id));
      });
    });

    group('Group.', () {

      group_m.Group model = group_m.Group();
      group_pb.Group proto;

      setUp(() {

        model.id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.version = 0;
        model.name = 'Unit Test Group';
        model.active = true;
        model.organization = organization_m.Organization()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.groupType = group_m.GroupType()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.superGroup = group_m.Group()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.leader = user_m.User()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.members.add(user_m.User()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e');

      });

      void callExcept() {
        expect(model.id, equals(proto.id));
        expect(model.version, equals(proto.version));
        expect(model.name, equals(proto.name));
        expect(model.active, equals(proto.active));
        expect(model.organization.id, equals(proto.organization.id));
        expect(model.groupType.id, equals(proto.groupType.id));
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
        model.readFromProtoBuf(proto);

        callExcept();

      });

      test('Group entity. Call fromProtoBufToModelMap', () async {
        Map<String, dynamic> m = group_m.Group.fromProtoBufToModelMap(proto);
        expect(m[group_m.Group.idField], equals(proto.id));
        expect(m[group_m.Group.versionField], equals(proto.version));
        expect(m[group_m.Group.nameField], equals(proto.name));
        expect(m[group_m.Group.activeField], equals(proto.active));
        expect(m[group_m.Group.organizationField][organization_m.Organization.idField], equals(proto.organization.id));
        expect(m[group_m.Group.groupTypeField][group_m.GroupType.idField], equals(proto.groupType.id));
        expect(m[group_m.Group.superGroupField][group_m.Group.idField], equals(proto.superGroup.id));
        expect(m[group_m.Group.leaderField][user_m.User.idField], equals(proto.leader.id));
        expect(m[group_m.Group.membersField].first[user_m.User.idField], equals(proto.members.first.id));
      });

      test('GroupType entity. Call writeToProtoBuf and readToProtoBuf.', () async {

        group_m.GroupType model = group_m.GroupType();

        model.id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.name = 'Unit Test GroupType';

        group_pb.GroupType proto;

        void callExcept() {
          expect(model.id, equals(proto.id));
          expect(model.name, equals(proto.name));
        }

        proto = model.writeToProtoBuf();

        callExcept();

        model = group_m.GroupType();
        model.readFromProtoBuf(proto);

        callExcept();

      });
    });
  });
}