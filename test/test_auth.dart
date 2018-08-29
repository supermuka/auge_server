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
            authorizationFunction: UserAuthorizationFunction.create), isTrue);
      });

      test('Function: UserAuthorizationFunction.recovery, Constraint: null >>> Authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.superAdmin,
            AuthorizationObject.users,
            authorizationFunction: UserAuthorizationFunction.recovery), isTrue);
      });

      test('Function: UserAuthorizationFunction.update, Constraint: null >>> Authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.superAdmin,
            AuthorizationObject.users,
            authorizationFunction: UserAuthorizationFunction.update), isTrue);
      });

      test('Function: UserAuthorizationFunction.delete, Constraint: null >>> Authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.superAdmin,
            AuthorizationObject.users,
            authorizationFunction: UserAuthorizationFunction.delete), isTrue);
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
            authorizationFunction: UserAuthorizationFunction.create,
            authorizationConstraint: AuthorizationRole.superAdmin), isFalse);
      });

      test('Function: recovery, Constraint: superAdmin >>> NOT authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.leader,
            AuthorizationObject.users,
            authorizationFunction: UserAuthorizationFunction.recovery,
            authorizationConstraint: AuthorizationRole.superAdmin), isFalse);
      });

      test('Function: update, Constraint: superAdmin >>> NOT authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.leader,
            AuthorizationObject.users,
            authorizationFunction: UserAuthorizationFunction.update,
            authorizationConstraint: AuthorizationRole.superAdmin), isFalse);
      });

      test('Function: delete, Constraint: superAdmin >>> NOT authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.leader,
            AuthorizationObject.users,
            authorizationFunction: UserAuthorizationFunction.delete,
            authorizationConstraint: AuthorizationRole.superAdmin), isFalse);
      });

      test('Function: create, Constraint: admin >>> NOT authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.leader,
            AuthorizationObject.users,
            authorizationFunction: UserAuthorizationFunction.create,
            authorizationConstraint: AuthorizationRole.admin), isFalse);
      });

      test('Function: recovery, Constraint: admin >>> NOT authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.leader,
            AuthorizationObject.users,
            authorizationFunction: UserAuthorizationFunction.recovery,
            authorizationConstraint: AuthorizationRole.admin), isFalse);
      });

      test('Function: update, Constraint: admin >>> NOT authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.leader,
            AuthorizationObject.users,
            authorizationFunction: UserAuthorizationFunction.update,
            authorizationConstraint: AuthorizationRole.admin), isFalse);
      });

      test('Function: delete, Constraint: admin >>> NOT authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.leader,
            AuthorizationObject.users,
            authorizationFunction: UserAuthorizationFunction.delete,
            authorizationConstraint: AuthorizationRole.admin), isFalse);
      });

      test('Function: create, Constraint: leader >>> NOT authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.leader,
            AuthorizationObject.users,
            authorizationFunction: UserAuthorizationFunction.create,
            authorizationConstraint: AuthorizationRole.leader), isFalse);
      });

      test('Function: recovery, Constraint: leader >>> NOT authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.leader,
            AuthorizationObject.users,
            authorizationFunction: UserAuthorizationFunction.recovery,
            authorizationConstraint: AuthorizationRole.leader), isFalse);
      });

      test('Function: update, Constraint: leader >>> NOT authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.leader,
            AuthorizationObject.users,
            authorizationFunction: UserAuthorizationFunction.update,
            authorizationConstraint: AuthorizationRole.leader), isFalse);
      });

      test('Function: delete, Constraint: leader >>> NOT authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.leader,
            AuthorizationObject.users,
            authorizationFunction: UserAuthorizationFunction.delete,
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
            authorizationFunction:  UserAuthorizationFunction.recovery), isTrue);
      });

      test('Function: update, Constraint: null >>> Authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            AuthorizationRole.standard,
            AuthorizationObject.user_profile,
            authorizationFunction:  UserAuthorizationFunction.update), isTrue);
      });
    });
  });

}