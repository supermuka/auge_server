import 'package:test/test.dart';

import 'package:auge_server/domain/general/organization_directory_service.dart';
import 'package:auge_server/src/service/general/organization_directory_service_service.dart';

void main() {

  //OrganizationConfigurationService organizationConfigurationService;

  setUp(() {
    //organizationConfigurationService = OrganizationConfigurationService();
  });

  // Test
  group('Organization Configuration Service,', () {

      test('authenticateDirectoryService.', () async {

        String organizationId = 'f9c23c01-89ad-4501-81f0-1ad8cad522f9';
        String userIdentityIdentification = 'micheli.schwebel@levius.com.br';
        String userIdentityProviderDn = 'cn=Micheli Schwebel,ou=users,dc=auge,dc=levius,dc=com,dc=br';
        String userIdentityPassword = '123';

        int statusResult = await OrganizationDirectoryServiceService.authDirectoryService(organizationId, userIdentityIdentification, userIdentityProviderDn, userIdentityPassword);
        if (statusResult != null) print(DirectoryServiceStatus.values[statusResult]);
        expect(statusResult, equals(0));
      });
  });
}