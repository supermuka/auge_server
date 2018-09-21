import 'package:test/test.dart';

import 'package:auge_server/shared/authorization_policy.dart';
import 'package:auge_server/model/authorization.dart';

void main() {

  AuthorizationPolicy authorizationPolicy;

  setUp(() {
    authorizationPolicy = new GeneralAuthorizationPolicy();

  });

  // Role: superAdmin
  // Object: users
  group('Role: superAdmin,', () {
    group('Object: users,', () {

      test('Function: null, Constraint: null >>> Authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.superAdmin,
            AuthorizationObject.users), isTrue);
      });

      test('Function: UserAuthorizationFunction.create, Constraint: null >>> Authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.superAdmin,
            AuthorizationObject.users,
            authorizationFunction: AuthorizationFunction.create), isTrue);
      });

      test('Function: UserAuthorizationFunction.recovery, Constraint: null >>> Authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.superAdmin,
            AuthorizationObject.users,
            authorizationFunction: AuthorizationFunction.recovery), isTrue);
      });

      test('Function: UserAuthorizationFunction.update, Constraint: null >>> Authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.superAdmin,
            AuthorizationObject.users,
            authorizationFunction: AuthorizationFunction.update), isTrue);
      });

      test('Function: UserAuthorizationFunction.delete, Constraint: null >>> Authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.superAdmin,
            AuthorizationObject.users,
            authorizationFunction: AuthorizationFunction.delete), isTrue);
      });
    });
  });

  // Role: leader
  // Object: users
  group('Role: leader,', () {
    group('Object: users,', () {

      test('Function: create, Constraint: superAdmin >>> NOT authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.leader,
            AuthorizationObject.users,
            authorizationFunction: AuthorizationFunction.create,
            authorizationConstraint: AuthorizationRole.superAdmin), isFalse);
      });

      test('Function: recovery, Constraint: superAdmin >>> NOT authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.leader,
            AuthorizationObject.users,
            authorizationFunction: AuthorizationFunction.recovery,
            authorizationConstraint: AuthorizationRole.superAdmin), isFalse);
      });

      test('Function: update, Constraint: superAdmin >>> NOT authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.leader,
            AuthorizationObject.users,
            authorizationFunction: AuthorizationFunction.update,
            authorizationConstraint: AuthorizationRole.superAdmin), isFalse);
      });

      test('Function: delete, Constraint: superAdmin >>> NOT authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.leader,
            AuthorizationObject.users,
            authorizationFunction: AuthorizationFunction.delete,
            authorizationConstraint: AuthorizationRole.superAdmin), isFalse);
      });

      test('Function: create, Constraint: admin >>> NOT authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.leader,
            AuthorizationObject.users,
            authorizationFunction: AuthorizationFunction.create,
            authorizationConstraint: AuthorizationRole.admin), isFalse);
      });

      test('Function: recovery, Constraint: admin >>> NOT authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.leader,
            AuthorizationObject.users,
            authorizationFunction: AuthorizationFunction.recovery,
            authorizationConstraint: AuthorizationRole.admin), isFalse);
      });

      test('Function: update, Constraint: admin >>> NOT authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.leader,
            AuthorizationObject.users,
            authorizationFunction: AuthorizationFunction.update,
            authorizationConstraint: AuthorizationRole.admin), isFalse);
      });

      test('Function: delete, Constraint: admin >>> NOT authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.leader,
            AuthorizationObject.users,
            authorizationFunction: AuthorizationFunction.delete,
            authorizationConstraint: AuthorizationRole.admin), isFalse);
      });

      test('Function: create, Constraint: leader >>> NOT authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.leader,
            AuthorizationObject.users,
            authorizationFunction: AuthorizationFunction.create,
            authorizationConstraint: AuthorizationRole.leader), isFalse);
      });

      test('Function: recovery, Constraint: leader >>> NOT authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.leader,
            AuthorizationObject.users,
            authorizationFunction: AuthorizationFunction.recovery,
            authorizationConstraint: AuthorizationRole.leader), isFalse);
      });

      test('Function: update, Constraint: leader >>> NOT authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.leader,
            AuthorizationObject.users,
            authorizationFunction: AuthorizationFunction.update,
            authorizationConstraint: AuthorizationRole.leader), isFalse);
      });

      test('Function: delete, Constraint: leader >>> NOT authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.leader,
            AuthorizationObject.users,
            authorizationFunction: AuthorizationFunction.delete,
            authorizationConstraint: AuthorizationRole.leader), isFalse);
      });
    });
  });

  group('Role: standard,', () {
    group('Object: user_profile,', () {

      test('Function: recovery, Constraint: null >>> Authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.standard,
            AuthorizationObject.user_profile,
            authorizationFunction:  AuthorizationFunction.recovery), isTrue);
      });

      test('Function: update, Constraint: null >>> Authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.standard,
            AuthorizationObject.user_profile,
            authorizationFunction:  AuthorizationFunction.update), isTrue);
      });
    });
  });

}