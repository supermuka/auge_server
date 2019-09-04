// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'package:auge_server/shared/common_utils.dart';
import 'package:auge_server/model/general/organization.dart';
// ignore_for_file: uri_has_not_been_generated
import 'package:auge_server/src/protos/generated/general/organization_directory_service.pb.dart' as organization_directory_service_pb;

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
  entry,
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

/// Domain model class to represent a directory services
class OrganizationDirectoryService {
  static final String className = 'OrganizationDirectoryService';

  // Base fields
  static final String idField = 'id';
  String id;
  static final String versionField = 'version';
  int version;

  // CONNECTION
  static final String directoryServiceEnabledField = 'directoryServiceEnabled';
  bool directoryServiceEnabled;
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

  static final String organizationField = 'organization';
  Organization organization;


  organization_directory_service_pb.OrganizationDirectoryService writeToProtoBuf() {
    organization_directory_service_pb.OrganizationDirectoryService organizationDirectoryServicePb = organization_directory_service_pb.OrganizationDirectoryService();


    if (this.directoryServiceEnabled != null) organizationDirectoryServicePb.directoryServiceEnabled = this.directoryServiceEnabled;
    if (this.hostAddress != null) organizationDirectoryServicePb.hostAddress = this.hostAddress;
    if (this.port != null) organizationDirectoryServicePb.port = this.port;
    if (this.sslTls != null) organizationDirectoryServicePb.sslTls = this.sslTls;
    if (this.syncBindDn != null) organizationDirectoryServicePb.syncBindDn = this.syncBindDn;
    if (this.syncBindPassword != null) organizationDirectoryServicePb.syncBindPassword = this.syncBindPassword;
    if (this.syncInterval != null) organizationDirectoryServicePb.syncInterval = this.syncInterval;
    if (this.syncLastDateTime != null) organizationDirectoryServicePb.syncLastDateTime = CommonUtils.timestampFromDateTime(this.syncLastDateTime);
    if (this.syncLastResult != null) organizationDirectoryServicePb.syncLastResult = this.syncLastResult;
    if (this.groupSearchDN != null) organizationDirectoryServicePb.groupSearchDN = this.groupSearchDN;
    if (this.groupSearchScope != null) organizationDirectoryServicePb.groupSearchScope = this.groupSearchScope;
    if (this.groupSearchFilter != null) organizationDirectoryServicePb.groupSearchFilter = this.groupSearchFilter;
    if (this.groupMemberUserAttribute != null) organizationDirectoryServicePb.groupMemberUserAttribute = this.groupMemberUserAttribute;
    if (this.userAttributeForGroupRelationship != null) organizationDirectoryServicePb.userAttributeForGroupRelationship = this.userAttributeForGroupRelationship;
    if (this.userSearchDN != null) organizationDirectoryServicePb.userSearchDN = this.userSearchDN;
    if (this.userSearchScope != null) organizationDirectoryServicePb.userSearchScope = this.userSearchScope;
    if (this.userSearchFilter != null) organizationDirectoryServicePb.userSearchFilter = this.userSearchFilter;
    if (this.userProviderObjectIdAttribute != null) organizationDirectoryServicePb.userProviderObjectIdAttribute = this.userProviderObjectIdAttribute;
    if (this.userIdentificationAttribute != null) organizationDirectoryServicePb.userIdentificationAttribute = this.userIdentificationAttribute;
    if (this.userFirstNameAttribute != null) organizationDirectoryServicePb.userFirstNameAttribute = this.userFirstNameAttribute;
    if (this.userLastNameAttribute != null) organizationDirectoryServicePb.userLastNameAttribute = this.userLastNameAttribute;
    if (this.userEmailAttribute != null) organizationDirectoryServicePb.userEmailAttribute = this.userEmailAttribute;
    if (this.organization != null) organizationDirectoryServicePb.organization = this.organization.writeToProtoBuf();

    return organizationDirectoryServicePb;
  }

