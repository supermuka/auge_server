///
//  Generated code. Do not modify.
//  source: general/organization_directory_service.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const OrganizationDirectoryService$json = const {
  '1': 'OrganizationDirectoryService',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'version', '3': 2, '4': 1, '5': 5, '10': 'version'},
    const {'1': 'directory_service_enabled', '3': 3, '4': 1, '5': 8, '10': 'directoryServiceEnabled'},
    const {'1': 'host_address', '3': 4, '4': 1, '5': 9, '10': 'hostAddress'},
    const {'1': 'port', '3': 5, '4': 1, '5': 5, '10': 'port'},
    const {'1': 'ssl_tls', '3': 6, '4': 1, '5': 8, '10': 'sslTls'},
    const {'1': 'sync_bind_dn', '3': 7, '4': 1, '5': 9, '10': 'syncBindDn'},
    const {'1': 'sync_bind_password', '3': 8, '4': 1, '5': 9, '10': 'syncBindPassword'},
    const {'1': 'sync_interval', '3': 9, '4': 1, '5': 5, '10': 'syncInterval'},
    const {'1': 'sync_last_date_time', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'syncLastDateTime'},
    const {'1': 'sync_last_result', '3': 11, '4': 1, '5': 9, '10': 'syncLastResult'},
    const {'1': 'group_search_DN', '3': 12, '4': 1, '5': 9, '10': 'groupSearchDN'},
    const {'1': 'group_search_scope', '3': 13, '4': 1, '5': 5, '10': 'groupSearchScope'},
    const {'1': 'group_search_filter', '3': 14, '4': 1, '5': 9, '10': 'groupSearchFilter'},
    const {'1': 'group_member_user_attribute', '3': 15, '4': 1, '5': 9, '10': 'groupMemberUserAttribute'},
    const {'1': 'user_search_DN', '3': 16, '4': 1, '5': 9, '10': 'userSearchDN'},
    const {'1': 'user_search_scope', '3': 17, '4': 1, '5': 5, '10': 'userSearchScope'},
    const {'1': 'user_search_filter', '3': 18, '4': 1, '5': 9, '10': 'userSearchFilter'},
    const {'1': 'user_provider_object_id_attribute', '3': 19, '4': 1, '5': 9, '10': 'userProviderObjectIdAttribute'},
    const {'1': 'user_identification_attribute', '3': 20, '4': 1, '5': 9, '10': 'userIdentificationAttribute'},
    const {'1': 'user_email_attribute', '3': 21, '4': 1, '5': 9, '10': 'userEmailAttribute'},
    const {'1': 'user_first_name_attribute', '3': 22, '4': 1, '5': 9, '10': 'userFirstNameAttribute'},
    const {'1': 'user_last_name_attribute', '3': 23, '4': 1, '5': 9, '10': 'userLastNameAttribute'},
    const {'1': 'user_attribute_for_group_relationship', '3': 24, '4': 1, '5': 9, '10': 'userAttributeForGroupRelationship'},
    const {'1': 'organization', '3': 25, '4': 1, '5': 11, '6': '.auge.protobuf.Organization', '10': 'organization'},
  ],
};

const OrganizationDirectoryServiceRequest$json = const {
  '1': 'OrganizationDirectoryServiceRequest',
  '2': const [
    const {'1': 'organizationDirectoryService', '3': 1, '4': 1, '5': 11, '6': '.auge.protobuf.OrganizationDirectoryService', '10': 'organizationDirectoryService'},
    const {'1': 'auth_user_id', '3': 2, '4': 1, '5': 9, '10': 'authUserId'},
    const {'1': 'auth_organization_id', '3': 3, '4': 1, '5': 9, '10': 'authOrganizationId'},
  ],
};

const OrganizationDirectoryServiceAuthRequest$json = const {
  '1': 'OrganizationDirectoryServiceAuthRequest',
  '2': const [
    const {'1': 'organization_id', '3': 1, '4': 1, '5': 9, '10': 'organizationId'},
    const {'1': 'identification', '3': 2, '4': 1, '5': 9, '10': 'identification'},
    const {'1': 'password', '3': 3, '4': 1, '5': 9, '10': 'password'},
  ],
};

const OrganizationDirectoryServiceGetRequest$json = const {
  '1': 'OrganizationDirectoryServiceGetRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'organization_id', '3': 2, '4': 1, '5': 9, '10': 'organizationId'},
  ],
};

