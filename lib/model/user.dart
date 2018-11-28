// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

/// Domain model class to represent an user account

class UserBase {
  String id;
}

class User extends UserBase  {
  String id;
  String name;
  String eMail;

  // sha-256
  String password;

  // Profile
  UserProfile userProfile;

  User() {
    userProfile = UserProfile();
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

class UserTest  {
  String id;
  String name;
  String eMail;

  // sha-256
  String password;

  UserTest() {
  }

  void cloneTo(UserTest to) {
    to.id = this.id;
    to.name = this.name;
    to.eMail = this.eMail;
    to.password = this.password;

  }

  UserTest clone() {
    UserTest to = new UserTest();
    return to;
  }
}

/// Domain model class to represent an user account profile
class UserProfileBase {

}

class UserProfilePersistet extends UserProfileBase {

}

class UserProfile extends UserProfilePersistet  {

  // Super Admin does not need authorization. It is SAAS administration and has access to full data and functions
  bool isSuperAdmin = false;

  // base64
  String image;

  // pt_BR, en es_ES
  String idiomLocale;

  UserProfile() {
  }

  void cloneTo(UserProfile to) {
    to.idiomLocale = this.idiomLocale;
    to.isSuperAdmin = this.isSuperAdmin;
    to.image = this.image;

  }

  UserProfile clone() {
    UserProfile to = new UserProfile();
    cloneTo(to);
    return to;
  }
}
