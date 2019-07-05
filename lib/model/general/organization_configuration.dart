// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:auge_server/model/general/organization.dart';

import 'package:auge_server/shared/common_utils.dart';

// ignore_for_file: uri_has_not_been_generated
import 'package:auge_server/src/protos/generated/general/organization_configuration.pb.dart' as organization_configuration_pb;

enum DirectoryServiceStatus {
  success,
  errorException,
  errorNotConnected,
  errorNotBindedInvalidCredentials,
  errorGroupFilterInvalid,
  errorGroupNotFound,
  errorManyGroupsFound,
  errorGroupMemberAttributeNotFound,
  errorUserNotFound,
  errorLoginAttribute,
  errorEmailAttribute,
  errorFirstNameAttribute,
  errorLastNameAttribute
}


/// Domain model class to represent a relationship between users and organizations
class OrganizationConfiguration {
  static final String className = 'OrganizationConfiguration';

  // Base fields
  static final String organizationIdField = 'organizationId';
  String organizationId;
  static final String versionField = 'version';
  int version;

  static final String directoryServiceEnabledField = 'directoryServiceEnabled';
  bool directoryServiceEnabled;

  // Specific fields
  static final String organizationField = 'organization';
  Organization organization;

  static final String directoryServiceField = 'directoryService';
  DirectoryService directoryService;

  OrganizationConfiguration() {
    directoryService = DirectoryService();
  }

  organization_configuration_pb.OrganizationConfiguration writeToProtoBuf() {
    organization_configuration_pb.OrganizationConfiguration organizationConfigurationPb = organization_configuration_pb.OrganizationConfiguration();

    if (this.organizationId != null) organizationConfigurationPb.organizationId = this.organizationId;
    if (this.version != null) organizationConfigurationPb.version = this.version;
    if (this.directoryServiceEnabled != null) organizationConfigurationPb.directoryServiceEnabled = this.directoryServiceEnabled;
    if (this.directoryService != null) organizationConfigurationPb.directoryService = this.directoryService.writeToProtoBuf();
  //  if (this.organization != null) configurationPb.organization = this.organization.writeToProtoBuf();

    return organizationConfigurationPb;
  }

  void readFromProtoBuf(organization_configuration_pb.OrganizationConfiguration organizationConfigurationPb) {
    if (organizationConfigurationPb.hasOrganizationId()) this.organizationId = organizationConfigurationPb.organizationId;
    if (organizationConfigurationPb.hasVersion()) this.version = organizationConfigurationPb.version;
    if (organizationConfigurationPb.hasDirectoryServiceEnabled()) this.directoryServiceEnabled = organizationConfigurationPb.directoryServiceEnabled;
    if (organizationConfigurationPb.hasDirectoryService()) this.directoryService = DirectoryService()..readFromProtoBuf(organizationConfigurationPb.directoryService);
 //   if (organizationConfigurationPb.hasOrganization()) this.organization = Organization()..readFromProtoBuf(organizationConfigurationPb.organization);
  }

  static Map<String, dynamic> fromProtoBufToModelMap(organization_configuration_pb.OrganizationConfiguration organizationConfigurationPb, [bool onlyIdAndSpecificationForDepthFields = false, bool isDeep = false]) {
    Map<String, dynamic> map = Map();

    if (onlyIdAndSpecificationForDepthFields && isDeep) {
      if (organizationConfigurationPb.hasOrganizationId())
        map[OrganizationConfiguration.organizationIdField] = organizationConfigurationPb.organizationId;
      /*
      if (configurationPb.hasOrganization())
        map[Configuration.organizationField] =
            Organization.fromProtoBufToModelMap(
                configurationPb.organization, onlyIdAndSpecificationForDepthFields, true);

       */
    } else {

      if (organizationConfigurationPb.hasOrganizationId())
        map[OrganizationConfiguration.organizationIdField] = organizationConfigurationPb.organizationId;

      if (organizationConfigurationPb.hasVersion())
        map[OrganizationConfiguration.versionField] =
            organizationConfigurationPb.version;

      if (organizationConfigurationPb.hasDirectoryServiceEnabled())
        map[OrganizationConfiguration.directoryServiceEnabledField] =
            organizationConfigurationPb.directoryServiceEnabled;
/*
      if (configurationPb.hasOrganization())
        map[Configuration.organizationField] =
            Organization.fromProtoBufToModelMap(
                configurationPb.organization, onlyIdAndSpecificationForDepthFields, true);
*/
      if (organizationConfigurationPb.hasDirectoryService())
        map[OrganizationConfiguration.directoryServiceField] =
            DirectoryService.fromProtoBufToModelMap(
                organizationConfigurationPb.directoryService, onlyIdAndSpecificationForDepthFields, true);
    }
    return map;
  }

}

class DirectoryService {
  static final String className = 'DirectoryServiceConfiguration';

  // CONNECTION
  static final String syncIntervalField = 'syncInterval';
  int syncInterval;
  static final String lastSyncField = 'lastSync';
  DateTime lastSync;
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

