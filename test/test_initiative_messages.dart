import 'package:test/test.dart';

import 'package:auge_server/src/protos/generated/work/work_work_item.pb.dart' as work_work_item_pb;
import 'package:auge_server/src/protos/generated/work/work_stage.pb.dart' as work_stage_pb;
import 'package:auge_server/src/protos/generated/work/state.pb.dart' as state_pb;

import 'package:auge_server/model/general/organization.dart' as organization_m;
import 'package:auge_server/model/general/group.dart' as group_m;
import 'package:auge_server/model/general/user.dart' as user_m;
import 'package:auge_server/model/work/work.dart' as work_m;
import 'package:auge_server/model/work/work_item.dart' as work_item_m;
import 'package:auge_server/model/work/work_stage.dart' as stage_m;
import 'package:auge_server/model/work/state.dart' as state_m;
import 'package:auge_server/model/objective/objective.dart' as objective_m;

void main() {

  group('Test Work Messages.', ()
  {
    setUp(() {

    });

    tearDown(() async {

    });

    group('Stage entity.', () {

      stage_m.WorkStage model = stage_m.WorkStage();
      work_stage_pb.WorkStage proto;

      setUp(() {
        model.id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.version = 0;
        model.name = 'Name test';
        model.index = 0;
        model.state = state_m.State()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
      });

      void callExcept() {
        expect(model.id, equals(proto.id));
        expect(model.version, equals(proto.version));
        expect(model.name, equals(proto.name));
        expect(model.index, equals(proto.index));
        expect(model.state.id, equals(proto.state.id));
      }

      test('Call writeToProtoBuffer.', () async {

        proto = model.writeToProtoBuf();

        callExcept();

      });

      test('Call readToProtoBuffer.', () async {

        model = stage_m.WorkStage();
        model.readFromProtoBuf(proto);

        callExcept();
      });

      test('Call fromProtoBufToModelMap.', () async {
        Map<String, dynamic> m = stage_m.WorkStage.fromProtoBufToModelMap(proto);
        expect(m[stage_m.WorkStage.idField], equals(proto.id));
        expect(m[stage_m.WorkStage.versionField], equals(proto.version));
        expect(m[stage_m.WorkStage.nameField], equals(proto.name));
        expect(m[stage_m.WorkStage.indexField], equals(proto.index));
        expect(m[stage_m.WorkStage.stateField][state_m.State.idField], equals(proto.state.id));
      });

    });


    group('State entity.', () {

      state_m.State model = state_m.State();
      state_pb.State proto;

      setUp(() {
        model.id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.version = 0;
        model.name = 'Name test';
        model.color = {'x': 0};
        model.index = 0;
      });

      void callExcept() {
        expect(model.id, equals(proto.id));
        expect(model.version, equals(proto.version));
        expect(model.name, equals(proto.name));
        expect(model.index, equals(proto.index));
        expect(model.color['x'], equals(proto.color['x']));
      }

      test('Call writeToProtoBuffer.', () async {

        proto = model.writeToProtoBuf();

        callExcept();

      });

      test('Call readToProtoBuffer.', () async {

        model = state_m.State();
        model.readFromProtoBuf(proto);

        callExcept();
      });

      test('Call fromProtoBufToModelMap.', () async {
        Map<String, dynamic> m = state_m.State.fromProtoBufToModelMap(proto);
        expect(m[state_m.State.idField], equals(proto.id));
        expect(m[state_m.State.versionField], equals(proto.version));
        expect(m[state_m.State.nameField], equals(proto.name));
        expect(m[state_m.State.indexField], equals(proto.index));
        expect(m[state_m.State.colorField], equals(proto.color));
      });
    });

    group('Work entity.', () {

      work_m.Work model = work_m.Work();
      work_work_item_pb.Work proto;

      setUp(() {
        model.id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.version = 0;
        model.name = 'Name test';
        model.description = 'Description test';
        model.organization = organization_m.Organization()..id = '065fd565-2b53-4e95-a696-d66ba91ff6f5';
        model.group = group_m.Group()..id = 'a73ee1cd-9838-4d8e-a634-4e99d1a35161';
        model.leader = user_m.User()..id = 'a15496bc-9437-4e43-af00-b546ab47952e';
        model.objective = objective_m.Objective()..id = '30a4330f-1de7-454b-9bbd-2e83ec71b621';
        model.workItems.add(work_item_m.WorkItem()..id = 'eb801742-61f7-4da2-b498-984fc7bc4504');
        model.workStages.add(stage_m.WorkStage()..id = '7f8b226c-ee2d-4533-9e19-606bfc098d0e');

      });

      void callExcept() {
        expect(model.id, equals(proto.id));
        expect(model.version, equals(proto.version));
        expect(model.name, equals(proto.name));
        expect(model.description, equals(proto.description));

        expect(model.organization.id, equals(proto.organization.id));
        expect(model.group.id, equals(proto.group.id));
        expect(model.leader.id, equals(proto.leader.id));
        expect(model.objective.id, equals(proto.objective.id));

        expect(model.workItems.isNotEmpty, equals(proto.workItems.isNotEmpty));
        expect(model.workItems.first.id, equals(proto.workItems.first.id));

        expect(model.workStages.isNotEmpty, equals(proto.workStages.isNotEmpty));
        expect(model.workStages.first.id, equals(proto.workStages.first.id));
      }

      test('Call writeToProtoBuffer.', () async {

        proto = model.writeToProtoBuf();

        callExcept();

      });

      test('Call readToProtoBuffer.', () async {

        model = work_m.Work();
        model.readFromProtoBuf(proto);

        callExcept();
      });

      test('Call readToProtoBuffer.', () async {

        model = work_m.Work();
        model.readFromProtoBuf(proto);

        callExcept();
      });

      test('Call fromProtoBufToModelMap.', () async {
        Map<String, dynamic> m = work_m.Work.fromProtoBufToModelMap(proto);
        expect(m[work_m.Work.idField], equals(proto.id));
        expect(m[work_m.Work.versionField], equals(proto.version));
        expect(m[work_m.Work.nameField], equals(proto.name));
        expect(m[work_m.Work.descriptionField], equals(proto.description));
        expect(m[work_m.Work.organizationField][organization_m.Organization.idField], equals(proto.organization.id));
        expect(m[work_m.Work.groupField][group_m.Group.idField], equals(proto.group.id));
        expect(m[work_m.Work.leaderField][user_m.User.idField], equals(proto.leader.id));
        expect(m[work_m.Work.objectiveField][objective_m.Objective.idField], equals(proto.objective.id));
        expect(m[work_m.Work.workItemsField].first[work_item_m.WorkItem.idField], equals(proto.workItems.first.id));
        expect(m[work_m.Work.workStagesField].first[stage_m.WorkStage.idField], equals(proto.workStages.first.id));
      });
    });

    group('WorkItem entity.', () {

      work_item_m.WorkItem model = work_item_m.WorkItem();
      work_work_item_pb.WorkItem proto;

      setUp(() {
        model.id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
        model.version = 0;
        model.name = 'Name test';
        model.description = 'Description test';
        model.completed = 50;
        model.dueDate = DateTime.now();
        model.checkItems.add(work_item_m.WorkItemCheckItem()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e');
        model.assignedTo.add(user_m.User()..id = '7f8b226c-ee2d-4533-9e19-606bfc098d0e' );

      });

      void callExcept() {
        expect(model.id, equals(proto.id));
        expect(model.version, equals(proto.version));
        expect(model.name, equals(proto.name));
        expect(model.description, equals(proto.description));

        expect(model.completed, equals(proto.completed));

        expect(model.dueDate, equals(DateTime.fromMicrosecondsSinceEpoch(
                proto.dueDate.seconds.toInt() * 1000000 +
                    proto.dueDate.nanos ~/ 1000)));


        expect(model.checkItems.isNotEmpty, equals(proto.checkItems.isNotEmpty));
        expect(model.checkItems.first.id, equals(proto.checkItems.first.id));
        expect(model.assignedTo.isNotEmpty, equals(proto.assignedTo.isNotEmpty));
        expect(model.assignedTo.first.id, equals(proto.assignedTo.first.id));
      }

      test('Call writeToProtoBuffer.', () async {

        proto = model.writeToProtoBuf();

        callExcept();

      });

      test('Call readToProtoBuffer.', () async {

        model = work_item_m.WorkItem();
        model.readFromProtoBuf(proto);

        callExcept();
      });

      test('Call fromProtoBufToModelMap.', () async {
        Map<String, dynamic> m = work_item_m.WorkItem.fromProtoBufToModelMap(proto);

        expect(m[work_item_m.WorkItem.idField], equals(proto.id));
        expect(m[work_item_m.WorkItem.versionField], equals(proto.version));
        expect(m[work_item_m.WorkItem.nameField], equals(proto.name));
        expect(m[work_item_m.WorkItem.descriptionField], equals(proto.description));
        expect(m[work_item_m.WorkItem.completedField], equals(proto.completed));
        expect(m[work_item_m.WorkItem.dueDateField], equals(proto.dueDate));
        expect(m[work_item_m.WorkItem.checkItemsField].first[work_item_m.WorkItemCheckItem.idField], equals(proto.checkItems.first.id));
        expect(m[work_item_m.WorkItem.assignedToField].first[user_m.User.idField], equals(proto.assignedTo.first.id));
      });
    });
  });
}