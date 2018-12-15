// This is a generated file (see the discoveryapis_generator project).

// ignore_for_file: unnecessary_cast

library auge_server.objectiveAugeApi.client;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;
import 'package:auge_server/model/group.dart';
import 'package:auge_server/model/history_item.dart';
import 'package:auge_server/message/created_message.dart';
import 'package:auge_server/model/objective/measure.dart';
import 'package:auge_server/model/objective/objective.dart';
import 'package:auge_server/model/organization.dart';
import 'package:auge_server/model/user.dart';
export 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client objectiveAugeApi/v1';

class ObjectiveAugeApi {
  final commons.ApiRequester _requester;

  ObjectiveAugeApi(http.Client client,
      {core.String rootUrl: "http://localhost:8091/",
      core.String servicePath: "objectiveAugeApi/v1/"})
      : _requester =
            new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);

  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [objectiveId] - Path parameter: 'objectiveId'.
  ///
  /// Completes with a [IdMessage].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<IdMessage> createMeasure(
      Measure request, core.String objectiveId) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode(MeasureFactory.toJson(request));
    }
    if (objectiveId == null) {
      throw new core.ArgumentError("Parameter objectiveId is required.");
    }

    _url = 'objetives/' +
        commons.Escaper.ecapeVariable('$objectiveId') +
        '/measures';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => IdMessageFactory.fromJson(data));
  }

  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [measureId] - Path parameter: 'measureId'.
  ///
  /// Completes with a [IdMessage].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<IdMessage> createMeasureProgress(
      MeasureProgress request, core.String measureId) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode(MeasureProgressFactory.toJson(request));
    }
    if (measureId == null) {
      throw new core.ArgumentError("Parameter measureId is required.");
    }

    _url =
        'measures/' + commons.Escaper.ecapeVariable('$measureId') + '/progress';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => IdMessageFactory.fromJson(data));
  }

  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// Completes with a [IdMessage].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<IdMessage> createObjective(Objective request) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode(ObjectiveFactory.toJson(request));
    }

    _url = 'objectives';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => IdMessageFactory.fromJson(data));
  }

  /// Request parameters:
  ///
  /// [id] - Path parameter: 'id'.
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future deleteMeasure(core.String id) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _downloadOptions = null;

    _url = 'measures/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /// Request parameters:
  ///
  /// [id] - Path parameter: 'id'.
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future deleteObjective(core.String id) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _downloadOptions = null;

    _url = 'objectives/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /// Request parameters:
  ///
  /// [objectiveId] - Path parameter: 'objectiveId'.
  ///
  /// Completes with a [core.List<HistoryItem>].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<core.List<HistoryItem>> getHistory(core.String objectiveId) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (objectiveId == null) {
      throw new core.ArgumentError("Parameter objectiveId is required.");
    }

    _url = 'objective/' +
        commons.Escaper.ecapeVariable('$objectiveId') +
        '/history';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => (data as core.List)
        .map<HistoryItem>((value) => HistoryItemFactory.fromJson(value))
        .toList());
  }

  /// Request parameters:
  ///
  /// [id] - Path parameter: 'id'.
  ///
  /// Completes with a [Measure].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Measure> getMeasureById(core.String id) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'measures/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => MeasureFactory.fromJson(data));
  }

  /// Request parameters:
  ///
  /// [measureId] - Path parameter: 'measureId'.
  ///
  /// Completes with a [core.List<MeasureProgress>].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<core.List<MeasureProgress>> getMeasureProgress(
      core.String measureId) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (measureId == null) {
      throw new core.ArgumentError("Parameter measureId is required.");
    }

    _url =
        'measures/' + commons.Escaper.ecapeVariable('$measureId') + '/progress';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => (data as core.List)
        .map<MeasureProgress>((value) => MeasureProgressFactory.fromJson(value))
        .toList());
  }

  /// Request parameters:
  ///
  /// [measureProgressId] - Path parameter: 'measureProgressId'.
  ///
  /// Completes with a [MeasureProgress].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<MeasureProgress> getMeasureProgressById(
      core.String measureProgressId) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (measureProgressId == null) {
      throw new core.ArgumentError("Parameter measureProgressId is required.");
    }

    _url = 'progress/' + commons.Escaper.ecapeVariable('$measureProgressId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => MeasureProgressFactory.fromJson(data));
  }

  /// Request parameters:
  ///
  /// Completes with a [core.List<MeasureUnit>].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<core.List<MeasureUnit>> getMeasureUnits() {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    _url = 'measure_units';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => (data as core.List)
        .map<MeasureUnit>((value) => MeasureUnitFactory.fromJson(value))
        .toList());
  }

  /// Request parameters:
  ///
  /// [objectiveId] - Path parameter: 'objectiveId'.
  ///
  /// [isDeleted] - Query parameter: 'isDeleted'.
  ///
  /// Completes with a [core.List<Measure>].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<core.List<Measure>> getMeasures(core.String objectiveId,
      {core.bool isDeleted}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (objectiveId == null) {
      throw new core.ArgumentError("Parameter objectiveId is required.");
    }
    if (isDeleted != null) {
      _queryParams["isDeleted"] = ["${isDeleted}"];
    }

    _url = 'objetives/' +
        commons.Escaper.ecapeVariable('$objectiveId') +
        '/measures';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => (data as core.List)
        .map<Measure>((value) => MeasureFactory.fromJson(value))
        .toList());
  }

  /// Request parameters:
  ///
  /// [id] - Path parameter: 'id'.
  ///
  /// [withMeasures] - Query parameter: 'withMeasures'.
  ///
  /// [withProfile] - Query parameter: 'withProfile'.
  ///
  /// [withHistory] - Query parameter: 'withHistory'.
  ///
  /// [withArchived] - Query parameter: 'withArchived'.
  ///
  /// Completes with a [Objective].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Objective> getObjectiveById(core.String id,
      {core.bool withMeasures,
      core.bool withProfile,
      core.bool withHistory,
      core.bool withArchived}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    if (withMeasures != null) {
      _queryParams["withMeasures"] = ["${withMeasures}"];
    }
    if (withProfile != null) {
      _queryParams["withProfile"] = ["${withProfile}"];
    }
    if (withHistory != null) {
      _queryParams["withHistory"] = ["${withHistory}"];
    }
    if (withArchived != null) {
      _queryParams["withArchived"] = ["${withArchived}"];
    }

    _url = 'objectives/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => ObjectiveFactory.fromJson(data));
  }

  /// Request parameters:
  ///
  /// [organizationId] - Path parameter: 'organizationId'.
  ///
  /// [withMeasures] - Query parameter: 'withMeasures'.
  ///
  /// [treeAlignedWithChildren] - Query parameter: 'treeAlignedWithChildren'.
  ///
  /// [withProfile] - Query parameter: 'withProfile'.
  ///
  /// [withHistory] - Query parameter: 'withHistory'.
  ///
  /// [withArchived] - Query parameter: 'withArchived'.
  ///
  /// Completes with a [core.List<Objective>].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<core.List<Objective>> getObjectives(core.String organizationId,
      {core.bool withMeasures,
      core.bool treeAlignedWithChildren,
      core.bool withProfile,
      core.bool withHistory,
      core.bool withArchived}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (organizationId == null) {
      throw new core.ArgumentError("Parameter organizationId is required.");
    }
    if (withMeasures != null) {
      _queryParams["withMeasures"] = ["${withMeasures}"];
    }
    if (treeAlignedWithChildren != null) {
      _queryParams["treeAlignedWithChildren"] = ["${treeAlignedWithChildren}"];
    }
    if (withProfile != null) {
      _queryParams["withProfile"] = ["${withProfile}"];
    }
    if (withHistory != null) {
      _queryParams["withHistory"] = ["${withHistory}"];
    }
    if (withArchived != null) {
      _queryParams["withArchived"] = ["${withArchived}"];
    }

    _url = 'organization/' +
        commons.Escaper.ecapeVariable('$organizationId') +
        '/objetives';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => (data as core.List)
        .map<Objective>((value) => ObjectiveFactory.fromJson(value))
        .toList());
  }

  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [objectiveId] - Path parameter: 'objectiveId'.
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future updateMeasure(Measure request, core.String objectiveId) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode(MeasureFactory.toJson(request));
    }
    if (objectiveId == null) {
      throw new core.ArgumentError("Parameter objectiveId is required.");
    }

    _downloadOptions = null;

    _url = 'objetives/' +
        commons.Escaper.ecapeVariable('$objectiveId') +
        '/measures';

    var _response = _requester.request(_url, "PUT",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// [measureId] - Path parameter: 'measureId'.
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future updateMeasureProgress(
      MeasureProgress request, core.String measureId) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode(MeasureProgressFactory.toJson(request));
    }
    if (measureId == null) {
      throw new core.ArgumentError("Parameter measureId is required.");
    }

    _downloadOptions = null;

    _url =
        'measures/' + commons.Escaper.ecapeVariable('$measureId') + '/progress';

    var _response = _requester.request(_url, "PUT",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// Completes with a [IdMessage].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<IdMessage> updateObjective(Objective request) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode(ObjectiveFactory.toJson(request));
    }

    _url = 'objectives';

    var _response = _requester.request(_url, "PUT",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => IdMessageFactory.fromJson(data));
  }
}

