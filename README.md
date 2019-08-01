# auge_server

Server side useing Dart/Grpc and Postgres

https://console.cloud.google.com/home/dashboard?project=auge-203523&authuser=1&organizationId=57193548143

pub run rpc:generate client -i lib/augeapi.dart -o lib/client -p 8091

pub global activate discoveryapis_generator

protoc --dart_out=grpc:lib/src/protos/generated -Iprotos protos/general/group.proto --plugin=protoc-gen-dart=c:\Users\samue\AppData\Roaming\Pub\Cache\bin\protoc-gen-dart.bat

cd bin

dart --snapshot=..\auge_server_grpc_web\bin\auge_server.dart.snapshot server.dart

https://cloud.google.com/apis/design/standard_methods

SERVER INSTALLATION

Debian 9.0

DOCKER

https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-debian-9


DATABASE

Postgresql 9.6 on gcloud.

https://cloud.google.com/community/tutorials/setting-up-postgres


https://stackoverflow.com/questions/31249112/allow-docker-container-to-connect-to-a-local-host-postgres-database

table naming
https://medium.com/@fbnlsr/the-table-naming-dilemma-singular-vs-plural-dc260d90aaff


APACHE

https://cloud.google.com/compute/docs/tutorials/basic-webserver-apache

Enable SSL
https://www.digitalocean.com/community/tutorials/how-to-create-a-ssl-certificate-on-apache-for-debian-8

Multi sites
https://www.digitalocean.com/community/tutorials/how-to-set-up-apache-virtual-hosts-on-debian-8

Generate Certificate
https://certbot.eff.org/lets-encrypt/debianstretch-apache


ENCRYPT TRIPLE-DES
https://www.browserling.com/tools/triple-des-encrypt

https://medium.freecodecamp.org/how-to-get-https-working-on-your-local-development-environment-in-5-minutes-7af615770eec

DART SDK

Install
https://www.dartlang.org/tools/sdk#install

sudo sh -c 'curl https://storage.googleapis.com/dart-archive/channels/dev/release/2.0.0-dev.63.0/sdk/dartsdk-linux-arm64-release.zip > /etc/apt/sources.list.d/dart_unstable.list'

DART update (linux)

$ sudo sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_unstable.list > /etc/apt/sources.list.d/dart_unstable.list'
$ sudo apt-get update
$ sudo apt-get install dart

or
$ sudo wget https://storage.googleapis.com/dart-archive/channels/dev/release/2.0.0-dev.63.0/linux_packages/dart_2.0.0-dev.63.0-1_amd64.deb
$ sudo dpkg -i dart_2.0.0-dev.63.0-1_amd64.deb

SSL

https://www.digitalocean.com/community/tutorials/how-to-create-a-ssl-certificate-on-apache-for-debian-8
https://certbot.eff.org/lets-encrypt/debianstretch-apache
https://dart-lang.github.io/server/tls-ssl.html

API RETURN

Collection always return a list instance that maybe empty, not a error.
Object/Message if not found, return a error because it is considerated a resource.
PUT and POST return a new resource. See https://medium.com/studioarmix/learn-restful-api-design-ideals-c5ec915a430f (best practice), https://stackoverflow.com/questions/797834/should-a-restful-put-operation-return-something

LDAP

https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-openldap-and-phpldapadmin-on-ubuntu-16-04

Example:
https://www.dynatrace.com/support/help/setup-and-configuration/dynatrace-managed/users-and-groups-setup/manage-users-and-groups-with-ldap/
https://support.sugarcrm.com/Documentation/Sugar_Versions/9.0/Ent/Administration_Guide/Password_Management/index.html
https://avinetworks.com/docs/18.2/ldap-configuration-examples/
https://avinetworks.com/docs/18.2/ldap-authentication/
https://docs.microsoft.com/en-us/windows/desktop/adschema/a-useraccountcontrol
https://community.atlassian.com/t5/Jira-questions/Ignoring-disabled-users-in-LDAP-Active-Directory/qaq-p/451709
https://stackoverflow.com/questions/18177486/login-to-ldap-with-uid-instead-of-cn-in-dn-input
https://docs.moodle.org/37/en/LDAP_authentication

ldap vs ad - groups
https://www.perforce.com/manuals/p4sag/Content/P4SAG/security.ldap.groups.html

https://serverfault.com/questions/567776/which-field-to-use-when-authenticating-against-active-directory
https://blogs.msdn.microsoft.com/openspecification/2009/07/10/understanding-unique-attributes-in-active-directory/
https://msdn.microsoft.com/en-us/windows/desktop/aa366101
https://docs.microsoft.com/pt-br/windows/desktop/AD/naming-properties

bug:

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=599585
