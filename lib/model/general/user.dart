// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

// Proto buffer transport layer.
// ignore_for_file: uri_has_not_been_generated
import 'package:auge_server/src/protos/generated/general/user.pb.dart' as user_pb;

/// Domain model class to represent an user account
class User {

  User() {
    userProfile = UserProfile();
  }

  // Base fields
  static final String idField = 'id';
  String id;
  static final String versionField = 'version';
  int version;

  // Specific fields
  static final String nameField = 'name';
  String name;
  static final String eMailField = 'eMail';
  String eMail;

  // sha-256
  static final String passwordField = 'password';
  String password;

  // Profile
  static final String userProfileField = 'userProfile';
  UserProfile userProfile;

  user_pb.User writeToProtoBuf() {
    user_pb.User userPb = user_pb.User();

    if (this.id != null) userPb.id = this.id;
    if (this.version != null) userPb.version = this.version;
    if (this.name != null) userPb.name = this.name;
    if (this.eMail != null) userPb.eMail = this.eMail;
    if (this.password != null) userPb.password = this.password;
    if (this.userProfile != null) userPb.userProfile = this.userProfile.writeToProtoBuf();

    return userPb;
  }

  readFromProtoBuf(user_pb.User userPb) {
    if (userPb.hasId()) this.id = userPb.id;
    if (userPb.hasVersion()) this.version = userPb.version;
    if (userPb.hasName()) this.name = userPb.name;
    if (userPb.hasEMail()) this.eMail = userPb.eMail;
    if (userPb.hasPassword()) this.password = userPb.password;
    if (userPb.hasUserProfile()) this.userProfile = UserProfile()..readFromProtoBuf(userPb.userProfile);
  }
/*
  Map<String, dynamic> toMap() {
    return Map<String, dynamic>()
      ..[User.idField] = this.id
      ..[User.nameField] = this.name
      ..[User.eMailField] = this.eMail
      ..[User.passwordField] = this.password
      ..[User.userProfileField] = this.userProfile.toMap();
  }
*/

  static Map<String, dynamic> fromProtoBufToModelMap(user_pb.User userPb, [user_pb.User deltaComparedToUserPb]) {
    Map<String, dynamic> map = Map();

    if (userPb.hasId() && (deltaComparedToUserPb == null || deltaComparedToUserPb.hasId() && userPb.id != deltaComparedToUserPb.id)) map[User.idField] = userPb.id;
    if (userPb.hasVersion() && (deltaComparedToUserPb == null || deltaComparedToUserPb.hasVersion() &&  userPb.version != deltaComparedToUserPb.version)) map[User.versionField] = userPb.version;
    if (userPb.hasName() && (deltaComparedToUserPb == null || deltaComparedToUserPb.hasName() && userPb.name != deltaComparedToUserPb.name)) map[User.nameField] = userPb.name;
    if (userPb.hasEMail() && (deltaComparedToUserPb == null || deltaComparedToUserPb.hasEMail() && userPb.eMail != deltaComparedToUserPb.eMail)) map[User.eMailField] = userPb.eMail;
    if (userPb.hasPassword() && (deltaComparedToUserPb == null || deltaComparedToUserPb.hasPassword() && userPb.password != deltaComparedToUserPb.password)) map[User.passwordField] = userPb.password;
    if (userPb.hasUserProfile() && (deltaComparedToUserPb == null || deltaComparedToUserPb.hasUserProfile() && userPb.userProfile != deltaComparedToUserPb.userProfile)) map[User.userProfileField] = UserProfile.fromProtoBufToModelMap(userPb.userProfile, deltaComparedToUserPb?.userProfile);

    return map;
  }
}

/// Domain model class to represent an user account profile
class UserProfile {

  // Super Admin does not need authorization. It is SAAS administration and has access to full data and functions
  // bool isSuperAdmin = false;
  static final String isSuperAdminField = 'isSuperAdmin';
  bool isSuperAdmin;

  // Base64
  static final String imageField = 'image';
  String image;

  // pt_BR, en es_ES
  static final String idiomLocaleField = 'idiomLocale';
  String idiomLocale;

  user_pb.UserProfile writeToProtoBuf() {
    user_pb.UserProfile userProfilePb = user_pb.UserProfile();

    if (this.isSuperAdmin != null) userProfilePb.isSuperAdmin = this.isSuperAdmin;
    if (this.image != null) userProfilePb.image = this.image;
    if (this.idiomLocale != null) userProfilePb.idiomLocale = this.idiomLocale;

    return userProfilePb;
  }

  readFromProtoBuf(user_pb.UserProfile userProfilePb) {
    if (userProfilePb.hasIsSuperAdmin()) this.isSuperAdmin = userProfilePb.isSuperAdmin;
    if (userProfilePb.hasImage()) this.image = userProfilePb.image;
    if (userProfilePb.hasIdiomLocale()) this.idiomLocale = userProfilePb.idiomLocale;
  }
/*
  Map<String, dynamic> toMap() {
    return Map<String, dynamic>()
      ..[UserProfile.isSuperAdminField] = this.isSuperAdmin
      ..[UserProfile.imageField] = this.image
      ..[UserProfile.idiomLocaleField] = this.idiomLocale;
  }
*/
  static Map<String, dynamic> fromProtoBufToModelMap(user_pb.UserProfile userProfilePb, [user_pb.UserProfile deltaComparedToUserProfilePb]) {
    Map<String, dynamic> map = Map();

    if (userProfilePb.hasIsSuperAdmin() && (deltaComparedToUserProfilePb == null || deltaComparedToUserProfilePb.hasIsSuperAdmin() && userProfilePb.isSuperAdmin != deltaComparedToUserProfilePb.isSuperAdmin)) map[UserProfile.isSuperAdminField] = userProfilePb.isSuperAdmin;
    if (userProfilePb.hasImage() && (deltaComparedToUserProfilePb == null || deltaComparedToUserProfilePb.hasImage() && userProfilePb.image != deltaComparedToUserProfilePb.image)) map[UserProfile.imageField] = userProfilePb.image;
    if (userProfilePb.hasIdiomLocale() && (deltaComparedToUserProfilePb == null || deltaComparedToUserProfilePb.hasIdiomLocale() && userProfilePb.idiomLocale != deltaComparedToUserProfilePb.idiomLocale)) map[UserProfile.idiomLocaleField]= userProfilePb.idiomLocale;
    return map;
  }
}