// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

// Super Admin has a special treatment. When a user is Super Admin Role, another roles ( admin, standard ) defined on organizations are ignorated.
enum SystemRole { superAdmin, admin, standard }

enum SystemModule { users,
                    user_profile,
                    groups,
                    organization,
                    objectives,
                    initiatives }

// User
enum SystemFunction {
  create,
  read,
  update,
  delete,
}

// TODO perhaps it is better to rename this class to 'ACCESS' to align to IAM (Identity and Access Management)
/// In-memory class. It is't persistent
class Authorization {

  static final String authorizationRoleField = 'authorizationRole';
  SystemRole authorizationRole;
  static final String authorizationModuleField = 'authorizationModule';
  SystemModule authorizationModule;

  // Key is the function
  // Value contain constraints, if exist.
  Map<SystemFunction, List<dynamic>> authorizationFunctionContraints;

  Authorization() {
    authorizationFunctionContraints = Map();
  }
}