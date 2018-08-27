// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

/// This implement a model like a RBA (role based authorization)
/// Permission is defined informing role, object and function values.
/// Constraint is defined informing constraint values.

// Super Admin has a special treatment. When a user is Admin Role, another roles ( admin, leader, standard ) defined on organizations are ignorated.
enum AuthorizationRole { superAdmin, admin, leader, standard }

enum AuthorizationObject { user,
                           group,
                           objective,
                           initiative }

// User
enum UserAuthorizationFunction {
  all,
  list,
  create,
  recovery,
  update,
  delete,
}

abstract class AuthorizationPolicy {
  List<Authorization> authorizations;

  // Define the authorization model
  AuthorizationPolicy() {
    authorizations = List<Authorization>();
  }

  bool isAuthorizated(AuthorizationRole authorizationRole, AuthorizationObject authorizationObject, dynamic authorizationFunction, {dynamic authorizationConstraint}) {

    bool allow = false;
    bool deny = true;

    // Find Role and Object - Needs to be single.
    Authorization allowAuthorizationRoleObject = authorizations.singleWhere((allow) => allow.authorizationRole == authorizationRole && allow.authorizationObject == authorizationObject);

    // Find Function
    if (allowAuthorizationRoleObject != null) {
      if (allowAuthorizationRoleObject.authorizationFunctionContraints
          .containsKey(authorizationFunction)) {
        allow = true;

        // Find Constraints
        if (allowAuthorizationRoleObject
            .authorizationFunctionContraints[authorizationFunction] != null) {
          if (allowAuthorizationRoleObject
              .authorizationFunctionContraints[authorizationFunction]
              .indexWhere((deny) => deny == authorizationConstraint) != -1) {
            deny = false;
          }
        } else {
          deny = false;
        }
      }
    }

    return allow && !deny;
  }

}

class GeneralAuthorizationPolicy extends AuthorizationPolicy {

  GeneralAuthorizationPolicy() {
    // Role: Super Admin
    // Object:  User
    // Function: All (*)
    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.superAdmin
      ..authorizationObject = AuthorizationObject.user
      ..authorizationFunctionContraints = {UserAuthorizationFunction.all: null}

    );

    // Role: Standard
    // Object:  User
    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.standard
      ..authorizationObject = AuthorizationObject.user
      ..authorizationFunctionContraints = {UserAuthorizationFunction.all: []}
    );

    // Role: Leader
    // Object:  User
    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.leader
      ..authorizationObject = AuthorizationObject.user
      ..authorizationFunctionContraints = {UserAuthorizationFunction.all: [
        AuthorizationRole.standard
      ]}
    );

    // Role: Admin
    // Object:  User
    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.admin
      ..authorizationObject = AuthorizationObject.user
      ..authorizationFunctionContraints = {UserAuthorizationFunction.all: [
        AuthorizationRole.standard,
        AuthorizationRole.leader
      ]}
    );
  }

}

class Authorization {

  AuthorizationRole authorizationRole;
  AuthorizationObject authorizationObject;
  // Key is the function
  // Value contain constraints, if exist.
  Map<dynamic, List<dynamic>> authorizationFunctionContraints;

  Authorization() {
    authorizationFunctionContraints = Map();
  }

}