// Copyright (c) 2018, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:auge_server/shared/common_utils.dart';

// ignore_for_file: uri_has_not_been_generated
import 'package:auge_server/src/protos/generated/general/organization_configuration.pb.dart' as organization_configuration_pb;

enum DirectoryServiceStatus {
  finished,
  errorException,
  errorNotConnected,
  errorNotBoundInvalidCredentials,
  errorGroupFilterInvalid,
  errorGroupOrGroupMemberNotFound,
  errorUserNotFound,
  errorUserFilterInvalid,
  errorProviderObjectIdAttributeNotFound,
  errorIdentificationAttributeNotFound,
  errorEmailAttributeNotFound,
  errorFirstNameAttributeNotFound,
  errorLastNameAttributeNotFound,
  errorUserAttributeForGroupRelationshipNotFound,
  errorUserAttributeValueForGroupRelationshipNotFound
}

enum DirectoryServiceEvent {
  skipEntry,
  userInsert,
  userUpdate,
  userDelete,
  userIdentityInsert,
  userIdentityUpdate,
  userIdentityDelete,
  userAccessInsert,
  userAccessUpdate,
  userAccessDelete,
}

/// Domain model class to represent a relationship between users and organizations
class OrganizationConfiguration {
  static final String className = 'OrganizationConfiguration';

  // Base fields
  static final String organizationIdField = 'organizationId';
  String organizationId;
  static final String versionField = 'version';
  int version;

  static final String domainField = 'domain';
  String domain;

  static final String directoryServiceEnabledField = 'directoryServiceEnabled';
  bool directoryServiceEnabled;

  // Specific fields
  static final String directoryServiceField = 'directoryService';
  DirectoryService directoryService;

  OrganizationConfiguration() {
    directoryService = DirectoryService();
  }

  organization_configuration_pb.OrganizationConfiguration writeToProtoBuf() {
    organization_configuration_pb.OrganizationConfiguration organizationConfigurationPb = organization_configuration_pb.OrganizationConfiguration();

    if (this.organizationId != null) organizationConfigurationPb.organizationId = this.organizationId;
    if (this.version != null) organizationConfigurationPb.version = this.version;
    if (this.domain != null) organizationConfigurationPb.domain = this.domain;
    if (this.directoryServiceEnabled != null) organizationConfigurationPb.directoryServiceEnabled = this.directoryServiceEnabled;
    if (this.directoryService != null) organizationConfigurationPb.directoryService = this.directoryService.writeToProtoBuf();
  //  if (this.organization != null) configurationPb.organization = this.organization.writeToProtoBuf();

    return organizationConfigurationPb;
  }

