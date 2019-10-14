///
//  Generated code. Do not modify.
//  source: general/user_access.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const UserAccess$json = const {
  '1': 'UserAccess',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'version', '3': 2, '4': 1, '5': 5, '10': 'version'},
    const {'1': 'user', '3': 3, '4': 1, '5': 11, '6': '.auge.protobuf.User', '10': 'user'},
    const {'1': 'organization', '3': 4, '4': 1, '5': 11, '6': '.auge.protobuf.Organization', '10': 'organization'},
    const {'1': 'access_role', '3': 5, '4': 1, '5': 5, '10': 'accessRole'},
  ],
};

const UserAccessRequest$json = const {
  '1': 'UserAccessRequest',
  '2': const [
    const {'1': 'user_access', '3': 1, '4': 1, '5': 11, '6': '.auge.protobuf.UserAccess', '10': 'userAccess'},
    const {'1': 'auth_user_id', '3': 2, '4': 1, '5': 9, '10': 'authUserId'},
    const {'1': 'auth_organization_id', '3': 3, '4': 1, '5': 9, '10': 'authOrganizationId'},
    const {'1': 'with_user_profile', '3': 4, '4': 1, '5': 8, '10': 'withUserProfile'},
  ],
};

const UserAccessDeleteRequest$json = const {
  '1': 'UserAccessDeleteRequest',
  '2': const [
    const {'1': 'user_access_id', '3': 1, '4': 1, '5': 9, '10': 'userAccessId'},
    const {'1': 'user_access_version', '3': 2, '4': 1, '5': 5, '10': 'userAccessVersion'},
    const {'1': 'auth_user_id', '3': 3, '4': 1, '5': 9, '10': 'authUserId'},
    const {'1': 'auth_organization_id', '3': 4, '4': 1, '5': 9, '10': 'authOrganizationId'},
  ],
};

const UserAccessGetRequest$json = const {
  '1': 'UserAccessGetRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'organization_id', '3': 3, '4': 1, '5': 9, '10': 'organizationId'},
    const {'1': 'identification', '3': 4, '4': 1, '5': 9, '10': 'identification'},
    const {'1': 'password', '3': 5, '4': 1, '5': 9, '10': 'password'},
    const {'1': 'with_user_profile', '3': 6, '4': 1, '5': 8, '10': 'withUserProfile'},
  ],
};

const UserAccessesResponse$json = const {
  '1': 'UserAccessesResponse',
  '2': const [
    const {'1': 'user_accesses', '3': 1, '4': 3, '5': 11, '6': '.auge.protobuf.UserAccess', '10': 'userAccesses'},
  ],
};