  void readFromProtoBuf(organization_directory_service_pb.OrganizationDirectoryService organizationDirectoryServicePb) {

    if (organizationDirectoryServicePb.hasDirectoryServiceEnabled()) this.directoryServiceEnabled = organizationDirectoryServicePb.directoryServiceEnabled;
    if (organizationDirectoryServicePb.hasHostAddress()) this.hostAddress = organizationDirectoryServicePb.hostAddress;
    if (organizationDirectoryServicePb.hasPort()) this.port = organizationDirectoryServicePb.port;
    if (organizationDirectoryServicePb.hasSslTls()) this.sslTls = organizationDirectoryServicePb.sslTls;
    if (organizationDirectoryServicePb.hasSyncBindDn()) this.syncBindDn = organizationDirectoryServicePb.syncBindDn;
    if (organizationDirectoryServicePb.hasSyncBindPassword()) this.syncBindPassword = organizationDirectoryServicePb.syncBindPassword;
    if (organizationDirectoryServicePb.hasSyncInterval()) this.syncInterval = organizationDirectoryServicePb.syncInterval;
    if (organizationDirectoryServicePb.hasSyncLastDateTime()) this.syncLastDateTime = CommonUtils.dateTimeFromTimestamp(organizationDirectoryServicePb.syncLastDateTime);
    if (organizationDirectoryServicePb.hasSyncLastResult()) this.syncLastResult = organizationDirectoryServicePb.syncLastResult;
    if (organizationDirectoryServicePb.hasGroupSearchDN()) this.groupSearchDN = organizationDirectoryServicePb.groupSearchDN;
    if (organizationDirectoryServicePb.hasGroupSearchScope()) this.groupSearchScope = organizationDirectoryServicePb.groupSearchScope;
    if (organizationDirectoryServicePb.hasGroupSearchFilter()) this.groupSearchFilter = organizationDirectoryServicePb.groupSearchFilter;
    if (organizationDirectoryServicePb.hasGroupMemberUserAttribute()) this.groupMemberUserAttribute = organizationDirectoryServicePb.groupMemberUserAttribute;
    if (organizationDirectoryServicePb.hasUserAttributeForGroupRelationship()) this.userAttributeForGroupRelationship = organizationDirectoryServicePb.userAttributeForGroupRelationship;
    if (organizationDirectoryServicePb.hasUserSearchDN()) this.userSearchDN = organizationDirectoryServicePb.userSearchDN;
    if (organizationDirectoryServicePb.hasUserSearchScope()) this.userSearchScope = organizationDirectoryServicePb.userSearchScope;
    if (organizationDirectoryServicePb.hasUserSearchFilter()) this.userSearchFilter = organizationDirectoryServicePb.userSearchFilter;
    if (organizationDirectoryServicePb.hasUserProviderObjectIdAttribute()) this.userProviderObjectIdAttribute = organizationDirectoryServicePb.userProviderObjectIdAttribute;
    if (organizationDirectoryServicePb.hasUserIdentificationAttribute()) this.userIdentificationAttribute = organizationDirectoryServicePb.userIdentificationAttribute;
    if (organizationDirectoryServicePb.hasUserFirstNameAttribute()) this.userFirstNameAttribute = organizationDirectoryServicePb.userFirstNameAttribute;
    if (organizationDirectoryServicePb.hasUserLastNameAttribute()) this.userLastNameAttribute = organizationDirectoryServicePb.userLastNameAttribute;
    if (organizationDirectoryServicePb.hasUserEmailAttribute()) this.userEmailAttribute = organizationDirectoryServicePb.userEmailAttribute;
    if (organizationDirectoryServicePb.hasOrganization()) this.organization = Organization()..readFromProtoBuf(organizationDirectoryServicePb.organization);

  }

