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
  String id;
  int version;

  // Specific fields
  String name;
  String eMail;

  // sha-256
  String password;

  // Profile
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
}

/*
/// User classes
class UserBase {
  String id;
}

class User implements UserBase {
  String id;
  int version;
  bool isDeleted;
  String name;
  String eMail;

  // sha-256
  String password;

  // Profile
  UserProfile userProfile;

  User() {
    userProfile = UserProfile();
  }
}
*/

/// Domain model class to represent an user account profile
class UserProfile {

  // Super Admin does not need authorization. It is SAAS administration and has access to full data and functions
  // bool isSuperAdmin = false;
  bool isSuperAdmin;

  // base64
  String image;

  // pt_BR, en es_ES
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
}