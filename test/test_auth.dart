import 'package:test/test.dart';

import 'package:auge_server/model/authorization.dart';

void main() {

  AuthorizationPolicy authorizationPolicy;

  setUp(() {
    authorizationPolicy = new GeneralAuthorizationPolicy();
  });

  group('Role: leader,', () {
    group('Object: user,', () {

      test('Function: all, Constraint: superAdmin does not to be authorizated.', () {
        expect(authorizationPolicy.isAuthorizated(
            AuthorizationRole.leader,
            AuthorizationObject.user,
            UserAuthorizationFunction.all,
            authorizationConstraint: AuthorizationRole.superAdmin), isFalse);
      });

      test('Function: all, Constraint: admin does not to be authorizated.', () {
        expect(authorizationPolicy.isAuthorizated(
            AuthorizationRole.leader,
            AuthorizationObject.user,
            UserAuthorizationFunction.all,
            authorizationConstraint: AuthorizationRole.admin), isFalse);
      });

      test('Function: all, Constraint: leader does not to be authorizated.', () {
        expect(authorizationPolicy.isAuthorizated(
            AuthorizationRole.leader,
            AuthorizationObject.user,
            UserAuthorizationFunction.all,
            authorizationConstraint: AuthorizationRole.superAdmin), isFalse);
      });

      test('Function: all, Constraint: standard to be authorizated.', () {
        expect(authorizationPolicy.isAuthorizated(
            AuthorizationRole.leader,
            AuthorizationObject.user,
            UserAuthorizationFunction.all,
            authorizationConstraint: AuthorizationRole.standard), isTrue);
      });

    });

    group('Role: superAdmin', () {
      group('Object: user', () {
        test('Function: all, Constraint: null authorizated.', () {
          expect(authorizationPolicy.isAuthorizated(
              AuthorizationRole.superAdmin,
              AuthorizationObject.user,
              UserAuthorizationFunction.all), isTrue);
        });
      });
    });
  });
}