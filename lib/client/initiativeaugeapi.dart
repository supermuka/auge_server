// This is a generated file (see the discoveryapis_generator project).

// ignore_for_file: unnecessary_cast

library auge_server.initiativeAugeApi.client;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;
import 'package:auge_server/model/group.dart';
import 'package:auge_server/message_type/id_message.dart';
import 'package:auge_server/model/initiative/initiative.dart';
import 'package:auge_server/model/objective/measure.dart';
import 'package:auge_server/model/objective/objective.dart';
import 'package:auge_server/model/organization.dart';
import 'package:auge_server/model/initiative/stage.dart';
import 'package:auge_server/model/initiative/state.dart';
import 'package:auge_server/model/user.dart';
import 'package:auge_server/model/initiative/work_item.dart';
import 'package:auge_server/model/initiative/work_item_check_item.dart';
export 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client initiativeAugeApi/v1';

class InitiativeAugeApi {
  final commons.ApiRequester _requester;

  InitiativeAugeApi(http.Client client,
      {core.String rootUrl: "http://localhost:8091/",
      core.String servicePath: "initiativeAugeApi/v1/"})
      : _requester =
            new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);

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
  async.Future<IdMessage> createInitiative(Initiative request) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode(InitiativeFactory.toJson(request));
    }

    _url = 'initiatives';

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
  /// [initiativeId] - Path parameter: 'initiativeId'.
  ///
  /// Completes with a [IdMessage].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<IdMessage> createWorkItem(
      WorkItem request, core.String initiativeId) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode(WorkItemFactory.toJson(request));
    }
    if (initiativeId == null) {
      throw new core.ArgumentError("Parameter initiativeId is required.");
    }

    _url = 'initiatives/' +
        commons.Escaper.ecapeVariable('$initiativeId') +
        '/workitems';

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
  async.Future deleteInitiative(core.String id) {
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

    _url = 'initiatives/' + commons.Escaper.ecapeVariable('$id');

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
  async.Future deleteWorkItem(core.String id) {
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

    _url = 'workitems/' + commons.Escaper.ecapeVariable('$id');

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
  /// [organizationId] - Path parameter: 'organizationId'.
  ///
  /// [objectiveId] - Query parameter: 'objectiveId'.
  ///
  /// [withWorkItems] - Query parameter: 'withWorkItems'.
  ///
  /// Completes with a [core.List<Initiative>].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<core.List<Initiative>> getInitiatives(core.String organizationId,
      {core.String objectiveId, core.bool withWorkItems}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (organizationId == null) {
      throw new core.ArgumentError("Parameter organizationId is required.");
    }
    if (objectiveId != null) {
      _queryParams["objectiveId"] = [objectiveId];
    }
    if (withWorkItems != null) {
      _queryParams["withWorkItems"] = ["${withWorkItems}"];
    }

    _url = 'organizations/' +
        commons.Escaper.ecapeVariable('$organizationId') +
        '/initiatives';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => (data as core.List)
        .map<Initiative>((value) => InitiativeFactory.fromJson(value))
        .toList());
  }

  /// Request parameters:
  ///
  /// [initiativeid] - Path parameter: 'initiativeid'.
  ///
  /// Completes with a [core.List<Stage>].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<core.List<Stage>> getStages(core.String initiativeid) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (initiativeid == null) {
      throw new core.ArgumentError("Parameter initiativeid is required.");
    }

    _url = 'initiatives/' +
        commons.Escaper.ecapeVariable('$initiativeid') +
        '/stages';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => (data as core.List)
        .map<Stage>((value) => StageFactory.fromJson(value))
        .toList());
  }

  /// Request parameters:
  ///
  /// Completes with a [core.List<State>].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<core.List<State>> getStates() {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    _url = 'states';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => (data as core.List)
        .map<State>((value) => StateFactory.fromJson(value))
        .toList());
  }

  /// [request] - The metadata request object.
  ///
  /// Request parameters:
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future updateInitiative(Initiative request) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode(InitiativeFactory.toJson(request));
    }

    _downloadOptions = null;

    _url = 'initiatives';

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
  /// [initiativeId] - Path parameter: 'initiativeId'.
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future updateWorkItem(WorkItem request, core.String initiativeId) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode(WorkItemFactory.toJson(request));
    }
    if (initiativeId == null) {
      throw new core.ArgumentError("Parameter initiativeId is required.");
    }

    _downloadOptions = null;

    _url = 'initiatives/' +
        commons.Escaper.ecapeVariable('$initiativeId') +
        '/workitems';

    var _response = _requester.request(_url, "PUT",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => null);
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
    if (_json.containsKey("leader")) {
      message.leader = UserFactory.fromJson(_json["leader"]);
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
    if (message.leader != null) {
      _json["leader"] = UserFactory.toJson(message.leader);
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

class InitiativeFactory {
  static Initiative fromJson(core.Map _json) {
    var message = new Initiative();
    if (_json.containsKey("description")) {
      message.description = _json["description"];
    }
    if (_json.containsKey("group")) {
      message.group = GroupFactory.fromJson(_json["group"]);
    }
    if (_json.containsKey("id")) {
      message.id = _json["id"];
    }
    if (_json.containsKey("leader")) {
      message.leader = UserFactory.fromJson(_json["leader"]);
    }
    if (_json.containsKey("name")) {
      message.name = _json["name"];
    }
    if (_json.containsKey("objective")) {
      message.objective = ObjectiveFactory.fromJson(_json["objective"]);
    }
    if (_json.containsKey("organization")) {
      message.organization =
          OrganizationFactory.fromJson(_json["organization"]);
    }
    if (_json.containsKey("stages")) {
      message.stages = (_json["stages"] as core.List)
          .map<Stage>((value) => StageFactory.fromJson(value))
          .toList();
    }
    if (_json.containsKey("workItems")) {
      message.workItems = (_json["workItems"] as core.List)
          .map<WorkItem>((value) => WorkItemFactory.fromJson(value))
          .toList();
    }
    return message;
  }

  static core.Map toJson(Initiative message) {
    var _json = new core.Map();
    if (message.description != null) {
      _json["description"] = message.description;
    }
    if (message.group != null) {
      _json["group"] = GroupFactory.toJson(message.group);
    }
    if (message.id != null) {
      _json["id"] = message.id;
    }
    if (message.leader != null) {
      _json["leader"] = UserFactory.toJson(message.leader);
    }
    if (message.name != null) {
      _json["name"] = message.name;
    }
    if (message.objective != null) {
      _json["objective"] = ObjectiveFactory.toJson(message.objective);
    }
    if (message.organization != null) {
      _json["organization"] = OrganizationFactory.toJson(message.organization);
    }
    if (message.stages != null) {
      _json["stages"] =
          message.stages.map((value) => StageFactory.toJson(value)).toList();
    }
    if (message.workItems != null) {
      _json["workItems"] = message.workItems
          .map((value) => WorkItemFactory.toJson(value))
          .toList();
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
    if (_json.containsKey("description")) {
      message.description = _json["description"];
    }
    if (_json.containsKey("endDate")) {
      message.endDate = core.DateTime.parse(_json["endDate"]);
    }
    if (_json.containsKey("group")) {
      message.group = GroupFactory.fromJson(_json["group"]);
    }
    if (_json.containsKey("id")) {
      message.id = _json["id"];
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
    if (message.description != null) {
      _json["description"] = message.description;
    }
    if (message.endDate != null) {
      _json["endDate"] = (message.endDate).toIso8601String();
    }
    if (message.group != null) {
      _json["group"] = GroupFactory.toJson(message.group);
    }
    if (message.id != null) {
      _json["id"] = message.id;
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

class StageFactory {
  static Stage fromJson(core.Map _json) {
    var message = new Stage();
    if (_json.containsKey("id")) {
      message.id = _json["id"];
    }
    if (_json.containsKey("index")) {
      message.index = _json["index"];
    }
    if (_json.containsKey("name")) {
      message.name = _json["name"];
    }
    if (_json.containsKey("state")) {
      message.state = StateFactory.fromJson(_json["state"]);
    }
    return message;
  }

  static core.Map toJson(Stage message) {
    var _json = new core.Map();
    if (message.id != null) {
      _json["id"] = message.id;
    }
    if (message.index != null) {
      _json["index"] = message.index;
    }
    if (message.name != null) {
      _json["name"] = message.name;
    }
    if (message.state != null) {
      _json["state"] = StateFactory.toJson(message.state);
    }
    return _json;
  }
}

class StateFactory {
  static State fromJson(core.Map _json) {
    var message = new State();
    if (_json.containsKey("color")) {
      message.color =
          (_json["color"] as core.Map).cast<core.String, core.int>();
    }
    if (_json.containsKey("id")) {
      message.id = _json["id"];
    }
    if (_json.containsKey("index")) {
      message.index = _json["index"];
    }
    if (_json.containsKey("name")) {
      message.name = _json["name"];
    }
    return message;
  }

  static core.Map toJson(State message) {
    var _json = new core.Map();
    if (message.color != null) {
      _json["color"] = message.color;
    }
    if (message.id != null) {
      _json["id"] = message.id;
    }
    if (message.index != null) {
      _json["index"] = message.index;
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
    if (_json.containsKey("user")) {
      message.user = UserFactory.fromJson(_json["user"]);
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
    if (message.user != null) {
      _json["user"] = UserFactory.toJson(message.user);
    }
    return _json;
  }
}

class WorkItemFactory {
  static WorkItem fromJson(core.Map _json) {
    var message = new WorkItem();
    if (_json.containsKey("assignedTo")) {
      message.assignedTo = (_json["assignedTo"] as core.List)
          .map<User>((value) => UserFactory.fromJson(value))
          .toList();
    }
    if (_json.containsKey("checkItems")) {
      message.checkItems = (_json["checkItems"] as core.List)
          .map<WorkItemCheckItem>(
              (value) => WorkItemCheckItemFactory.fromJson(value))
          .toList();
    }
    if (_json.containsKey("completed")) {
      message.completed = _json["completed"];
    }
    if (_json.containsKey("description")) {
      message.description = _json["description"];
    }
    if (_json.containsKey("dueDate")) {
      message.dueDate = core.DateTime.parse(_json["dueDate"]);
    }
    if (_json.containsKey("id")) {
      message.id = _json["id"];
    }
    if (_json.containsKey("name")) {
      message.name = _json["name"];
    }
    if (_json.containsKey("stage")) {
      message.stage = StageFactory.fromJson(_json["stage"]);
    }
    return message;
  }

  static core.Map toJson(WorkItem message) {
    var _json = new core.Map();
    if (message.assignedTo != null) {
      _json["assignedTo"] =
          message.assignedTo.map((value) => UserFactory.toJson(value)).toList();
    }
    if (message.checkItems != null) {
      _json["checkItems"] = message.checkItems
          .map((value) => WorkItemCheckItemFactory.toJson(value))
          .toList();
    }
    if (message.completed != null) {
      _json["completed"] = message.completed;
    }
    if (message.description != null) {
      _json["description"] = message.description;
    }
    if (message.dueDate != null) {
      _json["dueDate"] = (message.dueDate).toIso8601String();
    }
    if (message.id != null) {
      _json["id"] = message.id;
    }
    if (message.name != null) {
      _json["name"] = message.name;
    }
    if (message.stage != null) {
      _json["stage"] = StageFactory.toJson(message.stage);
    }
    return _json;
  }
}

class WorkItemCheckItemFactory {
  static WorkItemCheckItem fromJson(core.Map _json) {
    var message = new WorkItemCheckItem();
    if (_json.containsKey("finished")) {
      message.finished = _json["finished"];
    }
    if (_json.containsKey("id")) {
      message.id = _json["id"];
    }
    if (_json.containsKey("index")) {
      message.index = _json["index"];
    }
    if (_json.containsKey("name")) {
      message.name = _json["name"];
    }
    return message;
  }

  static core.Map toJson(WorkItemCheckItem message) {
    var _json = new core.Map();
    if (message.finished != null) {
      _json["finished"] = message.finished;
    }
    if (message.id != null) {
      _json["id"] = message.id;
    }
    if (message.index != null) {
      _json["index"] = message.index;
    }
    if (message.name != null) {
      _json["name"] = message.name;
    }
    return _json;
  }
}
