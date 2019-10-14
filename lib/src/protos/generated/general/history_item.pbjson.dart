///
//  Generated code. Do not modify.
//  source: general/history_item.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const HistoryItem$json = const {
  '1': 'HistoryItem',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'object_class_name', '3': 2, '4': 1, '5': 9, '10': 'objectClassName'},
    const {'1': 'object_id', '3': 3, '4': 1, '5': 9, '10': 'objectId'},
    const {'1': 'object_version', '3': 4, '4': 1, '5': 5, '10': 'objectVersion'},
    const {'1': 'system_module_index', '3': 5, '4': 1, '5': 5, '10': 'systemModuleIndex'},
    const {'1': 'system_function_index', '3': 6, '4': 1, '5': 5, '10': 'systemFunctionIndex'},
    const {'1': 'date_time', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'dateTime'},
    const {'1': 'user', '3': 8, '4': 1, '5': 11, '6': '.auge.protobuf.User', '10': 'user'},
    const {'1': 'organization', '3': 9, '4': 1, '5': 11, '6': '.auge.protobuf.Organization', '10': 'organization'},
    const {'1': 'description', '3': 10, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'changed_values_json', '3': 11, '4': 1, '5': 9, '10': 'changedValuesJson'},
  ],
};

const HistoryItemGetRequest$json = const {
  '1': 'HistoryItemGetRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'organization_id', '3': 2, '4': 1, '5': 9, '10': 'organizationId'},
    const {'1': 'system_module_index', '3': 3, '4': 1, '5': 5, '10': 'systemModuleIndex'},
  ],
};

const HistoryResponse$json = const {
  '1': 'HistoryResponse',
  '2': const [
    const {'1': 'history', '3': 1, '4': 3, '5': 11, '6': '.auge.protobuf.HistoryItem', '10': 'history'},
  ],
};

