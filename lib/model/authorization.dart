// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

// Super Admin has a special treatment. When a user is Admin Role, another roles ( admin, leader, standard ) defined on organizations are ignorated.
enum AuthorizationRole { superAdmin, admin, leader, standard }

enum AuthorizationObject { users,
                           user_profile,
                           groups,
                           organizations,
                           organization_profile,
                           objectives,
                           initiatives }

// User
enum UserAuthorizationFunction {
  create,
  recovery,
  update,
  delete,
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