///
//  Generated code. Do not modify.
//  source: general/group.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const Group$json = const {
  '1': 'Group',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'version', '3': 2, '4': 1, '5': 5, '10': 'version'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'inactive', '3': 4, '4': 1, '5': 8, '10': 'inactive'},
    const {'1': 'group_type_index', '3': 5, '4': 1, '5': 5, '10': 'groupTypeIndex'},
    const {'1': 'organization', '3': 6, '4': 1, '5': 11, '6': '.auge.protobuf.Organization', '10': 'organization'},
    const {'1': 'super_group', '3': 7, '4': 1, '5': 11, '6': '.auge.protobuf.Group', '10': 'superGroup'},
    const {'1': 'leader', '3': 8, '4': 1, '5': 11, '6': '.auge.protobuf.User', '10': 'leader'},
    const {'1': 'members', '3': 9, '4': 3, '5': 11, '6': '.auge.protobuf.User', '10': 'members'},
  ],
};

const GroupRequest$json = const {
  '1': 'GroupRequest',
  '2': const [
    const {'1': 'group', '3': 1, '4': 1, '5': 11, '6': '.auge.protobuf.Group', '10': 'group'},
    const {'1': 'auth_user_id', '3': 2, '4': 1, '5': 9, '10': 'authUserId'},
    const {'1': 'auth_organization_id', '3': 3, '4': 1, '5': 9, '10': 'authOrganizationId'},
  ],
};

const GroupDeleteRequest$json = const {
  '1': 'GroupDeleteRequest',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'group_version', '3': 2, '4': 1, '5': 5, '10': 'groupVersion'},
    const {'1': 'auth_user_id', '3': 3, '4': 1, '5': 9, '10': 'authUserId'},
    const {'1': 'auth_organization_id', '3': 4, '4': 1, '5': 9, '10': 'authOrganizationId'},
  ],
};

const GroupGetRequest$json = const {
  '1': 'GroupGetRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'organization_id', '3': 2, '4': 1, '5': 9, '10': 'organizationId'},
    const {'1': 'aligned_to_recursive', '3': 3, '4': 1, '5': 5, '10': 'alignedToRecursive'},
  ],
};

const GroupTypeGetRequest$json = const {
  '1': 'GroupTypeGetRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

const GroupsResponse$json = const {
  '1': 'GroupsResponse',
  '2': const [
    const {'1': 'groups', '3': 1, '4': 3, '5': 11, '6': '.auge.protobuf.Group', '10': 'groups'},
  ],
};

