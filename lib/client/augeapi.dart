// This is a generated file (see the discoveryapis_generator project).

// ignore_for_file: unnecessary_cast

library auge_server.augeApi.client;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;
import 'package:auge_server/model/group.dart';
import 'package:auge_server/message_type/id_message.dart';
import 'package:auge_server/model/organization.dart';
import 'package:auge_server/model/user.dart';
import 'package:auge_server/model/user_profile_organization.dart';
export 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client augeApi/v1';

class AugeApi {
  final commons.ApiRequester _requester;

  AugeApi(http.Client client,
      {core.String rootUrl: "http://localhost:8091/",
      core.String servicePath: "augeApi/v1/"})
      : _requester =
            new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);

  /// Request parameters:
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future closeConnection() {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    _downloadOptions = null;

    _url = 'close';

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
  async.Future<IdMessage> createGroup(Group request) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode(GroupFactory.toJson(request));
    }

    _url = 'groups';

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
  async.Future<IdMessage> createOrganization(Organization request) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode(OrganizationFactory.toJson(request));
    }

    _url = 'organizations';

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
  async.Future<IdMessage> createUser(User request) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode(UserFactory.toJson(request));
    }

    _url = 'users';

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
  async.Future deleteGroup(core.String id) {
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

    _url = 'groups/' + commons.Escaper.ecapeVariable('$id');

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
  async.Future deleteOrganization(core.String id) {
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

    _url = 'organizations/' + commons.Escaper.ecapeVariable('$id');

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
  async.Future deleteUser(core.String id) {
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

    _url = 'users/' + commons.Escaper.ecapeVariable('$id');

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
  /// [eMail] - Path parameter: 'eMail'.
  ///
  /// [password] - Path parameter: 'password'.
  ///
  /// [withProfile] - Query parameter: 'withProfile'.
  ///
  /// Completes with a [User].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<User> getAuthenticatedUserWithEmail(
      core.String eMail, core.String password,
      {core.bool withProfile}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (eMail == null) {
      throw new core.ArgumentError("Parameter eMail is required.");
    }
    if (password == null) {
      throw new core.ArgumentError("Parameter password is required.");
    }
    if (withProfile != null) {
      _queryParams["withProfile"] = ["${withProfile}"];
    }

    _url = 'users/' +
        commons.Escaper.ecapeVariable('$eMail') +
        '/' +
        commons.Escaper.ecapeVariable('$password');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => UserFactory.fromJson(data));
  }

  /// Request parameters:
  ///
  /// [userId] - Path parameter: 'user_id'.
  ///
  /// Completes with a [core.List<UserProfileOrganization>].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<core.List<UserProfileOrganization>>
      getAuthorizatedOrganizationsByUserId(core.String userId) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }

    _url = 'users_profile_organizations/' +
        commons.Escaper.ecapeVariable('$userId');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => (data as core.List)
        .map<UserProfileOrganization>(
            (value) => UserProfileOrganizationFactory.fromJson(value))
        .toList());
  }

  /// Request parameters:
  ///
  /// [id] - Path parameter: 'id'.
  ///
  /// Completes with a [Group].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Group> getGroupById(core.String id) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'groups/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => GroupFactory.fromJson(data));
  }

  /// Request parameters:
  ///
  /// [id] - Path parameter: 'id'.
  ///
  /// Completes with a [GroupType].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<GroupType> getGroupTypeById(core.String id) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'group_types/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => GroupTypeFactory.fromJson(data));
  }

  /// Request parameters:
  ///
  /// Completes with a [core.List<GroupType>].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<core.List<GroupType>> getGroupTypes() {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    _url = 'group_types';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => (data as core.List)
        .map<GroupType>((value) => GroupTypeFactory.fromJson(value))
        .toList());
  }

  /// Request parameters:
  ///
  /// [organizationId] - Path parameter: 'organizationId'.
  ///
  /// Completes with a [core.List<Group>].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<core.List<Group>> getGroups(core.String organizationId) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (organizationId == null) {
      throw new core.ArgumentError("Parameter organizationId is required.");
    }

    _url = 'organization/' +
        commons.Escaper.ecapeVariable('$organizationId') +
        '/groups';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => (data as core.List)
        .map<Group>((value) => GroupFactory.fromJson(value))
        .toList());
  }

  /// Request parameters:
  ///
  /// [id] - Path parameter: 'id'.
  ///
  /// Completes with a [Organization].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<Organization> getOrganizationById(core.String id) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _url = 'organizations/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => OrganizationFactory.fromJson(data));
  }

  /// Request parameters:
  ///
  /// Completes with a [core.List<Organization>].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<core.List<Organization>> getOrganizations() {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    _url = 'organizations';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => (data as core.List)
        .map<Organization>((value) => OrganizationFactory.fromJson(value))
        .toList());
  }

  /// Request parameters:
  ///
  /// [id] - Path parameter: 'id'.
  ///
  /// [withProfile] - Query parameter: 'withProfile'.
  ///
  /// Completes with a [User].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<User> getUserById(core.String id, {core.bool withProfile}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }
    if (withProfile != null) {
      _queryParams["withProfile"] = ["${withProfile}"];
    }

    _url = 'users/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => UserFactory.fromJson(data));
  }

  /// Request parameters:
  ///
  /// [withProfile] - Query parameter: 'withProfile'.
  ///
  /// Completes with a [core.List<User>].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<core.List<User>> getUsers({core.bool withProfile}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (withProfile != null) {
      _queryParams["withProfile"] = ["${withProfile}"];
    }

    _url = 'users';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => (data as core.List)
        .map<User>((value) => UserFactory.fromJson(value))
        .toList());
  }

  /// Request parameters:
  ///
  /// [organizationId] - Path parameter: 'organizationId'.
  ///
  /// [withProfile] - Query parameter: 'withProfile'.
  ///
  /// Completes with a [core.List<User>].
  ///
  /// Completes with a [commons.ApiRequestError] if the API endpoint returned an
  /// error.
  ///
  /// If the used [http.Client] completes with an error when making a REST call,
  /// this method will complete with the same error.
  async.Future<core.List<User>> getUsersByOrganizationId(
      core.String organizationId,
      {core.bool withProfile}) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (organizationId == null) {
      throw new core.ArgumentError("Parameter organizationId is required.");
    }
    if (withProfile != null) {
      _queryParams["withProfile"] = ["${withProfile}"];
    }

    _url = 'organizations/' +
        commons.Escaper.ecapeVariable('$organizationId') +
        '/users';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => (data as core.List)
        .map<User>((value) => UserFactory.fromJson(value))
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
  async.Future updateGroup(Group request) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode(GroupFactory.toJson(request));
    }

    _downloadOptions = null;

    _url = 'groups';

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
  async.Future updateOrganization(Organization request) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode(OrganizationFactory.toJson(request));
    }

    _downloadOptions = null;

    _url = 'organizations';

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
  async.Future updateUser(User request) {
    var _url = null;
    var _queryParams = new core.Map<core.String, core.List<core.String>>();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.json.encode(UserFactory.toJson(request));
    }

    _downloadOptions = null;

    _url = 'users';

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

class UserProfileOrganizationFactory {
  static UserProfileOrganization fromJson(core.Map _json) {
    var message = new UserProfileOrganization();
    if (_json.containsKey("authorizationLevel")) {
      message.authorizationLevel = _json["authorizationLevel"];
    }
    if (_json.containsKey("organization")) {
      message.organization =
          OrganizationFactory.fromJson(_json["organization"]);
    }
    if (_json.containsKey("userProfile")) {
      message.userProfile = UserProfileFactory.fromJson(_json["userProfile"]);
    }
    return message;
  }

  static core.Map toJson(UserProfileOrganization message) {
    var _json = new core.Map();
    if (message.authorizationLevel != null) {
      _json["authorizationLevel"] = message.authorizationLevel;
    }
    if (message.organization != null) {
      _json["organization"] = OrganizationFactory.toJson(message.organization);
    }
    if (message.userProfile != null) {
      _json["userProfile"] = UserProfileFactory.toJson(message.userProfile);
    }
    return _json;
  }
}