class GroupFactory {
  static Group fromJson(core.Map _json) {
    var message = new Group();
    if (_json.containsKey("active")) {
      message.active = _json["active"];
    }
    if (_json.containsKey("groupType")) {
      message.groupType = GroupTypeFactory.fromJson(_json["groupType"]);
    }
    if (_json.containsKey("id")) {
      message.id = _json["id"];
    }
    if (_json.containsKey("isDeleted")) {
      message.isDeleted = _json["isDeleted"];
    }
    if (_json.containsKey("lastHistoryItem")) {
      message.lastHistoryItem =
          HistoryItemFactory.fromJson(_json["lastHistoryItem"]);
    }
    if (_json.containsKey("leader")) {
      message.leader = UserFactory.fromJson(_json["leader"]);
    }
    if (_json.containsKey("members")) {
      message.members = (_json["members"] as core.List)
          .map<User>((value) => UserFactory.fromJson(value))
          .toList();
    }
    if (_json.containsKey("name")) {
      message.name = _json["name"];
    }
    if (_json.containsKey("organization")) {
      message.organization =
          OrganizationFactory.fromJson(_json["organization"]);
    }
    if (_json.containsKey("superGroup")) {
      message.superGroup = GroupFactory.fromJson(_json["superGroup"]);
    }
    if (_json.containsKey("version")) {
      message.version = _json["version"];
    }
    return message;
  }

