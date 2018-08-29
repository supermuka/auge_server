// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

/// This implement a model like a RBA (role based authorization)
/// Permission is defined informing role, object and function values.
/// Constraint is defined informing constraint values.

import 'package:auge_server/model/authorization.dart';

abstract class AuthorizationPolicy {
  List<Authorization> authorizations;

  // Define the authorization model
  AuthorizationPolicy() {
    authorizations = List<Authorization>();
  }

  bool isAuthorized(AuthorizationRole authorizationRole, AuthorizationObject authorizationObject, {dynamic authorizationFunction, dynamic authorizationConstraint}) {
    bool isRoleObjectAuthorized = false;
    bool isFunctionAuthorized = (authorizationFunction == null);
    bool isConstraintAuthorized = (authorizationConstraint == null);

    // Find Role and Object - Needs to be single.
    Authorization allowAuthorizationRoleObject = authorizations.singleWhere((
        allow) =>
    allow.authorizationRole == authorizationRole &&
        allow.authorizationObject == authorizationObject, orElse: () => null);

    if (allowAuthorizationRoleObject != null) {

      isRoleObjectAuthorized = true;

      // Find Function
      if (authorizationFunction != null && allowAuthorizationRoleObject != null) {
        if (allowAuthorizationRoleObject.authorizationFunctionContraints
            .containsKey(authorizationFunction)) {
          isFunctionAuthorized = true;

          // Find Constraints
          if (authorizationConstraint != null && allowAuthorizationRoleObject
              .authorizationFunctionContraints[authorizationFunction] != null) {
            if (allowAuthorizationRoleObject
                .authorizationFunctionContraints[authorizationFunction]
                .indexWhere((allow) => allow == authorizationConstraint) !=
                -1) {
              isConstraintAuthorized = true;
            }
          }
        }
      }
    }
    return isRoleObjectAuthorized && isFunctionAuthorized && isConstraintAuthorized;
  }

}

class GeneralAuthorizationPolicy extends AuthorizationPolicy {

  GeneralAuthorizationPolicy() {
    // Role: Super Admin
    // Object:  User
    // Function: All (*)
    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.superAdmin
      ..authorizationObject = AuthorizationObject.users
      ..authorizationFunctionContraints =
      {UserAuthorizationFunction.create: [],
       UserAuthorizationFunction.recovery: [],
       UserAuthorizationFunction.update: [],
       UserAuthorizationFunction.delete: []
      });

    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.superAdmin
      ..authorizationObject = AuthorizationObject.groups
      ..authorizationFunctionContraints =
      {UserAuthorizationFunction.create: [],
        UserAuthorizationFunction.recovery: [],
        UserAuthorizationFunction.update: [],
        UserAuthorizationFunction.delete: []
      });

    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.superAdmin
      ..authorizationObject = AuthorizationObject.organizations
      ..authorizationFunctionContraints =
      {UserAuthorizationFunction.create: [],
        UserAuthorizationFunction.recovery: [],
        UserAuthorizationFunction.update: [],
        UserAuthorizationFunction.delete: []
      });

    // Role: Admin
    // Object:  User
    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.admin
      ..authorizationObject = AuthorizationObject.users
      ..authorizationFunctionContraints =
      {UserAuthorizationFunction.create: [
        AuthorizationRole.standard,
        AuthorizationRole.leader],
       UserAuthorizationFunction.recovery: [],
       UserAuthorizationFunction.update: [
        AuthorizationRole.standard,
        AuthorizationRole.leader],
       UserAuthorizationFunction.delete: [
         AuthorizationRole.standard,
         AuthorizationRole.leader]
      });

    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.admin
      ..authorizationObject = AuthorizationObject.groups
      ..authorizationFunctionContraints =
      {UserAuthorizationFunction.create: [],
        UserAuthorizationFunction.recovery: [],
        UserAuthorizationFunction.update: [],
        UserAuthorizationFunction.delete: []
      });

    // Role: leader
    // Object:  user
    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.leader
      ..authorizationObject = AuthorizationObject.users
      ..authorizationFunctionContraints =
      {UserAuthorizationFunction.create: [
        AuthorizationRole.standard],
        UserAuthorizationFunction.recovery: [],
        UserAuthorizationFunction.update: [
          AuthorizationRole.standard],
        UserAuthorizationFunction.delete: [
          AuthorizationRole.standard]
      });

    // Role: standard
    // Object:  user_profile
    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.standard
      ..authorizationObject = AuthorizationObject.user_profile
      ..authorizationFunctionContraints = {UserAuthorizationFunction.recovery: null, UserAuthorizationFunction.update: null}
    );

  }
}