  static Map<String, dynamic> fromProtoBufToModelMap(organization_directory_service_pb.OrganizationDirectoryService organizationDirectoryServicePb, [bool onlyIdAndSpecificationForDepthFields = false, bool isDeep = false]) {
  Map<String, dynamic> map = Map();

  if (onlyIdAndSpecificationForDepthFields && isDeep) {

    if (organizationDirectoryServicePb.hasId())
      map[OrganizationDirectoryService.idField] =
          organizationDirectoryServicePb.id;
  } else {
    if (organizationDirectoryServicePb.hasId())
      map[OrganizationDirectoryService.idField] =
          organizationDirectoryServicePb.id;

    if (organizationDirectoryServicePb.hasHostAddress())
    map[OrganizationDirectoryService.hostAddressField] =
        organizationDirectoryServicePb.hostAddress;

    if (organizationDirectoryServicePb.hasPort())
    map[OrganizationDirectoryService.portField] =
        organizationDirectoryServicePb.port;

    if (organizationDirectoryServicePb.hasSslTls())
    map[OrganizationDirectoryService.sslTlsField] =
        organizationDirectoryServicePb.sslTls;

    if (organizationDirectoryServicePb.hasSyncBindDn())
    map[OrganizationDirectoryService.syncBindDnField] =
        organizationDirectoryServicePb.syncBindDn;

    if (organizationDirectoryServicePb.hasSyncBindPassword())
    map[OrganizationDirectoryService.syncBindPasswordField] =
        organizationDirectoryServicePb.syncBindPassword;

    if (organizationDirectoryServicePb.hasSyncInterval())
    map[OrganizationDirectoryService.syncIntervalField] =
        organizationDirectoryServicePb.syncInterval;

    if (organizationDirectoryServicePb.hasSyncLastDateTime())
    map[OrganizationDirectoryService.syncLastDateTimeField] =
        organizationDirectoryServicePb.syncLastDateTime;

    if (organizationDirectoryServicePb.hasSyncLastResult())
    map[OrganizationDirectoryService.syncLastResultField] =
        organizationDirectoryServicePb.syncLastResult;

    if (organizationDirectoryServicePb.hasGroupSearchDN())
    map[OrganizationDirectoryService.groupSearchDNField] =
        organizationDirectoryServicePb.groupSearchDN;

    if (organizationDirectoryServicePb.hasGroupSearchScope())
    map[OrganizationDirectoryService.groupSearchScopeField] =
        organizationDirectoryServicePb.groupSearchFilter;

    if (organizationDirectoryServicePb.hasGroupMemberUserAttribute())
    map[OrganizationDirectoryService.groupMemberUserAttributeField] =
        organizationDirectoryServicePb.groupMemberUserAttribute;

    if (organizationDirectoryServicePb.hasUserAttributeForGroupRelationship())
    map[OrganizationDirectoryService.userAttributeForGroupRelationshipField] =
        organizationDirectoryServicePb.userAttributeForGroupRelationship;

    if (organizationDirectoryServicePb.hasUserSearchDN())
    map[OrganizationDirectoryService.userSearchDNField] =
        organizationDirectoryServicePb.userSearchDN;

    if (organizationDirectoryServicePb.hasUserSearchScope())
    map[OrganizationDirectoryService.userSearchScopeField] =
        organizationDirectoryServicePb.userSearchScope;

    if (organizationDirectoryServicePb.hasUserSearchFilter())
    map[OrganizationDirectoryService.userSearchFilterField] =
        organizationDirectoryServicePb.userSearchFilter;

    if (organizationDirectoryServicePb.hasUserProviderObjectIdAttribute())
    map[OrganizationDirectoryService.userProviderObjectIdAttributeField] =
        organizationDirectoryServicePb.userProviderObjectIdAttribute;

    if (organizationDirectoryServicePb.hasUserIdentificationAttribute())
    map[OrganizationDirectoryService.userIdentificationAttributeField] =
        organizationDirectoryServicePb.userIdentificationAttribute;

    if (organizationDirectoryServicePb.hasUserFirstNameAttribute())
    map[OrganizationDirectoryService.userFirstNameAttributeField] =
        organizationDirectoryServicePb.userFirstNameAttribute;

    if (organizationDirectoryServicePb.hasUserLastNameAttribute())
    map[OrganizationDirectoryService.userLastNameAttributeField] =
        organizationDirectoryServicePb.userLastNameAttribute;

    if (organizationDirectoryServicePb.hasUserEmailAttribute())
    map[OrganizationDirectoryService.userEmailAttributeField] =
        organizationDirectoryServicePb.userEmailAttribute;

    if (organizationDirectoryServicePb.hasOrganization())
      map[OrganizationDirectoryService.organizationField] =
          Organization.fromProtoBufToModelMap(
              organizationDirectoryServicePb.organization, onlyIdAndSpecificationForDepthFields, true);

    }
    return map;
  }
}