  static core.Map toJson(Group message) {
    var _json = new core.Map();
    if (message.active != null) {
      _json["active"] = message.active;
    }
    if (message.groupType != null) {
      _json["groupType"] = GroupTypeFactory.toJson(message.groupType);
    }
    if (message.id != null) {
      _json["id"] = message.id;
    }
    if (message.isDeleted != null) {
      _json["isDeleted"] = message.isDeleted;
    }
    if (message.lastHistoryItem != null) {
      _json["lastHistoryItem"] =
          HistoryItemFactory.toJson(message.lastHistoryItem);
    }
    if (message.leader != null) {
      _json["leader"] = UserFactory.toJson(message.leader);
    }
    if (message.members != null) {
      _json["members"] =
          message.members.map((value) => UserFactory.toJson(value)).toList();
    }
    if (message.name != null) {
      _json["name"] = message.name;
    }
    if (message.organization != null) {
      _json["organization"] = OrganizationFactory.toJson(message.organization);
    }
    if (message.superGroup != null) {
      _json["superGroup"] = GroupFactory.toJson(message.superGroup);
    }
    if (message.version != null) {
      _json["version"] = message.version;
    }
    return _json;
  }
}

class GroupTypeFactory {
  static GroupType fromJson(core.Map _json) {
    var message = new GroupType();
    if (_json.containsKey("id")) {
      message.id = _json["id"];
    }
    if (_json.containsKey("name")) {
      message.name = _json["name"];
    }
    return message;
  }

  static core.Map toJson(GroupType message) {
    var _json = new core.Map();
    if (message.id != null) {
      _json["id"] = message.id;
    }
    if (message.name != null) {
      _json["name"] = message.name;
    }
    return _json;
  }
}

class HistoryItemFactory {
  static HistoryItem fromJson(core.Map _json) {
    var message = new HistoryItem();
    if (_json.containsKey("changedValues")) {
      message.changedValues = _json["changedValues"];
    }
    if (_json.containsKey("dateTime")) {
      message.dateTime = core.DateTime.parse(_json["dateTime"]);
    }
    if (_json.containsKey("description")) {
      message.description = _json["description"];
    }
    if (_json.containsKey("id")) {
      message.id = _json["id"];
    }
    if (_json.containsKey("objectClassName")) {
      message.objectClassName = _json["objectClassName"];
    }
    if (_json.containsKey("objectId")) {
      message.objectId = _json["objectId"];
    }
    if (_json.containsKey("objectVersion")) {
      message.objectVersion = _json["objectVersion"];
    }
    if (_json.containsKey("systemFunctionIndex")) {
      message.systemFunctionIndex = _json["systemFunctionIndex"];
    }
    if (_json.containsKey("user")) {
      message.user = UserFactory.fromJson(_json["user"]);
    }
    return message;
  }