  void readFromProtoBuf(organization_configuration_pb.OrganizationConfiguration organizationConfigurationPb) {
    if (organizationConfigurationPb.hasOrganizationId()) this.organizationId = organizationConfigurationPb.organizationId;
    if (organizationConfigurationPb.hasVersion()) this.version = organizationConfigurationPb.version;
    if (organizationConfigurationPb.hasDomain()) this.domain = organizationConfigurationPb.domain;
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

      if (organizationConfigurationPb.hasDomain())
        map[OrganizationConfiguration.domainField] = organizationConfigurationPb.domain;
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
  static final String hostAddressField = 'hostAddress';
  String hostAddress;
  static final String portField = 'port';
  int port;
  static final String sslTlsField = 'sslTls';
  bool sslTls;
  static final String syncBindDnField = 'syncBindDn';
  String syncBindDn;
  static final String syncBindPasswordField = 'syncBindPassword';
  String syncBindPassword;
  static final String syncIntervalField = 'sync';
  int syncInterval;
  static final String syncLastDateTimeField = 'syncLastDateTime';
  DateTime syncLastDateTime;
  static final String syncLastResultField = 'syncLastResult';
  String syncLastResult;

  // GROUP
  static final String groupSearchDNField = 'groupSearchDN';
  String groupSearchDN;
  static final String groupSearchScopeField = 'groupSearchScope';
  int groupSearchScope;
  static final String groupSearchFilterField = 'groupSearchFilter';
  String groupSearchFilter;
  static final String groupMemberUserAttributeField = 'groupMemberUserAttribute'; // The attribute of the group that will be used to filter against the User Attribute
  String groupMemberUserAttribute;


  // USER
  static final String userSearchDNField = 'userSearchDN';
  String userSearchDN;
  static final String userSearchScopeField = 'userSearchScope';
  int userSearchScope;
  static final String userSearchFilterField = 'userSearchFilter';
  String userSearchFilter;
  // AD objectGUID or OpenLDAP entryUUID
  static final String userProviderObjectIdAttributeField = 'userProviderObjectIdAttribute';
  String userProviderObjectIdAttribute;
  // AD samAccountName / UserPrincipalName or OpenLDAP uid
  static final String userIdentificationAttributeField = 'userIdentificationAttribute';
  String userIdentificationAttribute;
  static final String userEmailAttributeField = 'userEmailAttribute';
  String userEmailAttribute;
  static final String userFirstNameAttributeField = 'userFirstNameAttribute';
  String userFirstNameAttribute;
  static final String userLastNameAttributeField = 'userLastNameAttribute';
  String userLastNameAttribute;
  static final String userAttributeForGroupRelationshipField = 'userAttributeForGroupRelationship'; //  A unique identifier used to check if the user is a member of the group
  String userAttributeForGroupRelationship;


  organization_configuration_pb.DirectoryService writeToProtoBuf() {
    organization_configuration_pb.DirectoryService directoryServicePb = organization_configuration_pb.DirectoryService();


    if (this.hostAddress != null) directoryServicePb.hostAddress = this.hostAddress;
    if (this.port != null) directoryServicePb.port = this.port;
    if (this.sslTls != null) directoryServicePb.sslTls = this.sslTls;
    if (this.syncBindDn != null) directoryServicePb.syncBindDn = this.syncBindDn;
    if (this.syncBindPassword != null) directoryServicePb.syncBindPassword = this.syncBindPassword;
    if (this.syncInterval != null) directoryServicePb.syncInterval = this.syncInterval;
    if (this.syncLastDateTime != null) directoryServicePb.syncLastDateTime = CommonUtils.timestampFromDateTime(this.syncLastDateTime);
    if (this.syncLastResult != null) directoryServicePb.syncLastResult = this.syncLastResult;
    if (this.groupSearchDN != null) directoryServicePb.groupSearchDN = this.groupSearchDN;
    if (this.groupSearchScope != null) directoryServicePb.groupSearchScope = this.groupSearchScope;
    if (this.groupSearchFilter != null) directoryServicePb.groupSearchFilter = this.groupSearchFilter;
    if (this.groupMemberUserAttribute != null) directoryServicePb.groupMemberUserAttribute = this.groupMemberUserAttribute;
    if (this.userAttributeForGroupRelationship != null) directoryServicePb.userAttributeForGroupRelationship = this.userAttributeForGroupRelationship;
    if (this.userSearchDN != null) directoryServicePb.userSearchDN = this.userSearchDN;
    if (this.userSearchScope != null) directoryServicePb.userSearchScope = this.userSearchScope;
    if (this.userSearchFilter != null) directoryServicePb.userSearchFilter = this.userSearchFilter;
    if (this.userProviderObjectIdAttribute != null) directoryServicePb.userProviderObjectIdAttribute = this.userProviderObjectIdAttribute;
    if (this.userIdentificationAttribute != null) directoryServicePb.userIdentificationAttribute = this.userIdentificationAttribute;
    if (this.userFirstNameAttribute != null) directoryServicePb.userFirstNameAttribute = this.userFirstNameAttribute;
    if (this.userLastNameAttribute != null) directoryServicePb.userLastNameAttribute = this.userLastNameAttribute;
    if (this.userEmailAttribute != null) directoryServicePb.userEmailAttribute = this.userEmailAttribute;

    return directoryServicePb;
  }

  void readFromProtoBuf(organization_configuration_pb.DirectoryService directoryServicePb) {

    if (directoryServicePb.hasHostAddress()) this.hostAddress = directoryServicePb.hostAddress;
    if (directoryServicePb.hasPort()) this.port = directoryServicePb.port;
    if (directoryServicePb.hasSslTls()) this.sslTls = directoryServicePb.sslTls;
    if (directoryServicePb.hasSyncBindDn()) this.syncBindDn = directoryServicePb.syncBindDn;
    if (directoryServicePb.hasSyncBindPassword()) this.syncBindPassword = directoryServicePb.syncBindPassword;
    if (directoryServicePb.hasSyncInterval()) this.syncInterval = directoryServicePb.syncInterval;
    if (directoryServicePb.hasSyncLastDateTime()) this.syncLastDateTime = CommonUtils.dateTimeFromTimestamp(directoryServicePb.syncLastDateTime);
    if (directoryServicePb.hasSyncLastResult()) this.syncLastResult = directoryServicePb.syncLastResult;
    if (directoryServicePb.hasGroupSearchDN()) this.groupSearchDN = directoryServicePb.groupSearchDN;
    if (directoryServicePb.hasGroupSearchScope()) this.groupSearchScope = directoryServicePb.groupSearchScope;
    if (directoryServicePb.hasGroupSearchFilter()) this.groupSearchFilter = directoryServicePb.groupSearchFilter;
    if (directoryServicePb.hasGroupMemberUserAttribute()) this.groupMemberUserAttribute = directoryServicePb.groupMemberUserAttribute;
    if (directoryServicePb.hasUserAttributeForGroupRelationship()) this.userAttributeForGroupRelationship = directoryServicePb.userAttributeForGroupRelationship;
    if (directoryServicePb.hasUserSearchDN()) this.userSearchDN = directoryServicePb.userSearchDN;
    if (directoryServicePb.hasUserSearchScope()) this.userSearchScope = directoryServicePb.userSearchScope;
    if (directoryServicePb.hasUserSearchFilter()) this.userSearchFilter = directoryServicePb.userSearchFilter;
    if (directoryServicePb.hasUserProviderObjectIdAttribute()) this.userProviderObjectIdAttribute = directoryServicePb.userProviderObjectIdAttribute;
    if (directoryServicePb.hasUserIdentificationAttribute()) this.userIdentificationAttribute = directoryServicePb.userIdentificationAttribute;
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

      if (directoryServicePb.hasSyncBindDn())
        map[DirectoryService.syncBindDnField] =
            directoryServicePb.syncBindDn;

      if (directoryServicePb.hasSyncBindPassword())
        map[DirectoryService.syncBindPasswordField] =
            directoryServicePb.syncBindPassword;

      if (directoryServicePb.hasSyncInterval())
        map[DirectoryService.syncIntervalField] =
            directoryServicePb.syncInterval;

      if (directoryServicePb.hasSyncLastDateTime())
        map[DirectoryService.syncLastDateTimeField] =
            directoryServicePb.syncLastDateTime;

      if (directoryServicePb.hasSyncLastResult())
        map[DirectoryService.syncLastResultField] =
            directoryServicePb.syncLastResult;

      if (directoryServicePb.hasGroupSearchDN())
        map[DirectoryService.groupSearchDNField] =
            directoryServicePb.groupSearchDN;

      if (directoryServicePb.hasGroupSearchScope())
        map[DirectoryService.groupSearchScopeField] =
            directoryServicePb.groupSearchFilter;

      if (directoryServicePb.hasGroupMemberUserAttribute())
        map[DirectoryService.groupMemberUserAttributeField] =
            directoryServicePb.groupMemberUserAttribute;

      if (directoryServicePb.hasUserAttributeForGroupRelationship())
        map[DirectoryService.userAttributeForGroupRelationshipField] =
            directoryServicePb.userAttributeForGroupRelationship;

      if (directoryServicePb.hasUserSearchDN())
        map[DirectoryService.userSearchDNField] =
            directoryServicePb.userSearchDN;

      if (directoryServicePb.hasUserSearchScope())
        map[DirectoryService.userSearchScopeField] =
            directoryServicePb.userSearchScope;

      if (directoryServicePb.hasUserSearchFilter())
        map[DirectoryService.userSearchFilterField] =
            directoryServicePb.userSearchFilter;

      if (directoryServicePb.hasUserProviderObjectIdAttribute())
        map[DirectoryService.userProviderObjectIdAttributeField] =
            directoryServicePb.userProviderObjectIdAttribute;

      if (directoryServicePb.hasUserIdentificationAttribute())
        map[DirectoryService.userIdentificationAttributeField] =
            directoryServicePb.userIdentificationAttribute;

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