  organization_configuration_pb.DirectoryService writeToProtoBuf() {
    organization_configuration_pb.DirectoryService directoryServicePb = organization_configuration_pb.DirectoryService();

    if (this.syncInterval != null) directoryServicePb.syncInterval = this.syncInterval;
    if (this.lastSync != null) directoryServicePb.lastSync = CommonUtils.timestampFromDateTime(this.lastSync);
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

  void readFromProtoBuf(organization_configuration_pb.DirectoryService directoryServicePb) {

    if (directoryServicePb.hasSyncInterval()) this.syncInterval = directoryServicePb.syncInterval;
    if (directoryServicePb.hasLastSync()) this.lastSync = CommonUtils.dateTimeFromTimestamp(directoryServicePb.lastSync);
    if (directoryServicePb.hasHostAddress()) this.hostAddress = directoryServicePb.hostAddress;
    if (directoryServicePb.hasPort()) this.port = directoryServicePb.port;
    if (directoryServicePb.hasSslTls()) this.sslTls = directoryServicePb.sslTls;
    if (directoryServicePb.hasAdminBindDN()) this.adminBindDN = directoryServicePb.adminBindDN;
    if (directoryServicePb.hasAdminPassword()) this.adminPassword = directoryServicePb.adminPassword;
    if (directoryServicePb.hasGroupSearchDN()) this.groupSearchDN = directoryServicePb.groupSearchDN;
    if (directoryServicePb.hasGroupSearchScope()) this.groupSearchScope = directoryServicePb.groupSearchScope;
    if (directoryServicePb.hasGroupSearchFilter()) this.groupSearchFilter = directoryServicePb.groupSearchFilter;
    if (directoryServicePb.hasGroupMemberAttribute()) this.groupMemberAttribute = directoryServicePb.groupMemberAttribute;
    if (directoryServicePb.hasUserSearchDN()) this.userSearchDN = directoryServicePb.userSearchDN;
    if (directoryServicePb.hasUserSearchScope()) this.userSearchScope = directoryServicePb.userSearchScope;
    if (directoryServicePb.hasUserSearchFilter()) this.userSearchFilter = directoryServicePb.userSearchFilter;
    if (directoryServicePb.hasUserLoginAttribute()) this.userLoginAttribute = directoryServicePb.userLoginAttribute;
    if (directoryServicePb.hasUserFirstNameAttribute()) this.userFirstNameAttribute = directoryServicePb.userFirstNameAttribute;
    if (directoryServicePb.hasUserLastNameAttribute()) this.userLastNameAttribute = directoryServicePb.userLastNameAttribute;
    if (directoryServicePb.hasUserEmailAttribute()) this.userEmailAttribute = directoryServicePb.userEmailAttribute;

  }

  static Map<String, dynamic> fromProtoBufToModelMap(organization_configuration_pb.DirectoryService directoryServicePb, [bool onlyIdAndSpecificationForDepthFields = false, bool isDeep = false]) {
    Map<String, dynamic> map = Map();

    if (onlyIdAndSpecificationForDepthFields && isDeep) {
      /*
      if (directoryServicePb.hasId())
        map[Configuration.idField] = directoryServicePb.id;
      if (configurationPb.hasOrganization())
        map[Configuration.organizationField] =
            Organization.fromProtoBufToModelMap(
                configurationPb.organization, onlyIdAndSpecificationForDepthFields, true);

       */
    } else {

      if (directoryServicePb.hasHostAddress())
        map[DirectoryService.hostAddressField] =
            directoryServicePb.hostAddress;

      if (directoryServicePb.hasPort())
        map[DirectoryService.portField] =
            directoryServicePb.port;

      if (directoryServicePb.hasSslTls())
        map[DirectoryService.sslTlsField] =
            directoryServicePb.sslTls;

      if (directoryServicePb.hasSyncInterval())
        map[DirectoryService.syncIntervalField] =
            directoryServicePb.syncInterval;

      if (directoryServicePb.hasLastSync())
        map[DirectoryService.lastSyncField] =
            directoryServicePb.lastSync;

      if (directoryServicePb.hasGroupSearchDN())
        map[DirectoryService.groupSearchDNField] =
            directoryServicePb.groupSearchDN;

      if (directoryServicePb.hasGroupSearchScope())
        map[DirectoryService.groupSearchScopeField] =
            directoryServicePb.groupSearchFilter;

      if (directoryServicePb.hasGroupMemberAttribute())
        map[DirectoryService.groupMemberAttributeField] =
            directoryServicePb.groupMemberAttribute;

      if (directoryServicePb.hasUserSearchDN())
        map[DirectoryService.userSearchDNField] =
            directoryServicePb.userSearchDN;

      if (directoryServicePb.hasUserSearchScope())
        map[DirectoryService.userSearchScopeField] =
            directoryServicePb.userSearchScope;

      if (directoryServicePb.hasUserSearchFilter())
        map[DirectoryService.userSearchFilterField] =
            directoryServicePb.userSearchFilter;

      if (directoryServicePb.hasUserLoginAttribute())
        map[DirectoryService.userLoginAttributeField] =
            directoryServicePb.userLoginAttribute;

      if (directoryServicePb.hasUserFirstNameAttribute())
        map[DirectoryService.userFirstNameAttributeField] =
            directoryServicePb.userFirstNameAttribute;

      if (directoryServicePb.hasUserLastNameAttribute())
        map[DirectoryService.userLastNameAttributeField] =
            directoryServicePb.userLastNameAttribute;

      if (directoryServicePb.hasUserEmailAttribute())
        map[DirectoryService.userEmailAttributeField] =
            directoryServicePb.userEmailAttribute;
    }
    return map;
  }

}