  static core.Map toJson(HistoryItem message) {
    var _json = new core.Map();
    if (message.changedValues != null) {
      _json["changedValues"] = message.changedValues;
    }
    if (message.dateTime != null) {
      _json["dateTime"] = (message.dateTime).toIso8601String();
    }
    if (message.description != null) {
      _json["description"] = message.description;
    }
    if (message.id != null) {
      _json["id"] = message.id;
    }
    if (message.objectClassName != null) {
      _json["objectClassName"] = message.objectClassName;
    }
    if (message.objectId != null) {
      _json["objectId"] = message.objectId;
    }
    if (message.objectVersion != null) {
      _json["objectVersion"] = message.objectVersion;
    }
    if (message.systemFunctionIndex != null) {
      _json["systemFunctionIndex"] = message.systemFunctionIndex;
    }
    if (message.user != null) {
      _json["user"] = UserFactory.toJson(message.user);
    }
    return _json;
  }
}

class IdMessageFactory {
  static IdMessage fromJson(core.Map _json) {
    var message = new IdMessage();
    if (_json.containsKey("id")) {
      message.id = _json["id"];
    }
    return message;
  }

  static core.Map toJson(IdMessage message) {
    var _json = new core.Map();
    if (message.id != null) {
      _json["id"] = message.id;
    }
    return _json;
  }
}

class MeasureFactory {
  static Measure fromJson(core.Map _json) {
    var message = new Measure();
    if (_json.containsKey("currentValue")) {
      message.currentValue = _json["currentValue"].toDouble();
    }
    if (_json.containsKey("decimalsNumber")) {
      message.decimalsNumber = _json["decimalsNumber"];
    }
    if (_json.containsKey("description")) {
      message.description = _json["description"];
    }
    if (_json.containsKey("endValue")) {
      message.endValue = _json["endValue"].toDouble();
    }
    if (_json.containsKey("id")) {
      message.id = _json["id"];
    }
    if (_json.containsKey("isDeleted")) {
      message.isDeleted = _json["isDeleted"];
    }
    if (_json.containsKey("lastHistoryItem")) {
      message.lastHistoryItem =
          HistoryItemFactory.fromJson(_json["lastHistoryItem"]);
    }
    if (_json.containsKey("measureProgress")) {
      message.measureProgress = (_json["measureProgress"] as core.List)
          .map<MeasureProgress>(
              (value) => MeasureProgressFactory.fromJson(value))
          .toList();
    }
    if (_json.containsKey("measureUnit")) {
      message.measureUnit = MeasureUnitFactory.fromJson(_json["measureUnit"]);
    }
    if (_json.containsKey("metric")) {
      message.metric = _json["metric"];
    }
    if (_json.containsKey("name")) {
      message.name = _json["name"];
    }
    if (_json.containsKey("startValue")) {
      message.startValue = _json["startValue"].toDouble();
    }
    if (_json.containsKey("version")) {
      message.version = _json["version"];
    }
    return message;
  }

  static core.Map toJson(Measure message) {
    var _json = new core.Map();
    if (message.currentValue != null) {
      _json["currentValue"] = message.currentValue;
    }
    if (message.decimalsNumber != null) {
      _json["decimalsNumber"] = message.decimalsNumber;
    }
    if (message.description != null) {
      _json["description"] = message.description;
    }
    if (message.endValue != null) {
      _json["endValue"] = message.endValue;
    }
    if (message.id != null) {
      _json["id"] = message.id;
    }
    if (message.isDeleted != null) {
      _json["isDeleted"] = message.isDeleted;
    }
    if (message.lastHistoryItem != null) {
      _json["lastHistoryItem"] =
          HistoryItemFactory.toJson(message.lastHistoryItem);
    }
    if (message.measureProgress != null) {
      _json["measureProgress"] = message.measureProgress
          .map((value) => MeasureProgressFactory.toJson(value))
          .toList();
    }
    if (message.measureUnit != null) {
      _json["measureUnit"] = MeasureUnitFactory.toJson(message.measureUnit);
    }
    if (message.metric != null) {
      _json["metric"] = message.metric;
    }
    if (message.name != null) {
      _json["name"] = message.name;
    }
    if (message.startValue != null) {
      _json["startValue"] = message.startValue;
    }
    if (message.version != null) {
      _json["version"] = message.version;
    }
    return _json;
  }
}

