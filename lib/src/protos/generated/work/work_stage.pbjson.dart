///
//  Generated code. Do not modify.
//  source: work/work_stage.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const WorkStage$json = const {
  '1': 'WorkStage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'version', '3': 2, '4': 1, '5': 5, '10': 'version'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'state_index', '3': 4, '4': 1, '5': 5, '10': 'stateIndex'},
    const {'1': 'index', '3': 5, '4': 1, '5': 5, '10': 'index'},
  ],
};

const WorkStageRequest$json = const {
  '1': 'WorkStageRequest',
  '2': const [
    const {'1': 'work_stage', '3': 1, '4': 1, '5': 11, '6': '.auge.protobuf.WorkStage', '10': 'workStage'},
    const {'1': 'work_id', '3': 2, '4': 1, '5': 9, '10': 'workId'},
    const {'1': 'auth_user_id', '3': 3, '4': 1, '5': 9, '10': 'authUserId'},
    const {'1': 'auth_organization_id', '3': 4, '4': 1, '5': 9, '10': 'authOrganizationId'},
  ],
};

const WorkStageDeleteRequest$json = const {
  '1': 'WorkStageDeleteRequest',
  '2': const [
    const {'1': 'work_stage_id', '3': 1, '4': 1, '5': 9, '10': 'workStageId'},
    const {'1': 'work_stage_version', '3': 2, '4': 1, '5': 5, '10': 'workStageVersion'},
    const {'1': 'auth_user_id', '3': 3, '4': 1, '5': 9, '10': 'authUserId'},
    const {'1': 'auth_organization_id', '3': 4, '4': 1, '5': 9, '10': 'authOrganizationId'},
  ],
};

const WorkStagesResponse$json = const {
  '1': 'WorkStagesResponse',
  '2': const [
    const {'1': 'work_stages', '3': 1, '4': 3, '5': 11, '6': '.auge.protobuf.WorkStage', '10': 'workStages'},
  ],
};

const WorkStageGetRequest$json = const {
  '1': 'WorkStageGetRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'work_id', '3': 2, '4': 1, '5': 9, '10': 'workId'},
  ],
};

