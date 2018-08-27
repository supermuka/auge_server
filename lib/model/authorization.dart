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
    Iterable<Authorization> allowAuthorizations = authorizations.where((allow) => allow.authorizationRole == authorizationRole && allow.authorizationObject == authorizationObject && allow.authorizationFunction == authorizationFunction);
    Iterable<Authorization> denyAuthorizations;
    if (allowAuthorizations.isNotEmpty && authorizationConstraint != null) {
      denyAuthorizations = allowAuthorizations.where((deny) => deny.authorizationConstraint == authorizationConstraint);
    }

    return allowAuthorizations.isNotEmpty && (denyAuthorizations == null || denyAuthorizations.isEmpty);
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
      ..authorizationFunction = UserAuthorizationFunction.all);

    // Role: Standard
    // Object:  User
    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.standard
      ..authorizationObject = AuthorizationObject.user
      ..authorizationFunction = UserAuthorizationFunction.recovery);

    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.standard
      ..authorizationObject = AuthorizationObject.user
      ..authorizationFunction = UserAuthorizationFunction.update);

    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.standard
      ..authorizationObject = AuthorizationObject.user
      ..authorizationFunction = UserAuthorizationFunction.update
      ..authorizationConstraint = AuthorizationRole.superAdmin);

    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.standard
      ..authorizationObject = AuthorizationObject.user
      ..authorizationFunction = UserAuthorizationFunction.update
      ..authorizationConstraint = AuthorizationRole.admin);

    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.standard
      ..authorizationObject = AuthorizationObject.user
      ..authorizationFunction = UserAuthorizationFunction.update
      ..authorizationConstraint = AuthorizationRole.leader);

    // Role: Leader
    // Object:  User
    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.leader
      ..authorizationObject = AuthorizationObject.user
      ..authorizationFunction = UserAuthorizationFunction.all
      ..authorizationConstraint = AuthorizationRole.superAdmin);

    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.leader
      ..authorizationObject = AuthorizationObject.user
      ..authorizationFunction = UserAuthorizationFunction.all
      ..authorizationConstraint = AuthorizationRole.admin);

    authorizations.add(new Authorization()
      ..authorizationRole = AuthorizationRole.leader
      ..authorizationObject = AuthorizationObject.user
      ..authorizationFunction = UserAuthorizationFunction.all
      ..authorizationConstraint = AuthorizationRole.leader);
    }
}

class Authorization {

  AuthorizationRole authorizationRole;
  AuthorizationObject authorizationObject;
  dynamic authorizationFunction;
  dynamic authorizationConstraint;

}