class MeasureProgressFactory {
  static MeasureProgress fromJson(core.Map _json) {
    var message = new MeasureProgress();
    if (_json.containsKey("comment")) {
      message.comment = _json["comment"];
    }
    if (_json.containsKey("currentValue")) {
      message.currentValue = _json["currentValue"].toDouble();
    }
    if (_json.containsKey("date")) {
      message.date = core.DateTime.parse(_json["date"]);
    }
    if (_json.containsKey("id")) {
      message.id = _json["id"];
    }
    if (_json.containsKey("isDeleted")) {
      message.isDeleted = _json["isDeleted"];
    }
    if (_json.containsKey("lastHistoryItem")) {
      message.lastHistoryItem =
          HistoryItemFactory.fromJson(_json["lastHistoryItem"]);
    }
    if (_json.containsKey("version")) {
      message.version = _json["version"];
    }
    return message;
  }

  static core.Map toJson(MeasureProgress message) {
    var _json = new core.Map();
    if (message.comment != null) {
      _json["comment"] = message.comment;
    }
    if (message.currentValue != null) {
      _json["currentValue"] = message.currentValue;
    }
    if (message.date != null) {
      _json["date"] = (message.date).toIso8601String();
    }
    if (message.id != null) {
      _json["id"] = message.id;
    }
    if (message.isDeleted != null) {
      _json["isDeleted"] = message.isDeleted;
    }
    if (message.lastHistoryItem != null) {
      _json["lastHistoryItem"] =
          HistoryItemFactory.toJson(message.lastHistoryItem);
    }
    if (message.version != null) {
      _json["version"] = message.version;
    }
    return _json;
  }
}

class MeasureUnitFactory {
  static MeasureUnit fromJson(core.Map _json) {
    var message = new MeasureUnit();
    if (_json.containsKey("id")) {
      message.id = _json["id"];
    }
    if (_json.containsKey("name")) {
      message.name = _json["name"];
    }
    if (_json.containsKey("symbol")) {
      message.symbol = _json["symbol"];
    }
    return message;
  }

  static core.Map toJson(MeasureUnit message) {
    var _json = new core.Map();
    if (message.id != null) {
      _json["id"] = message.id;
    }
    if (message.name != null) {
      _json["name"] = message.name;
    }
    if (message.symbol != null) {
      _json["symbol"] = message.symbol;
    }
    return _json;
  }
}

class ObjectiveFactory {
  static Objective fromJson(core.Map _json) {
    var message = new Objective();
    if (_json.containsKey("alignedTo")) {
      message.alignedTo = ObjectiveFactory.fromJson(_json["alignedTo"]);
    }
    if (_json.containsKey("alignedWithChildren")) {
      message.alignedWithChildren = (_json["alignedWithChildren"] as core.List)
          .map<Objective>((value) => ObjectiveFactory.fromJson(value))
          .toList();
    }
    if (_json.containsKey("archived")) {
      message.archived = _json["archived"];
    }
    if (_json.containsKey("description")) {
      message.description = _json["description"];
    }
    if (_json.containsKey("endDate")) {
      message.endDate = core.DateTime.parse(_json["endDate"]);
    }
    if (_json.containsKey("group")) {
      message.group = GroupFactory.fromJson(_json["group"]);
    }
    if (_json.containsKey("history")) {
      message.history = (_json["history"] as core.List)
          .map<HistoryItem>((value) => HistoryItemFactory.fromJson(value))
          .toList();
    }
    if (_json.containsKey("id")) {
      message.id = _json["id"];
    }
    if (_json.containsKey("isDeleted")) {
      message.isDeleted = _json["isDeleted"];
    }
    if (_json.containsKey("lastHistoryItem")) {
      message.lastHistoryItem =
          HistoryItemFactory.fromJson(_json["lastHistoryItem"]);
    }
    if (_json.containsKey("leader")) {
      message.leader = UserFactory.fromJson(_json["leader"]);
    }
    if (_json.containsKey("measures")) {
      message.measures = (_json["measures"] as core.List)
          .map<Measure>((value) => MeasureFactory.fromJson(value))
          .toList();
    }
    if (_json.containsKey("name")) {
      message.name = _json["name"];
    }
    if (_json.containsKey("organization")) {
      message.organization =
          OrganizationFactory.fromJson(_json["organization"]);
    }
    if (_json.containsKey("startDate")) {
      message.startDate = core.DateTime.parse(_json["startDate"]);
    }
    if (_json.containsKey("version")) {
      message.version = _json["version"];
    }
    return message;
  }

