import 'package:test/test.dart';

import 'package:auge_server/shared/authorization_policy.dart';
import 'package:auge_server/model/general/authorization.dart';

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
            SystemRole.superAdmin,
            SystemModule.users), isTrue);
      });

      test('Function: UserAuthorizationFunction.create, Constraint: null >>> Authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            SystemRole.superAdmin,
            SystemModule.users,
            systemFunction: SystemFunction.create), isTrue);
      });

      test('Function: UserAuthorizationFunction.recovery, Constraint: null >>> Authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            SystemRole.superAdmin,
            SystemModule.users,
            systemFunction: SystemFunction.read), isTrue);
      });

      test('Function: UserAuthorizationFunction.update, Constraint: null >>> Authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            SystemRole.superAdmin,
            SystemModule.users,
            systemFunction: SystemFunction.update), isTrue);
      });

      test('Function: UserAuthorizationFunction.delete, Constraint: null >>> Authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            SystemRole.superAdmin,
            SystemModule.users,
            systemFunction: SystemFunction.delete), isTrue);
      });
    });
  });

  group('Role: standard,', () {
    group('Object: user_profile,', () {

      test('Function: recovery, Constraint: null >>> Authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            SystemRole.standard,
            SystemModule.user_profile,
            systemFunction:  SystemFunction.read), isTrue);
      });

      test('Function: update, Constraint: null >>> Authorizated.', () {
        expect(authorizationPolicy.isAuthorized(
            SystemRole.standard,
            SystemModule.user_profile,
            systemFunction:  SystemFunction.update), isTrue);
      });
    });
  });

}