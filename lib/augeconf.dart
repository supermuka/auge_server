import 'dart:convert';

class AugeConf {
  static final String _username = 'muka';
  static final String _password = '123';

  static final String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$_username:$_password'));

}
