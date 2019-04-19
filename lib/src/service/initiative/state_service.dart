// Copyright (c) 2019, Levius Tecnologia Ltda. All rights reserved.
// Author: Samuel C. Schwebel

import 'dart:async';
import 'dart:convert';

import 'package:grpc/grpc.dart';

import 'package:auge_server/src/protos/generated/initiative/state.pbgrpc.dart';
import 'package:auge_server/augeconnection.dart';
import 'package:auge_server/shared/rpc_error_message.dart';

class StateService extends StateServiceBase {

  // API
  @override
  Future<StatesResponse> getStates(ServiceCall call,
      Empty) async {
    StatesResponse statesResponse;
    statesResponse = StatesResponse()..webWorkAround = true
      ..states.addAll(
          await querySelectStates());
    return statesResponse;
  }

  @override
  Future<State> getState(ServiceCall call,
      StateGetRequest stateGetRequest) async {
    State state = await querySelectState(stateGetRequest);
    if (state == null) throw new GrpcError.notFound(
        RpcErrorDetailMessage.stateDataNotFoundReason);
    return state;
  }

  // QUERY
  // *** INITIATIVE STATES ***
  static Future<List<State>> querySelectStates([StateGetRequest stateGetRequest]) async {

    List<List<dynamic>> results;

    String queryStatement;

    queryStatement = "SELECT state.id, state.version, state.name, state.color, state.index"
        " FROM initiative.states state";

    Map<String, dynamic> substitutionValues;

    if (stateGetRequest != null && stateGetRequest.hasId()) {
      queryStatement += " WHERE state.id = @id";
      substitutionValues = {"id": stateGetRequest.id};
    }

    results =  await (await AugeConnection.getConnection()).query(queryStatement, substitutionValues: substitutionValues);
    List<State> states = new List();
    for (var row in results) {
      states.add(new State()..id = row[0]..version = row[1]..name = row[2]..color.addAll((json.decode(row[3]) as Map).cast<String, int>())..index = row[4]);
    }
    return states;
  }

  static Future<State> querySelectState(StateGetRequest stateGetRequest) async {
    List<State> states = await querySelectStates(stateGetRequest);
    if (states.isNotEmpty) {
      return states.first;
    } else {
      return null;
    }
  }
}