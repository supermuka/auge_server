///
//  Generated code. Do not modify.
//  source: general/configuration.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const Configuration$json = const {
  '1': 'Configuration',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'version', '3': 2, '4': 1, '5': 5, '10': 'version'},
    const {'1': 'directory_service_enabled', '3': 3, '4': 1, '5': 8, '10': 'directoryServiceEnabled'},
    const {'1': 'organization', '3': 4, '4': 1, '5': 11, '6': '.auge.protobuf.Organization', '10': 'organization'},
    const {'1': 'directory_service', '3': 5, '4': 1, '5': 11, '6': '.auge.protobuf.DirectoryService', '10': 'directoryService'},
  ],
};

const DirectoryService$json = const {
  '1': 'DirectoryService',
  '2': const [
    const {'1': 'syncInterval', '3': 1, '4': 1, '5': 5, '10': 'syncInterval'},
    const {'1': 'lastSync', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastSync'},
    const {'1': 'host_address', '3': 3, '4': 1, '5': 9, '10': 'hostAddress'},
    const {'1': 'port', '3': 4, '4': 1, '5': 5, '10': 'port'},
    const {'1': 'ssl_tls', '3': 5, '4': 1, '5': 8, '10': 'sslTls'},
    const {'1': 'admin_bind_DN', '3': 6, '4': 1, '5': 9, '10': 'adminBindDN'},
    const {'1': 'admin_password', '3': 7, '4': 1, '5': 9, '10': 'adminPassword'},
    const {'1': 'group_search_DN', '3': 8, '4': 1, '5': 9, '10': 'groupSearchDN'},
    const {'1': 'group_search_scope', '3': 9, '4': 1, '5': 5, '10': 'groupSearchScope'},
    const {'1': 'group_search_filter', '3': 10, '4': 1, '5': 9, '10': 'groupSearchFilter'},
    const {'1': 'group_member_attribute', '3': 11, '4': 1, '5': 9, '10': 'groupMemberAttribute'},
    const {'1': 'user_search_DN', '3': 12, '4': 1, '5': 9, '10': 'userSearchDN'},
    const {'1': 'user_search_scope', '3': 13, '4': 1, '5': 5, '10': 'userSearchScope'},
    const {'1': 'user_search_filter', '3': 14, '4': 1, '5': 9, '10': 'userSearchFilter'},
    const {'1': 'user_login_attribute', '3': 15, '4': 1, '5': 9, '10': 'userLoginAttribute'},
    const {'1': 'user_email_attribute', '3': 16, '4': 1, '5': 9, '10': 'userEmailAttribute'},
    const {'1': 'user_first_name_attribute', '3': 17, '4': 1, '5': 9, '10': 'userFirstNameAttribute'},
    const {'1': 'user_last_name_attribute', '3': 18, '4': 1, '5': 9, '10': 'userLastNameAttribute'},
  ],
};

const ConfigurationRequest$json = const {
  '1': 'ConfigurationRequest',
  '2': const [
    const {'1': 'configuration', '3': 1, '4': 1, '5': 11, '6': '.auge.protobuf.Configuration', '10': 'configuration'},
    const {'1': 'authenticated_user_id', '3': 2, '4': 1, '5': 9, '10': 'authenticatedUserId'},
    const {'1': 'authenticated_organization_id', '3': 3, '4': 1, '5': 9, '10': 'authenticatedOrganizationId'},
  ],
};

const ConfigurationGetRequest$json = const {
  '1': 'ConfigurationGetRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'organization_id', '3': 2, '4': 1, '5': 9, '10': 'organizationId'},
  ],
};

