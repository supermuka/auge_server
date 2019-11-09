// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

// Proto buffer transport layer.
// ignore_for_file: uri_has_not_been_generated

import 'package:auge_server/model/general/user.dart';

import 'package:auge_server/src/protos/generated/general/user_identity.pb.dart' as user_identity_pb;

enum UserIdentityProvider {internal, directoryService}

/// Domain model class to represent an user account identity
class UserIdentity {
  static final String className = 'UserIdentity';

  static final String idField = 'id';
  String id;

  static final String versionField = 'version';
  int version;

  static final String identificationField = 'identification';
  String identification;

  // Text Plan - Not stored
  static final String passwordField = 'password';
  String password;

  // sha256 applied on salt + password
  static final String passwordHashField = 'passwordHash';
  String passwordHash;

  // Salt
  static final String passwordSaltField = 'passwordSalt';
  String passwordSalt;

  // Identity provider type: internal, ldap
  static final String providerField = 'provider';
  int provider;

  // If DirectoryService is enabled then this user can be updated on behalf of
  // Normally OpenLDAP entryUUID, AD objectGUID
  static final String providerObjectIdField = 'providerObjectId';
  String providerObjectId;

  // Ldap - dn - Distinguished Name  cn=admin,dc=auge,dc=levius,dc=com,dc=br
  static final String providerDnField = 'providerDn';
  String providerDn;

  static final String userField = 'user';
  User user;

  user_identity_pb.UserIdentity writeToProtoBuf() {
    user_identity_pb.UserIdentity userIdentityPb = user_identity_pb.UserIdentity();

    if (this.id != null) userIdentityPb.id = this.id;
    if (this.version != null) userIdentityPb.version = this.version;
    if (this.identification != null) userIdentityPb.identification = this.identification;
    if (this.password != null) userIdentityPb.password = this.password;
    if (this.provider != null) userIdentityPb.provider = this.provider;
    if (this.providerObjectId != null) userIdentityPb.providerObjectId = this.providerObjectId;
    if (this.providerDn != null) userIdentityPb.providerObjectId = this.providerDn;
    if (this.user != null) userIdentityPb.user = this.user.writeToProtoBuf();

    return userIdentityPb;
  }

  readFromProtoBuf(user_identity_pb.UserIdentity userIdentityPb, Map<String, dynamic> cache) {

    if (userIdentityPb.hasId()) this.id = userIdentityPb.id;
    if (userIdentityPb.hasVersion()) this.version = userIdentityPb.version;
    if (userIdentityPb.hasIdentification()) this.identification = userIdentityPb.identification;
    if (userIdentityPb.hasProviderDn()) this.providerDn = userIdentityPb.providerDn;
    if (userIdentityPb.hasPassword()) this.password = userIdentityPb.password;
    if (userIdentityPb.hasProvider()) this.provider = userIdentityPb.provider;
    if (userIdentityPb.hasProviderObjectId()) this.providerObjectId = userIdentityPb.providerObjectId;
    if (userIdentityPb.hasUser()) this.user = cache.putIfAbsent('${UserIdentity.userField}${userIdentityPb.user.id}@${User.className}', () => User()..readFromProtoBuf(userIdentityPb.user, cache));

  }

  static Map<String, dynamic> fromProtoBufToModelMap(user_identity_pb.UserIdentity userIdentityPb, [bool onlyIdAndSpecificationForDepthFields = false, bool isDeep = false]) {
    Map<String, dynamic> map = Map();

    if (onlyIdAndSpecificationForDepthFields && isDeep) {
      if (userIdentityPb.hasId())
        map[UserIdentity.idField] = userIdentityPb.id;
    } else {
      if (userIdentityPb.hasId())
        map[UserIdentity.idField] = userIdentityPb.id;
      if (userIdentityPb.hasVersion())
        map[UserIdentity.versionField] = userIdentityPb.version;
      if (userIdentityPb.hasIdentification())
        map[UserIdentity.identificationField] = userIdentityPb.identification;
      if (userIdentityPb.hasPassword())
        map[UserIdentity.passwordField] = userIdentityPb.password;
      if (userIdentityPb.hasProvider())
        map[UserIdentity.providerField] = userIdentityPb.provider;
      if (userIdentityPb.hasProviderObjectId())
        map[UserIdentity.providerObjectIdField] = userIdentityPb.providerObjectId;
      if (userIdentityPb.hasProviderDn())
        map[UserIdentity.providerDnField] = userIdentityPb.providerDn;

      if (userIdentityPb.hasUser())
        map[UserIdentity.userField] =
            User.fromProtoBufToModelMap(
                userIdentityPb.user, onlyIdAndSpecificationForDepthFields, true);
    }
    return map;
  }
}