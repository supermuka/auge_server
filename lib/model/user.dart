// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

/// Domain model class to represent an user account

enum UserAuthorization { admin, leader, standard }

class User extends Object  {
  String id;
  String name;
  String eMail;

  // sha-256
  String password;

  // Profile
  UserProfile userProfile;

  User() {
    userProfile = new UserProfile();
  }

  void cloneTo(User to) {
    to.id = this.id;
    to.name = this.name;
    to.eMail = this.eMail;
    to.password = this.password;

    if (this.userProfile != null) {
      to.userProfile = this.userProfile.clone();
    }
  }

  User clone() {
    User to = new User();
    cloneTo(to);
    return to;
  }
}

/// Domain model class to represent an user account profile
class UserProfile extends Object  {

  User user;

  // Super Admin does not need authorization. It is SAAS administration and has access to full data and functions
  bool isSuperAdmin;

  // base64
  String image;

  // pt_BR, en es_ES
  String idiomLocale;

  void cloneTo(UserProfile to) {
    to.idiomLocale = this.idiomLocale;
    to.isSuperAdmin = this.isSuperAdmin;
    to.image = this.image;

    if (this.user != null) {
      to.user = this.user.clone();
    }
  }

  UserProfile clone() {
    UserProfile to = new UserProfile();
    cloneTo(to);
    return to;
  }
}
