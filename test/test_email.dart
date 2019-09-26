import 'package:auge_server/model/general/authorization.dart';
import 'package:auge_server/src/protos/generated/general/user.pb.dart';
import 'package:test/test.dart';

import 'package:auge_server/model/objective/objective.dart' as objective_m;
import 'package:auge_server/src/util/mail.dart';
import 'package:auge_server/shared/message/model_messages.dart';
import 'package:auge_server/shared/message/messages.dart';
import 'package:auge_server/src/protos/generated/objective/objective_measure.pbgrpc.dart';

void main() {


  setUp(() {
  });

  // Role: superAdmin
  // Object: users
  group('Test eMail', () {

    test('Send Auge e-mail notifications.', () {
      // expect(AugeMail.sendEMail(), isTrue);

      List<AugeMailMessageTo> eMails = [];

      Objective objective = Objective();
      objective.name = 'Terminar o software de gerenciamento por objetivos';
      objective.leader = User();
      objective.leader.userProfile = UserProfile();
      objective.leader.userProfile.eMail = 'samuel.schwebel@levius.com.br';

      String className = 'Objective';

      SystemFunction systemFunction = SystemFunction.create;

      // Leader
      eMails.add(
          AugeMailMessageTo([objective.leader.userProfile.eMail],
              className,
              SystemFunctionMsg.inPastLabel(systemFunction.toString()),
              objective.name,
              FieldMsg.label('${objective_m.Objective.className}.${objective_m.Objective.leaderField}')
          )
      );

      // SEND E-MAIL
      AugeMail().send(eMails);
    //expect(() => AugeMail().send(eMails), returnsNormally);
    });
  });
}