import 'package:test/test.dart';

import 'package:auge_server/model/authorization.dart';

void main() {

  AuthorizationPolicy authorizationPolicy;

  setUp(() {
    authorizationPolicy = new GeneralAuthorizationPolicy();
  });

  group('Role: superAdmin,', () {
    group('Object: user,', () {
      test('Function: all, Constraint: null to be authorizated.', () {
        expect(authorizationPolicy.isAuthorizated(
            AuthorizationRole.superAdmin,
            AuthorizationObject.user,
            UserAuthorizationFunction.all), isTrue);
      });

    });
  });


  group('Role: leader,', () {
    group('Object: user,', () {

      test('Function: all, Constraint: superAdmin can NOT to be authorizated.', () {
        expect(authorizationPolicy.isAuthorizated(
            AuthorizationRole.leader,
            AuthorizationObject.user,
            UserAuthorizationFunction.all,
            authorizationConstraint: AuthorizationRole.superAdmin), isFalse);
      });

      test('Function: all, Constraint: admin can NOT to be authorizated.', () {
        expect(authorizationPolicy.isAuthorizated(
            AuthorizationRole.leader,
            AuthorizationObject.user,
            UserAuthorizationFunction.all,
            authorizationConstraint: AuthorizationRole.admin), isFalse);
      });

      test('Function: all, Constraint: leader CAN to be authorizated.', () {
        expect(authorizationPolicy.isAuthorizated(
            AuthorizationRole.leader,
            AuthorizationObject.user,
            UserAuthorizationFunction.all,
            authorizationConstraint: AuthorizationRole.leader), isFalse);
      });

      test('Function: all, Constraint: [] CAN to be authorizated.', () {
        expect(authorizationPolicy.isAuthorizated(
            AuthorizationRole.leader,
            AuthorizationObject.user,
            UserAuthorizationFunction.all,
            authorizationConstraint: AuthorizationRole.standard), isTrue);
      });

    });
  });


  group('Role: standard,', () {
    group('Object: user,', () {

      test('Function: all, Constraint: [] can NOT to be authorizated.', () {
        expect(authorizationPolicy.isAuthorizated(
            AuthorizationRole.leader,
            AuthorizationObject.user,
            UserAuthorizationFunction.all), isFalse);
      });

      test('Function: all, Constraint: superAdmin can NOT to be authorizated.', () {
        expect(authorizationPolicy.isAuthorizated(
            AuthorizationRole.leader,
            AuthorizationObject.user,
            UserAuthorizationFunction.all,
            authorizationConstraint: AuthorizationRole.superAdmin), isFalse);
      });

      test('Function: all, Constraint: admin can NOT to be authorizated.', () {
        expect(authorizationPolicy.isAuthorizated(
            AuthorizationRole.leader,
            AuthorizationObject.user,
            UserAuthorizationFunction.all,
            authorizationConstraint: AuthorizationRole.admin), isFalse);
      });

      test('Function: all, Constraint: leader CAN to be authorizated.', () {
        expect(authorizationPolicy.isAuthorizated(
            AuthorizationRole.leader,
            AuthorizationObject.user,
            UserAuthorizationFunction.all,
            authorizationConstraint: AuthorizationRole.leader), isFalse);
      });

      test('Function: all, Constraint: standard CAN to be authorizated.', () {
        expect(authorizationPolicy.isAuthorizated(
            AuthorizationRole.leader,
            AuthorizationObject.user,
            UserAuthorizationFunction.all,
            authorizationConstraint: AuthorizationRole.standard), isTrue);
      });

      test('Function: all, Constraint: [] can NOT to be authorizated.', () {
        expect(authorizationPolicy.isAuthorizated(
            AuthorizationRole.leader,
            AuthorizationObject.user,
            UserAuthorizationFunction.all,
            authorizationConstraint: []), isFalse);
      });

      test('Function: all, Constraint: null can NOT to be authorizated.', () {
        expect(authorizationPolicy.isAuthorizated(
            AuthorizationRole.leader,
            AuthorizationObject.user,
            UserAuthorizationFunction.all), isFalse);
      });

    });
  });

}