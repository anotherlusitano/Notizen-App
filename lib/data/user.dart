import 'package:crypto/crypto.dart';
import 'dart:convert';

class User {
  String? username;
  String? password;
  int loggenIn = 0;

  User(String this.username, String this.password, this.loggenIn);

  Map<String, Object?> toMap() {
    return {
      'username': username,
      'password': password,
      'loggenIn': loggenIn,
    };
  }

  void encryptPassword() {
    var bytes = utf8.encode(password!);
    password = sha256.convert(bytes).toString();
  }

  @override
  String toString() {
    return 'User(username: $username, password: $password, loggenIn: $loggenIn)';
  }
}
