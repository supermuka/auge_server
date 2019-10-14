///
//  Generated code. Do not modify.
//  source: general/user.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const User$json = const {
  '1': 'User',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'version', '3': 2, '4': 1, '5': 5, '10': 'version'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'inactive', '3': 4, '4': 1, '5': 8, '10': 'inactive'},
    const {'1': 'managed_by_organization', '3': 5, '4': 1, '5': 11, '6': '.auge.protobuf.Organization', '10': 'managedByOrganization'},
    const {'1': 'user_profile', '3': 6, '4': 1, '5': 11, '6': '.auge.protobuf.UserProfile', '10': 'userProfile'},
  ],
};

const UserRequest$json = const {
  '1': 'UserRequest',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.auge.protobuf.User', '10': 'user'},
    const {'1': 'auth_user_id', '3': 2, '4': 1, '5': 9, '10': 'authUserId'},
    const {'1': 'auth_organization_id', '3': 3, '4': 1, '5': 9, '10': 'authOrganizationId'},
  ],
};

const UserDeleteRequest$json = const {
  '1': 'UserDeleteRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'user_version', '3': 2, '4': 1, '5': 5, '10': 'userVersion'},
    const {'1': 'auth_user_id', '3': 3, '4': 1, '5': 9, '10': 'authUserId'},
    const {'1': 'auth_organization_id', '3': 4, '4': 1, '5': 9, '10': 'authOrganizationId'},
  ],
};

const UserProfile$json = const {
  '1': 'UserProfile',
  '2': const [
    const {'1': 'e_mail', '3': 1, '4': 1, '5': 9, '10': 'eMail'},
    const {'1': 'image', '3': 2, '4': 1, '5': 9, '10': 'image'},
    const {'1': 'idiom_locale', '3': 3, '4': 1, '5': 9, '10': 'idiomLocale'},
  ],
};

const UserGetRequest$json = const {
  '1': 'UserGetRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'managed_by_organization_id', '3': 2, '4': 1, '5': 9, '10': 'managedByOrganizationId'},
    const {'1': 'managed_by_organization_id_or_accessed_by_organization_id', '3': 3, '4': 1, '5': 9, '10': 'managedByOrganizationIdOrAccessedByOrganizationId'},
    const {'1': 'accessedByOrganizationId', '3': 4, '4': 1, '5': 9, '10': 'accessedByOrganizationId'},
    const {'1': 'with_user_profile', '3': 5, '4': 1, '5': 8, '10': 'withUserProfile'},
  ],
};

const UsersResponse$json = const {
  '1': 'UsersResponse',
  '2': const [
    const {'1': 'users', '3': 1, '4': 3, '5': 11, '6': '.auge.protobuf.User', '10': 'users'},
  ],
};

