import 'dart:mirrors';
import 'package:test/test.dart';

import 'package:auge_shared/protos/generated/general/organization.pb.dart' as organization_pb;
import 'package:auge_shared/protos/generated/general/organization_configuration.pb.dart' as organization_configuration_pb;
import 'package:auge_shared/protos/generated/general/organization_directory_service.pb.dart' as organization_directory_service_pb;
import 'package:auge_shared/protos/generated/general/user.pb.dart' as user_pb;
import 'package:auge_shared/protos/generated/general/user_access.pb.dart' as user_access_pb;
import 'package:auge_shared/protos/generated/general/user_identity.pb.dart' as user_identity_pb;
import 'package:auge_shared/protos/generated/general/group.pb.dart' as group_pb;
import 'package:auge_shared/protos/generated/general/unit_of_measurement.pb.dart' as unit_of_measurement_pb;
import 'package:auge_shared/protos/generated/general/history_item.pb.dart' as history_item_pb;

import 'package:auge_shared/domain/general/organization.dart' as organization_m;
import 'package:auge_shared/domain/general/organization_configuration.dart' as organization_configuration_m;
import 'package:auge_shared/domain/general/organization_directory_service.dart' as organization_directory_service_m;
import 'package:auge_shared/domain/general/user.dart' as user_m;
import 'package:auge_shared/domain/general/user_access.dart' as user_access_m;
import 'package:auge_shared/domain/general/user_identity.dart' as user_identity_m;
import 'package:auge_shared/domain/general/group.dart' as group_m;
import 'package:auge_shared/domain/general/unit_of_measurement.dart' as unit_of_measurement_m;
import 'package:auge_shared/domain/general/history_item.dart' as history_item_m;

