// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

// Proto buffer transport layer.
// ignore_for_file: uri_has_not_been_generated

import 'package:auge_server/model/general/organization.dart';

import 'package:auge_server/src/protos/generated/general/user.pb.dart' as user_pb;

/// Domain model class to represent an user account
class User {
  static final String className = 'User';

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

  static final String inactiveField = 'inactive';
  bool inactive;

  // Profile
  static final String userProfileField = 'userProfile';
  UserProfile userProfile;

  user_pb.User writeToProtoBuf() {
    user_pb.User userPb = user_pb.User();

    if (this.id != null) userPb.id = this.id;
    if (this.version != null) userPb.version = this.version;
    if (this.name != null) userPb.name = this.name;
    if (this.inactive != null) userPb.inactive = this.inactive;
    if (this.userProfile != null) userPb.userProfile = this.userProfile.writeToProtoBuf();

    return userPb;
  }

  readFromProtoBuf(user_pb.User userPb) {
    if (userPb.hasId()) this.id = userPb.id;
    if (userPb.hasVersion()) this.version = userPb.version;
    if (userPb.hasName()) this.name = userPb.name;
    if (userPb.hasInactive()) this.inactive = userPb.inactive;
    if (userPb.hasUserProfile()) this.userProfile = UserProfile()..readFromProtoBuf(userPb.userProfile);
  }

  static Map<String, dynamic> fromProtoBufToModelMap(user_pb.User userPb, [bool onlyIdAndSpecificationForDepthFields = false, bool isDeep = false]) {
    Map<String, dynamic> map = Map();

    if (onlyIdAndSpecificationForDepthFields && isDeep) {
      if (userPb.hasId()) map[User.idField] = userPb.id;
      if (userPb.hasName()) map[User.nameField] = userPb.name;
    } else
    {
      if (userPb.hasId()) map[User.idField] = userPb.id;
      if (userPb.hasVersion()) map[User.versionField] = userPb.version;
      if (userPb.hasName()) map[User.nameField] = userPb.name;
      if (userPb.hasInactive()) map[User.inactiveField] = userPb.inactive;
      if (userPb.hasUserProfile()) {
        map[User.userProfileField] =
            UserProfile.fromProtoBufToModelMap(
                userPb.userProfile, onlyIdAndSpecificationForDepthFields,
                false); // here isDeep is false, because UserProfile is like an extention

      }
    }
    return map;
  }
}

/// Domain model class to represent an user account profile
class UserProfile {
  static final String className = 'UserProfile';

  // Super Admin does not need authorization. It is SAAS administration and has access to full data and functions
  // bool isSuperAdmin = false;
 // static final String isSuperAdminField = 'isSuperAdmin';
 // bool isSuperAdmin;

  static final String additionalIdField = 'additionalId';
  String additionalId;

  static final String eMailField = 'eMail';
  String eMail;

  // sha-256
  static final String passwordField = 'password';
  String password;

  // Base64
  static final String imageField = 'image';
  String image;

  // pt_BR, en es_ES
  static final String idiomLocaleField = 'idiomLocale';
  String idiomLocale;

  // Organization, owner this user.
  // Authorization this user for organization here informed or another organizations should be informed in [UserProfileOrganization]
  static final String organizationField = 'organization';
  Organization organization;

  // If DirectoryService is enabled then this user can be updated on behalf of
  // Normally OpenLDAP entryUUID, AD objectGUID
  static final String directoryServiceIdField = 'directoryServiceId';
  String directoryServiceId;

  user_pb.UserProfile writeToProtoBuf() {
    user_pb.UserProfile userProfilePb = user_pb.UserProfile();

   // if (this.isSuperAdmin != null) userProfilePb.isSuperAdmin = this.isSuperAdmin;
    if (this.additionalId != null) userProfilePb.additionalId = this.additionalId;
    if (this.image != null) userProfilePb.image = this.image;
    if (this.idiomLocale != null) userProfilePb.idiomLocale = this.idiomLocale;
    if (this.organization != null) userProfilePb.organization = this.organization.writeToProtoBuf();
    if (this.directoryServiceId != null) userProfilePb.directoryServiceId = this.directoryServiceId;

    return userProfilePb;
  }

  readFromProtoBuf(user_pb.UserProfile userProfilePb) {
  //  if (userProfilePb.hasIsSuperAdmin()) this.isSuperAdmin = userProfilePb.isSuperAdmin;
    if (userProfilePb.hasAdditionalId()) this.additionalId = userProfilePb.additionalId;
    if (userProfilePb.hasImage()) this.image = userProfilePb.image;
    if (userProfilePb.hasIdiomLocale()) this.idiomLocale = userProfilePb.idiomLocale;
    if (userProfilePb.hasOrganization()) this.organization = Organization()..readFromProtoBuf(userProfilePb.organization);
    if (userProfilePb.hasDirectoryServiceId()) this.directoryServiceId = userProfilePb.directoryServiceId;
  }

  static Map<String, dynamic> fromProtoBufToModelMap(user_pb.UserProfile userProfilePb, [bool onlyIdAndSpecificationForDepthFields = false, bool isDeep = false]) {
    Map<String, dynamic> map = Map();

    if (onlyIdAndSpecificationForDepthFields && isDeep) {
      if (userProfilePb.hasAdditionalId())
        map[UserProfile.additionalIdField] = userProfilePb.additionalId;
    } else {
 //     if (userProfilePb.hasIsSuperAdmin())
 //       map[UserProfile.isSuperAdminField] = userProfilePb.isSuperAdmin;
      if (userProfilePb.hasAdditionalId())
        map[UserProfile.additionalIdField] = userProfilePb.additionalId;
      if (userProfilePb.hasEMail())
        map[UserProfile.eMailField] = userProfilePb.eMail;
      if (userProfilePb.hasPassword())
        map[UserProfile.passwordField] = userProfilePb.password;
      if (userProfilePb.hasImage())
        map[UserProfile.imageField] = userProfilePb.image;
      if (userProfilePb.hasIdiomLocale())
        map[UserProfile.idiomLocaleField] = userProfilePb.idiomLocale;
      if (userProfilePb.hasOrganization())
        map[UserProfile.organizationField] =
            Organization.fromProtoBufToModelMap(
                userProfilePb.organization, onlyIdAndSpecificationForDepthFields, true);
      if (userProfilePb.hasDirectoryServiceId())
        map[UserProfile.directoryServiceIdField] = userProfilePb.directoryServiceId;
    }
    return map;
  }
}
