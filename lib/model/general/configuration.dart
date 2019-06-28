// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:auge_server/model/general/organization.dart';

// ignore_for_file: uri_has_not_been_generated
import 'package:auge_server/src/protos/generated/general/configuration.pb.dart' as configuration_pb;

/// Domain model class to represent a relationship between users and organizations
class Configuration {
  static final String className = 'Configuration';

  // Base fields
  static final String idField = 'id';
  String id;
  static final String versionField = 'version';
  int version;

  // Specific fields
  static final String organizationField = 'organization';
  Organization organization;

  static final String directoryServiceField = 'directoryService';
  DirectoryService directoryService;

  Configuration() {
    directoryService = DirectoryService();
  }

  configuration_pb.Configuration writeToProtoBuf() {
    configuration_pb.Configuration configurationPb = configuration_pb.Configuration();

    if (this.id != null) configurationPb.id = this.id;
    if (this.version != null) configurationPb.version = this.version;
    if (this.directoryService != null) configurationPb.directoryService = this.directoryService.writeToProtoBuf();
    if (this.organization != null) configurationPb.organization = this.organization.writeToProtoBuf();

    return configurationPb;
  }

/*
  readFromProtoBuf(user_profile_organization_pb.UserProfileOrganization userProfileOrganizationPb) {
    if (userProfileOrganizationPb.hasId()) this.id = userProfileOrganizationPb.id;
    if (userProfileOrganizationPb.hasVersion()) this.version = userProfileOrganizationPb.version;
    if (userProfileOrganizationPb.hasAuthorizationRole()) this.authorizationRole = userProfileOrganizationPb.authorizationRole;
    if (userProfileOrganizationPb.hasUser()) this.user = User()..readFromProtoBuf(userProfileOrganizationPb.user);
    if (userProfileOrganizationPb.hasOrganization()) this.organization = Organization()..readFromProtoBuf(userProfileOrganizationPb.organization);
  }
  static Map<String, dynamic> fromProtoBufToModelMap(user_profile_organization_pb.UserProfileOrganization userProfileOrganizationPb, [bool onlyIdAndSpecificationForDepthFields = false, bool isDeep = false]) {
    Map<String, dynamic> map = Map();

    if (onlyIdAndSpecificationForDepthFields && !isDeep) {
      if (userProfileOrganizationPb.hasId())
        map[UserProfileOrganization.idField] = userProfileOrganizationPb.id;
      if (userProfileOrganizationPb.hasUser()) {
        map[UserProfileOrganization.userField] =
            User.fromProtoBufToModelMap(userProfileOrganizationPb.user, onlyIdAndSpecificationForDepthFields, true);
      }
      if (userProfileOrganizationPb.hasOrganization())
        map[UserProfileOrganization.organizationField] =
            Organization.fromProtoBufToModelMap(
                userProfileOrganizationPb.organization, onlyIdAndSpecificationForDepthFields, true);
    } else {
      if (userProfileOrganizationPb.hasId())
        map[UserProfileOrganization.idField] = userProfileOrganizationPb.id;
      if (userProfileOrganizationPb.hasVersion())
        map[UserProfileOrganization.versionField] =
            userProfileOrganizationPb.version;
      if (userProfileOrganizationPb.hasUser())
        map[UserProfileOrganization.userField] =
            User.fromProtoBufToModelMap(userProfileOrganizationPb.user, onlyIdAndSpecificationForDepthFields, true);
      if (userProfileOrganizationPb.hasOrganization())
        map[UserProfileOrganization.organizationField] =
            Organization.fromProtoBufToModelMap(
                userProfileOrganizationPb.organization, onlyIdAndSpecificationForDepthFields, true);
    }
    return map;
  }

 */
}

class DirectoryService {
  static final String className = 'DirectoryServiceConfiguration';

  // CONNECTION
  static final String enabledField = 'enabled';
  bool enabled;
  static final String hostAddressField = 'hostAddress';
  String hostAddress;
  static final String portField = 'port';
  int port;
  static final String sslTlsField = 'sslTls';
  bool sslTls;

  // ADMIN
  static final String adminBindDNField = 'adminBindDN';
  String adminBindDN; //cn=admin,dc=auge,dc=levius,dc=com,dc=br
  static final String adminPasswordField = 'adminPassword';
  String adminPassword;

  // GROUP
  static final String groupSearchDNField = 'groupSearchDN';
  String groupSearchDN;
  static final String groupSearchScopeField = 'groupSearchScope';
  int groupSearchScope;
  static final String groupSearchFilterField = 'groupSearchFilter';
  String groupSearchFilter;
  static final String groupMemberAttributeField = 'groupMemberAttribute'; // User´s DN
  String groupMemberAttribute;

  // USER
  static final String userSearchDNField = 'userSearchDN';
  String userSearchDN;
  static final String userSearchScopeField = 'userSearchScope';
  int userSearchScope;
  static final String userSearchFilterField = 'userSearchFilter';
  String userSearchFilter;
  static final String userLoginAttributeField = 'userLoginAttribute';
  String userLoginAttribute;
  static final String userFirstNameAttributeField = 'userFirstNameAttribute';
  String userFirstNameAttribute;
  static final String userLastNameAttributeField = 'userLastNameAttribute';
  String userLastNameAttribute;
  static final String userEmailAttributeField = 'userEmailAttribute';
  String userEmailAttribute;

  configuration_pb.DirectoryService writeToProtoBuf() {
    configuration_pb.DirectoryService directoryServicePb = configuration_pb.DirectoryService();

    if (this.enabled != null) directoryServicePb.enabled = this.enabled;
    if (this.hostAddress != null) directoryServicePb.hostAddress = this.hostAddress;
    if (this.port != null) directoryServicePb.port = this.port;
    if (this.sslTls != null) directoryServicePb.sslTls = this.sslTls;
    if (this.adminBindDN != null) directoryServicePb.adminBindDN = this.adminBindDN;
    if (this.adminPassword != null) directoryServicePb.adminPassword = this.adminPassword;
    if (this.groupSearchDN != null) directoryServicePb.groupSearchDN = this.groupSearchDN;
    if (this.groupSearchScope != null) directoryServicePb.groupSearchScope = this.groupSearchScope;
    if (this.groupSearchFilter != null) directoryServicePb.groupSearchFilter = this.groupSearchFilter;
    if (this.groupMemberAttribute != null) directoryServicePb.groupMemberAttribute = this.groupMemberAttribute;
    if (this.userSearchDN != null) directoryServicePb.userSearchDN = this.userSearchDN;
    if (this.userSearchScope != null) directoryServicePb.userSearchScope = this.userSearchScope;
    if (this.userSearchFilter != null) directoryServicePb.userSearchFilter = this.userSearchFilter;
    if (this.userLoginAttribute != null) directoryServicePb.userLoginAttribute = this.userLoginAttribute;
    if (this.userFirstNameAttribute != null) directoryServicePb.userFirstNameAttribute = this.userFirstNameAttribute;
    if (this.userLastNameAttribute != null) directoryServicePb.userLastNameAttribute = this.userLastNameAttribute;
    if (this.userEmailAttribute != null) directoryServicePb.userEmailAttribute = this.userEmailAttribute;

    return directoryServicePb;
  }
}