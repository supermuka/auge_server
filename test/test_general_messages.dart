import 'package:test/test.dart';

import 'package:auge_server/src/protos/generated/general/organization.pb.dart' as organization_pb;
import 'package:auge_server/src/protos/generated/general/user_history_item.pb.dart' as user_pb;
import 'package:auge_server/src/protos/generated/general/user_profile_organization.pb.dart' as user_profile_organization_pb;
import 'package:auge_server/src/protos/generated/general/group.pb.dart' as group_pb;

import 'package:auge_server/model/general/organization.dart' as organization_m;
import 'package:auge_server/model/general/user.dart' as user_m;
import 'package:auge_server/model/general/user_profile_organization.dart' as user_profile_organization_m;
import 'package:auge_server/model/general/group.dart' as group_m;

void main() {

  group('Test Messages.', () {

    setUp(() {

    });

    tearDown(() async {

    });

    group('Organization.', () {
      test('Organization entity. Call writeToProtoBuf and readToProtoBuf.', () async {

        organization_m.Organization model = organization_m.Organization();

        model.id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.version = 0;
        model.name = 'Name test';
        model.code = '00.000.0000/000';

        organization_pb.Organization proto;

        void callExcept() {
          expect(model.id, equals(proto.id));
          expect(model.version, equals(proto.version));
          expect(model.name, equals(proto.name));
          expect(model.code, equals(proto.code));
        }

        proto = model.writeToProtoBuf();

        callExcept();

        model = organization_m.Organization();
        model.readFromProtoBuf(proto);

        callExcept();

      });
    });

    group('User.', () {
      test('User entity. Call writeToProtoBuf and readToProtoBuf.', () async {

        user_m.User model = user_m.User();

        model.id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.version = 0;
        model.name = 'Name test';
        model.password = '123456789';
        model.eMail = 'test@levius.com.br';

        user_pb.User proto;

        void callExcept() {
          expect(model.id, equals(proto.id));
          expect(model.version, equals(proto.version));
          expect(model.name, equals(proto.name));
          expect(model.password, equals(proto.password));
          expect(model.eMail, equals(proto.eMail));
        }

        proto = model.writeToProtoBuf();

        callExcept();

        model = user_m.User();
        model.readFromProtoBuf(proto);

        callExcept();

      });

      test('UserProfile entity. Call writeToProtoBuf and readToProtoBuf.', () async {

        user_m.UserProfile model = user_m.UserProfile();

        model.idiomLocale = 'pt_BR';
        model.image = 'BASE64IMAGE';
        model.isSuperAdmin = true;

        user_pb.UserProfile proto;

        void callExcept() {
          expect(model.idiomLocale, equals(proto.idiomLocale));
          expect(model.image, equals(proto.image));
          expect(model.isSuperAdmin, equals(proto.isSuperAdmin));
        }

        proto = model.writeToProtoBuf();

        callExcept();

        model = user_m.UserProfile();
        model.readFromProtoBuf(proto);

        callExcept();

      });

    });

    group('User Profile Organization.', () {
      test('UserProfileOrganization entity. Call writeToProtoBuf and readToProtoBuf.', () async {

        user_profile_organization_m.UserProfileOrganization model = user_profile_organization_m.UserProfileOrganization();

        model.id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.version = 0;
        model.authorizationRole = 0;
        model.organization = organization_m.Organization()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.user = user_m.User()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e';

        user_profile_organization_pb.UserProfileOrganization proto;

        void callExcept() {
          expect(model.id, equals(proto.id));
          expect(model.version, equals(proto.version));
          expect(model.authorizationRole, equals(proto.authorizationRole));
          expect(model.organization.id, equals(proto.organization.id));
          expect(model.user.id, equals(proto.user.id));
        }

        proto = model.writeToProtoBuf();

        callExcept();

        model = user_profile_organization_m.UserProfileOrganization();
        model.readFromProtoBuf(proto);

        callExcept();

      });
    });

    group('Group.', () {
      test('Group entity. Call writeToProtoBuf and readToProtoBuf.', () async {

        group_m.Group model = group_m.Group();

        model.id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.version = 0;
        model.name = 'Unit Test Group';
        model.active = true;
        model.organization = organization_m.Organization()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.groupType = group_m.GroupType()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.superGroup = group_m.Group()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.leader = user_m.User()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.members.add(user_m.User()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e');


        group_pb.Group proto;

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

        proto = model.writeToProtoBuf();

        callExcept();

        model = group_m.Group();
        model.readFromProtoBuf(proto);

        callExcept();

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