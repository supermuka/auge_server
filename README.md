# auge_server

A web server built using [Shelf](https://pub.dartlang.org/packages/shelf).

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).

https://console.cloud.google.com/home/dashboard?project=auge-203523&authuser=1&organizationId=57193548143

pub run rpc:generate client -i lib/augeapi.dart -o lib/client -p 8091

pub global activate discoveryapis_generator


SERVER INSTALLATION

Debian 9.0


DATABASE

Postgresql 9.6 on gcloud.

https://cloud.google.com/community/tutorials/setting-up-postgres

user/pass: postgres/admin@levius#2018


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


cd bin
dart --snapshot=auge-server.dart.snapshot server.dart

API RETURN

Collection always return a list instance that maybe empty, not a error.
Object/Message if not found, return a error because it is considerated a resource.