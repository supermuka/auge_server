import 'package:auge_shared/domain/general/authorization.dart';
import 'package:auge_shared/protos/generated/general/user.pb.dart';
import 'package:test/test.dart';

import 'package:auge_shared/src/util/common_utils.dart';

import 'package:auge_shared/domain/objective/objective.dart' as objective_m;
import 'package:auge_server/src/util/mail.dart';
import 'package:auge_shared/message/domain_messages.dart';
import 'package:auge_shared/message/messages.dart';
import 'package:auge_shared/protos/generated/objective/objective_measure.pbgrpc.dart';

void main() {

  setUp(() {
  });

  // Role: superAdmin
  // Object: users
  group('Test eMail', () {

    test('Send Auge e-mail notifications.', () async {
      // expect(AugeMail.sendEMail(), isTrue);

      List<AugeMailMessageTo> eMails = [];

      Objective objective = Objective();
      objective.name = 'Terminar o software de gerenciamento por objetivos';
      objective.leader = User();
      objective.leader.userProfile = UserProfile();
      objective.leader.userProfile.eMail = 'samuel.schwebel@levius.com.br';
      objective.leader.userProfile.idiomLocale = 'pt_BR';
/*
      if (objective.leader.userProfile.idiomLocale != null) {
        Intl.defaultLocale = objective.leader.userProfile.idiomLocale;
        initializeDateFormatting(Intl.defaultLocale);
        await initializeMessages(Intl.defaultLocale);
      }
*/
      await CommonUtils.setDefaultLocale(objective.leader.userProfile.idiomLocale);

      String className = 'Objective';

      SystemFunction systemFunction = SystemFunction.create;

      // Leader
      eMails.add(
          AugeMailMessageTo([objective.leader.userProfile.eMail],
              ClassNameMsg.label(className),
              SystemFunctionMsg.inPastLabel(systemFunction.toString().split('.').last),
              objective.name,
              ObjectiveDomainMsg.fieldLabel(objective_m.Objective.leaderField),
              'https://auge.levius.com.br/'
          )
      );

      // SEND E-MAIL
      bool eMailOk = await AugeMail().sendNotification(eMails);
      expect(eMailOk, isTrue);
      // expect(true, isTrue);
    });
  });
}