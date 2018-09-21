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
    // Function: CRUD
    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.superAdmin
      ..authorizationObject = AuthorizationObject.users
      ..authorizationFunctionContraints =
      {AuthorizationFunction.create: [],
       AuthorizationFunction.recovery: [],
       AuthorizationFunction.update: [],
       AuthorizationFunction.delete: []
      });

    // Object:  Groups
    // Function: CRUD
    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.superAdmin
      ..authorizationObject = AuthorizationObject.groups
      ..authorizationFunctionContraints =
      {AuthorizationFunction.create: [],
        AuthorizationFunction.recovery: [],
        AuthorizationFunction.update: [],
        AuthorizationFunction.delete: []
      });

    // Object:  Organizations
    // Function: CRUD
    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.superAdmin
      ..authorizationObject = AuthorizationObject.organizations
      ..authorizationFunctionContraints =
      {AuthorizationFunction.create: [],
        AuthorizationFunction.recovery: [],
        AuthorizationFunction.update: [],
        AuthorizationFunction.delete: []
      });

    // Object:  Organization Profile (detail)
    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.superAdmin
      ..authorizationObject = AuthorizationObject.organization_profile
      ..authorizationFunctionContraints =
      {
        AuthorizationFunction.recovery: [],
        AuthorizationFunction.update: []
      });

    // Role: Admin
    // Object:  User
    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.admin
      ..authorizationObject = AuthorizationObject.users
      ..authorizationFunctionContraints =
      {AuthorizationFunction.create: [
        AuthorizationRole.standard,
        AuthorizationRole.leader],
       AuthorizationFunction.recovery: [],
       AuthorizationFunction.update: [
        AuthorizationRole.standard,
        AuthorizationRole.leader],
       AuthorizationFunction.delete: [
         AuthorizationRole.standard,
         AuthorizationRole.leader]
      });

    // Object:  Groups
    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.admin
      ..authorizationObject = AuthorizationObject.groups
      ..authorizationFunctionContraints =
      {AuthorizationFunction.create: [],
        AuthorizationFunction.recovery: [],
        AuthorizationFunction.update: [],
        AuthorizationFunction.delete: []
      });

    // Object:  Organization Profile (detail)
    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.admin
      ..authorizationObject = AuthorizationObject.organization_profile
      ..authorizationFunctionContraints =
      {
        AuthorizationFunction.recovery: [],
        AuthorizationFunction.update: []
      });

    // Role: leader
    // Object:  user
    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.leader
      ..authorizationObject = AuthorizationObject.users
      ..authorizationFunctionContraints =
      {AuthorizationFunction.create: [
        AuthorizationRole.standard],
        AuthorizationFunction.recovery: [],
        AuthorizationFunction.update: [
          AuthorizationRole.standard],
        AuthorizationFunction.delete: [
          AuthorizationRole.standard]
      });

    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.leader
      ..authorizationObject = AuthorizationObject.groups
      ..authorizationFunctionContraints =
      {AuthorizationFunction.create: [],
        AuthorizationFunction.recovery: [],
        AuthorizationFunction.update: [],
        AuthorizationFunction.delete: []
      });

    // Role: standard
    // Object:  user_profile
    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.standard
      ..authorizationObject = AuthorizationObject.user_profile
      ..authorizationFunctionContraints = {AuthorizationFunction.recovery: null, AuthorizationFunction.update: null}
    );

  }
}
