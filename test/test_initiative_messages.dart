import 'package:test/test.dart';

import 'package:auge_server/src/protos/generated/initiative/initiative.pb.dart' as initiative_pb;
import 'package:auge_server/src/protos/generated/initiative/work_item.pb.dart' as work_item_pb;
import 'package:auge_server/src/protos/generated/initiative/stage.pb.dart' as stage_pb;
import 'package:auge_server/src/protos/generated/initiative/state.pb.dart' as state_pb;

import 'package:auge_server/model/general/organization.dart' as organization_m;
import 'package:auge_server/model/general/group.dart' as group_m;
import 'package:auge_server/model/general/user.dart' as user_m;
import 'package:auge_server/model/initiative/initiative.dart' as initiative_m;
import 'package:auge_server/model/initiative/work_item.dart' as work_item_m;
import 'package:auge_server/model/initiative/stage.dart' as stage_m;
import 'package:auge_server/model/initiative/state.dart' as state_m;
import 'package:auge_server/model/objective/objective.dart' as objective_m;

void main() {

  group('Test Initiative Messages.', ()
  {
    setUp(() {

    });

    tearDown(() async {

    });

    group('Stage entity.', () {

      stage_m.Stage model = stage_m.Stage();

      model.id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
      model.version = 0;
      model.isDeleted = true;
      model.name = 'Name test';
      model.index = 0;
      model.state = state_m.State()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e';


      stage_pb.Stage proto;

      void callExcept() {
        expect(model.id, equals(proto.id));
        expect(model.version, equals(proto.version));
        expect(model.isDeleted, equals(proto.isDeleted));
        expect(model.name, equals(proto.name));
        expect(model.index, equals(proto.index));
        expect(model.state.id, equals(proto.state.id));
      }

      test('Call writeToProtoBuffer.', () async {

        proto = model.writeToProtoBuf();

        callExcept();

      });

      test('Call readToProtoBuffer.', () async {

        model = stage_m.Stage();
        model.readFromProtoBuf(proto);

        callExcept();
      });
    });


    group('State entity.', () {

      state_m.State model = state_m.State();

      model.id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
      model.version = 0;
      model.isDeleted = true;
      model.name = 'Name test';
      model.color = {'x': 0};
      model.index = 0;

      state_pb.State proto;

      void callExcept() {
        expect(model.id, equals(proto.id));
        expect(model.version, equals(proto.version));
        expect(model.isDeleted, equals(proto.isDeleted));
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
    });

    group('Initiative entity.', () {

      initiative_m.Initiative model = initiative_m.Initiative();

      model.id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
      model.version = 0;
      model.isDeleted = true;
      model.name = 'Name test';
      model.description = 'Description test';
      model.organization = organization_m.Organization()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
      model.group = group_m.Group()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
      model.leader = user_m.User()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
      model.objective = objective_m.Objective()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
      model.workItems.add(work_item_m.WorkItem()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e');
      model.stages.add(stage_m.Stage()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e');

      initiative_pb.Initiative proto;

      void callExcept() {
        expect(model.id, equals(proto.id));
        expect(model.version, equals(proto.version));
        expect(model.isDeleted, equals(proto.isDeleted));
        expect(model.name, equals(proto.name));
        expect(model.description, equals(proto.description));

        expect(model.organization.id, equals(proto.organization.id));
        expect(model.group.id, equals(proto.group.id));
        expect(model.leader.id, equals(proto.leader.id));
        expect(model.objective.id, equals(proto.objective.id));

        expect(model.workItems.isNotEmpty, equals(proto.workItems.isNotEmpty));
        expect(model.workItems.first.id, equals(proto.workItems.first.id));

        expect(model.stages.isNotEmpty, equals(proto.stages.isNotEmpty));
        expect(model.stages.first.id, equals(proto.stages.first.id));
      }

      test('Call writeToProtoBuffer.', () async {

        proto = model.writeToProtoBuf();

        callExcept();

      });

      test('Call readToProtoBuffer.', () async {

        model = initiative_m.Initiative();
        model.readFromProtoBuf(proto);

        callExcept();
      });
    });

    group('WorkItem entity.', () {

      work_item_m.WorkItem model = work_item_m.WorkItem();

      model.id = '5033aefd-d440-4422-80ef-4d97bae9a06e';
      model.version = 0;
      model.isDeleted = true;
      model.name = 'Name test';
      model.description = 'Description test';
      model.completed = 50;
      model.dueDate = DateTime.now();
      model.checkItems.add(work_item_m.WorkItemCheckItem()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e');
      model.assignedTo.add(user_m.User()..id = '5033aefd-d440-4422-80ef-4d97bae9a06e' );

      work_item_pb.WorkItem proto;

      void callExcept() {
        expect(model.id, equals(proto.id));
        expect(model.version, equals(proto.version));
        expect(model.isDeleted, equals(proto.isDeleted));
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
    });

  });
}