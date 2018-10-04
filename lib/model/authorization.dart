// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

// Super Admin has a special treatment. When a user is Admin Role, another roles ( admin, leader, standard ) defined on organizations are ignorated.
enum SystemRole { superAdmin, admin, standard }

enum SystemModule { users,
                     user_profile,
                     groups,
                     organizations,
                     organization_profile,
                     objectives,
                     initiatives }

// User
enum SystemFunction {
  create,
  recovery,
  update,
  delete,
}



class Authorization {

  SystemRole authorizationRole;
  SystemModule authorizationModule;

  // Key is the function
  // Value contain constraints, if exist.
  Map<SystemFunction, List<dynamic>> authorizationFunctionContraints;

  Authorization() {
    authorizationFunctionContraints = Map();
  }

}