  static core.Map toJson(Objective message) {
    var _json = new core.Map();
    if (message.alignedTo != null) {
      _json["alignedTo"] = ObjectiveFactory.toJson(message.alignedTo);
    }
    if (message.alignedWithChildren != null) {
      _json["alignedWithChildren"] = message.alignedWithChildren
          .map((value) => ObjectiveFactory.toJson(value))
          .toList();
    }
    if (message.archived != null) {
      _json["archived"] = message.archived;
    }
    if (message.description != null) {
      _json["description"] = message.description;
    }
    if (message.endDate != null) {
      _json["endDate"] = (message.endDate).toIso8601String();
    }
    if (message.group != null) {
      _json["group"] = GroupFactory.toJson(message.group);
    }
    if (message.history != null) {
      _json["history"] = message.history
          .map((value) => HistoryItemFactory.toJson(value))
          .toList();
    }
    if (message.id != null) {
      _json["id"] = message.id;
    }
    if (message.isDeleted != null) {
      _json["isDeleted"] = message.isDeleted;
    }
    if (message.lastHistoryItem != null) {
      _json["lastHistoryItem"] =
          HistoryItemFactory.toJson(message.lastHistoryItem);
    }
    if (message.leader != null) {
      _json["leader"] = UserFactory.toJson(message.leader);
    }
    if (message.measures != null) {
      _json["measures"] = message.measures
          .map((value) => MeasureFactory.toJson(value))
          .toList();
    }
    if (message.name != null) {
      _json["name"] = message.name;
    }
    if (message.organization != null) {
      _json["organization"] = OrganizationFactory.toJson(message.organization);
    }
    if (message.startDate != null) {
      _json["startDate"] = (message.startDate).toIso8601String();
    }
    if (message.version != null) {
      _json["version"] = message.version;
    }
    return _json;
  }
}

class OrganizationFactory {
  static Organization fromJson(core.Map _json) {
    var message = new Organization();
    if (_json.containsKey("code")) {
      message.code = _json["code"];
    }
    if (_json.containsKey("id")) {
      message.id = _json["id"];
    }
    if (_json.containsKey("name")) {
      message.name = _json["name"];
    }
    return message;
  }

  static core.Map toJson(Organization message) {
    var _json = new core.Map();
    if (message.code != null) {
      _json["code"] = message.code;
    }
    if (message.id != null) {
      _json["id"] = message.id;
    }
    if (message.name != null) {
      _json["name"] = message.name;
    }
    return _json;
  }
}

class UserFactory {
  static User fromJson(core.Map _json) {
    var message = new User();
    if (_json.containsKey("eMail")) {
      message.eMail = _json["eMail"];
    }
    if (_json.containsKey("id")) {
      message.id = _json["id"];
    }
    if (_json.containsKey("name")) {
      message.name = _json["name"];
    }
    if (_json.containsKey("password")) {
      message.password = _json["password"];
    }
    if (_json.containsKey("userProfile")) {
      message.userProfile = UserProfileFactory.fromJson(_json["userProfile"]);
    }
    return message;
  }

  static core.Map toJson(User message) {
    var _json = new core.Map();
    if (message.eMail != null) {
      _json["eMail"] = message.eMail;
    }
    if (message.id != null) {
      _json["id"] = message.id;
    }
    if (message.name != null) {
      _json["name"] = message.name;
    }
    if (message.password != null) {
      _json["password"] = message.password;
    }
    if (message.userProfile != null) {
      _json["userProfile"] = UserProfileFactory.toJson(message.userProfile);
    }
    return _json;
  }
}

class UserProfileFactory {
  static UserProfile fromJson(core.Map _json) {
    var message = new UserProfile();
    if (_json.containsKey("idiomLocale")) {
      message.idiomLocale = _json["idiomLocale"];
    }
    if (_json.containsKey("image")) {
      message.image = _json["image"];
    }
    if (_json.containsKey("isSuperAdmin")) {
      message.isSuperAdmin = _json["isSuperAdmin"];
    }
    return message;
  }

  static core.Map toJson(UserProfile message) {
    var _json = new core.Map();
    if (message.idiomLocale != null) {
      _json["idiomLocale"] = message.idiomLocale;
    }
    if (message.image != null) {
      _json["image"] = message.image;
    }
    if (message.isSuperAdmin != null) {
      _json["isSuperAdmin"] = message.isSuperAdmin;
    }
    return _json;
  }
}