void main() {

  group('Test Class and Fields name equivalence.', () {

    void checkEquivalence(Type domain, Type protobuf) {
      ClassMirror classMirrorDomain;

      classMirrorDomain = reflectClass(domain);
      // im.type.staticMembers.values.forEach((MethodMirror method) => print(method.simpleName));

      // classMirror.typeVariables.forEach((f) => print(f.qualifiedName));

      const String startSymbol = 'Symbol("';
      const String containsSymbolField = 'Field';
      const String endSymbol = '")';

      const String className = 'className';

      Set<String> fields = {};
      Map<String, String> constants = {};

      classMirrorDomain.declarations.values.forEach((DeclarationMirror declaration) {
        if (declaration is VariableMirror) {
          // Constant field description
          if (declaration.simpleName.toString().endsWith(containsSymbolField + endSymbol) && declaration.isStatic && declaration.isConst) {
              constants[declaration.simpleName.toString().replaceAll(startSymbol, '').replaceAll(containsSymbolField, '').replaceAll(endSymbol, '')] = classMirrorDomain
                  .getField(declaration.simpleName)
                  .reflectee;
            // Constant class description
          } else if ((declaration.simpleName.toString() == startSymbol + className + endSymbol) && declaration.isStatic && declaration.isConst) {
              constants[declaration.simpleName.toString().replaceAll(startSymbol, '').replaceAll(endSymbol, '')] = classMirrorDomain
                  .getField(declaration.simpleName)
                  .reflectee;
          }
          // Class and Field
          else {
            fields.add(declaration.simpleName.toString().replaceAll(startSymbol, '').replaceAll(endSymbol, ''));
          }
        }
      });

      ClassMirror classMirrorProtobuf;
      classMirrorProtobuf = reflectClass(protobuf);
      // im.type.staticMembers.values.forEach((MethodMirror method) => print(method.simpleName));

      // classMirror.typeVariables.forEach((f) => print(f.qualifiedName));
      String classNameProtobuf = classMirrorProtobuf.simpleName.toString().replaceAll(startSymbol, '').replaceAll(endSymbol, '');
      Set<String> fieldsProtobuf = {};
      classMirrorProtobuf.instanceMembers.values.forEach((MethodMirror method) {
        if (method is MethodMirror) {
          if (method.owner.simpleName == classMirrorProtobuf.simpleName) {
            if (method
                .isGetter /* method.isSetter, just get. Needs just one method to identifie a field name */) {
              fieldsProtobuf.add(method.simpleName.toString().replaceAll(startSymbol, '').replaceAll(endSymbol, ''));
            }
          }
        }
      });

      expect(classNameProtobuf, equals(constants[className]));
      for (String field in fields) {
        expect(field, equals(constants[field]));
        expect(field, equals(fieldsProtobuf.lookup(field)) );
      }
    }

    test('Organization.', () async {
      checkEquivalence(organization_m.Organization, organization_pb.Organization);
    });
    test('Organization Configuration.', () async {
      checkEquivalence(organization_configuration_m.OrganizationConfiguration, organization_configuration_pb.OrganizationConfiguration);
    });
    test('Organization Directory Service.', () async {
      checkEquivalence(organization_directory_service_m.OrganizationDirectoryService, organization_directory_service_pb.OrganizationDirectoryService);
    });
    test('User.', () async {
      checkEquivalence(user_m.User, user_pb.User);
    });
    test('UserProfile.', () async {
      checkEquivalence(user_m.UserProfile, user_pb.UserProfile);
    });
    test('UserAccess.', () async {
      checkEquivalence(user_access_m.UserAccess, user_access_pb.UserAccess);
    });
    test('UserIdentity.', () async {
      checkEquivalence(user_identity_m.UserIdentity, user_identity_pb.UserIdentity);
    });
    test('Group.', () async {
      checkEquivalence(group_m.Group, group_pb.Group);
    });
    test('UnitOfMeasurement.', () async {
      checkEquivalence(unit_of_measurement_m.UnitOfMeasurement, unit_of_measurement_pb.UnitOfMeasurement);
    });
    test('History Item.', () async {
      checkEquivalence(history_item_m.HistoryItem, history_item_pb.HistoryItem);
    });
  });

  /*
  group('TEST GENERAL MESSAGES.', () {

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

        proto = organization_m.OrganizationHelper.writeToProtoBuf(model);

        callExcept();

      });

      test('Organization entity. Call readToProtoBuf.', () async {

        model = organization_m.Organization();
        model = organization_m.OrganizationHelper.readFromProtoBuf(proto);

        callExcept();

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

        proto = user_m.UserHelper.writeToProtoBuf(model);

        callExcept();

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
        proto = user_access_m.UserAccessHelper.writeToProtoBuf(model);
        callExcept();
      });

      test('UserProfileOrganization entity. Call readToProtoBuf.', () async {
        model = user_access_m.UserAccessHelper.readFromProtoBuf(proto, {});
        callExcept();
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

        proto = group_m.GroupHelper.writeToProtoBuf(model);

        print('DEBUG 1 - json ${proto.writeToJson()}');

        print('DEBUG 2 - json ${proto.toProto3Json()}');

        callExcept();

      });

      test('Group entity. Call readToProtoBuf.', () async {


        model = group_m.GroupHelper.readFromProtoBuf(proto, {});

        callExcept();

      });
    });

    group('Objective.', () {

      objective_m.Objective model = objective_m.Objective();
      objective_m.Objective model2 = objective_m.Objective();
      objective_measure_pb.Objective proto;
      objective_measure_pb.Objective proto2;

      setUp(() {

        model.id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.version = 0;
        model.name = 'Unit Test Group';
        model.organization = organization_m.Organization()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e'..name = 'Nome da Empresa';
        model.leader = user_m.User()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e'..name = 'Nome do Usuário';
        model.startDate = DateTime.now();

        model2.id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model2.version = 1;
        model2.name = 'Unit Test Group 2';
        model2.organization = organization_m.Organization()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e'..name = 'Nome da Empresa';
        model2.leader = user_m.User()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e'..name = 'Nome do Usuário';
        model2.startDate = DateTime.now();

      });

      void callExcept() {
        expect(model.id, equals(proto.id));
        expect(model.version, equals(proto.version));
        expect(model.name, equals(proto.name));
        expect(model.organization.id, equals(proto.organization.id));
        expect(model.leader.id, equals(proto.leader.id));
      }

      test('Group entity. Call writeToProtoBuf.', () async {

        proto = objective_m.ObjectiveHelper.writeToProtoBuf(model);

        var json = proto.toProto3Json();
        print('DEBUG a - json ${json}');

        proto2 = objective_m.ObjectiveHelper.writeToProtoBuf(model);
        var json2 = proto2.toProto3Json();

        print('DEBUG b - json ${json2}');

        //
        var delta = history_item_m.HistoryItemHelper.changedValuesJson(json, json2);
        print('DEBUG c - delta ${delta}');

        callExcept();

      });

      test('Group entity. Call readToProtoBuf.', () async {


        model = objective_m.ObjectiveHelper.readFromProtoBuf(proto, {});

        callExcept();

      });
    });
  });
   */
}