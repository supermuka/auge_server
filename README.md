# auge_server

A web server built using [Shelf](https://pub.dartlang.org/packages/shelf).

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).

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


cd bin
dart --snapshot=auge-server.dart.snapshot server.dart