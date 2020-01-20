///
//  Generated code. Do not modify.
//  source: general/user_identity.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const UserIdentity$json = const {
  '1': 'UserIdentity',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'version', '3': 2, '4': 1, '5': 5, '10': 'version'},
    const {'1': 'identification', '3': 4, '4': 1, '5': 9, '10': 'identification'},
    const {'1': 'password', '3': 5, '4': 1, '5': 9, '10': 'password'},
    const {'1': 'password_salt', '3': 6, '4': 1, '5': 9, '10': 'passwordSalt'},
    const {'1': 'password_hash', '3': 7, '4': 1, '5': 9, '10': 'passwordHash'},
    const {'1': 'provider', '3': 8, '4': 1, '5': 5, '10': 'provider'},
    const {'1': 'provider_object_id', '3': 9, '4': 1, '5': 9, '10': 'providerObjectId'},
    const {'1': 'provider_dn', '3': 10, '4': 1, '5': 9, '10': 'providerDn'},
    const {'1': 'user', '3': 11, '4': 1, '5': 11, '6': '.auge.protobuf.User', '10': 'user'},
  ],
};

const UserIdentityRequest$json = const {
  '1': 'UserIdentityRequest',
  '2': const [
    const {'1': 'user_identity', '3': 1, '4': 1, '5': 11, '6': '.auge.protobuf.UserIdentity', '10': 'userIdentity'},
    const {'1': 'auth_user_id', '3': 2, '4': 1, '5': 9, '10': 'authUserId'},
    const {'1': 'auth_organization_id', '3': 3, '4': 1, '5': 9, '10': 'authOrganizationId'},
  ],
};

const UserIdentityDeleteRequest$json = const {
  '1': 'UserIdentityDeleteRequest',
  '2': const [
    const {'1': 'user_identity_id', '3': 1, '4': 1, '5': 9, '10': 'userIdentityId'},
    const {'1': 'user_identity_version', '3': 2, '4': 1, '5': 5, '10': 'userIdentityVersion'},
    const {'1': 'auth_user_id', '3': 3, '4': 1, '5': 9, '10': 'authUserId'},
    const {'1': 'auth_organization_id', '3': 4, '4': 1, '5': 9, '10': 'authOrganizationId'},
  ],
};

const UserIdentityGetRequest$json = const {
  '1': 'UserIdentityGetRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'identification', '3': 2, '4': 1, '5': 9, '10': 'identification'},
    const {'1': 'password', '3': 3, '4': 1, '5': 9, '10': 'password'},
    const {'1': 'user_id', '3': 4, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'managed_by_organization_id', '3': 5, '4': 1, '5': 9, '10': 'managedByOrganizationId'},
    const {'1': 'with_user_profile', '3': 6, '4': 1, '5': 8, '10': 'withUserProfile'},
  ],
};

const NewPasswordCodeRequest$json = const {
  '1': 'NewPasswordCodeRequest',
  '2': const [
    const {'1': 'identification', '3': 1, '4': 1, '5': 9, '10': 'identification'},
  ],
};

const UserIdentityPasswordRequest$json = const {
  '1': 'UserIdentityPasswordRequest',
  '2': const [
    const {'1': 'identification', '3': 1, '4': 1, '5': 9, '10': 'identification'},
    const {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

const UserIdentitiesResponse$json = const {
  '1': 'UserIdentitiesResponse',
  '2': const [
    const {'1': 'userIdentities', '3': 1, '4': 3, '5': 11, '6': '.auge.protobuf.UserIdentity', '10': 'userIdentities'},
  ],
};

const NewPasswordCodeResponse$json = const {
  '1': 'NewPasswordCodeResponse',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    const {'1': 'e_mail', '3': 2, '4': 1, '5': 9, '10': 'eMail'},
  ],
};

