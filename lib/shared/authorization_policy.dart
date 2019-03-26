// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

/// This implement a model like a RBA (role based authorization)
/// Permission is defined informing role, object and function values.
/// Constraint is defined informing constraint values.

import 'package:auge_server/model/general/authorization.dart';

abstract class AuthorizationPolicy {
  List<Authorization> authorizations;

  // Define the authorization model
  AuthorizationPolicy() {
    authorizations = List<Authorization>();
  }

  bool isAuthorized(SystemRole systemRole, SystemModule systemModule, {dynamic systemFunction, dynamic systemConstraint}) {
    bool isRoleObjectAuthorized = false;
    bool isFunctionAuthorized = (systemFunction == null);
    bool isConstraintAuthorized = (systemConstraint == null);

    // Find Role and Object - Needs to be single.
    Authorization allowAuthorizationRoleObject = authorizations.singleWhere((
        allow) =>
    allow.authorizationRole == systemRole &&
        allow.authorizationModule == systemModule, orElse: () => null);

    if (allowAuthorizationRoleObject != null) {

      isRoleObjectAuthorized = true;

      // Find Function
      if (systemFunction != null && allowAuthorizationRoleObject != null) {
        if (allowAuthorizationRoleObject.authorizationFunctionContraints
            .containsKey(systemFunction)) {
          isFunctionAuthorized = true;

          // Find Constraints
          if (systemConstraint != null && allowAuthorizationRoleObject
              .authorizationFunctionContraints[systemFunction] != null) {
            if (allowAuthorizationRoleObject
                .authorizationFunctionContraints[systemFunction]
                .indexWhere((allow) => allow == systemConstraint) !=
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
      ..authorizationRole = SystemRole.superAdmin
      ..authorizationModule = SystemModule.users
      ..authorizationFunctionContraints =
      {SystemFunction.create: [],
        SystemFunction.read: [],
        SystemFunction.update: [],
        SystemFunction.delete: []
      });

    // Object:  Groups
    // Function: CRUD
    authorizations.add(new Authorization()
      ..authorizationRole = SystemRole.superAdmin
      ..authorizationModule = SystemModule.groups
      ..authorizationFunctionContraints =
      {SystemFunction.create: [],
        SystemFunction.read: [],
        SystemFunction.update: [],
        SystemFunction.delete: []
      });

    // Object:  Organizations
    // Function: CRUD
    authorizations.add(new Authorization()
      ..authorizationRole = SystemRole.superAdmin
      ..authorizationModule = SystemModule.organizations
      ..authorizationFunctionContraints =
      {SystemFunction.create: [],
        SystemFunction.read: [],
        SystemFunction.update: [],
        SystemFunction.delete: []
      });

    // Object:  Organization Profile (detail)
    authorizations.add(new Authorization()
      ..authorizationRole = SystemRole.superAdmin
      ..authorizationModule = SystemModule.organization_profile
      ..authorizationFunctionContraints =
      {
        SystemFunction.read: [],
        SystemFunction.update: []
      });

    // Role: Admin
    // Object:  User
    authorizations.add(new Authorization()
      ..authorizationRole = SystemRole.admin
      ..authorizationModule = SystemModule.users
      ..authorizationFunctionContraints =
      {SystemFunction.create: [
        SystemRole.standard],
        SystemFunction.read: [],
        SystemFunction.update: [
         SystemRole.standard],
        SystemFunction.delete: [
          SystemRole.standard]
      });

    // Object:  Groups
    authorizations.add(new Authorization()
      ..authorizationRole = SystemRole.admin
      ..authorizationModule = SystemModule.groups
      ..authorizationFunctionContraints =
      {SystemFunction.create: [],
        SystemFunction.read: [],
        SystemFunction.update: [],
        SystemFunction.delete: []
      });

    // Object:  Organization Profile (detail)
    authorizations.add(new Authorization()
      ..authorizationRole = SystemRole.admin
      ..authorizationModule = SystemModule.organization_profile
      ..authorizationFunctionContraints =
      {
        SystemFunction.read: [],
        SystemFunction.update: []
      });


    // Role: standard
    // Object:  user_profile
    authorizations.add(new Authorization()
      ..authorizationRole = SystemRole.standard
      ..authorizationModule = SystemModule.user_profile
      ..authorizationFunctionContraints = {SystemFunction.read: null, SystemFunction.update: null}
    );
  }
}
