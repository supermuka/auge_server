// This is a generated file (see the discoveryapis_generator project).

// ignore_for_file: unnecessary_cast

library auge_server.objectiveAugeApi.client;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;
import 'package:auge_server/model/group.dart';
import 'package:auge_server/message_type/id_message.dart';
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
  /// [objectiveid] - Path parameter: 'objectiveid'.
  ///
  /// Completes with a [IdMessage].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<IdMessage> createMeasure(
      Measure request, core.String objectiveid) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode(MeasureFactory.toJson(request));
    }
    if (objectiveid == null) {
      throw new core.ArgumentError("Parameter objectiveid is required.");
    }

    _url = 'objetives/' +
        commons.Escaper.ecapeVariable('$objectiveid') +
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
  /// Completes with a [core.List<Measure>].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<core.List<Measure>> getMeasures() {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    _url = 'measures';

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
  /// Completes with a [Objective].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Objective> getObjectiveById(core.String id,
      {core.bool withMeasures}) {
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
  /// [id] - Query parameter: 'id'.
  ///
  /// [withMeasures] - Query parameter: 'withMeasures'.
  ///
  /// [treeAlignedWithChildren] - Query parameter: 'treeAlignedWithChildren'.
  ///
  /// [withProfile] - Query parameter: 'withProfile'.
  ///
  /// Completes with a [core.List<Objective>].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<core.List<Objective>> getObjectives(core.String organizationId,
      {core.String id,
      core.bool withMeasures,
      core.bool treeAlignedWithChildren,
      core.bool withProfile}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (organizationId == null) {
      throw new core.ArgumentError("Parameter organizationId is required.");
    }
    if (id != null) {
      _queryParams["id"] = [id];
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
  /// [objectiveid] - Path parameter: 'objectiveid'.
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future updateMeasure(Measure request, core.String objectiveid) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode(MeasureFactory.toJson(request));
    }
    if (objectiveid == null) {
      throw new core.ArgumentError("Parameter objectiveid is required.");
    }

    _downloadOptions = null;

    _url = 'objetives/' +
        commons.Escaper.ecapeVariable('$objectiveid') +
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
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future updateObjective(Objective request) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode(ObjectiveFactory.toJson(request));
    }

    _downloadOptions = null;

    _url = 'objectives';

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
