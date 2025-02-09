import 'package:crypto/crypto.dart';
import 'dart:convert';

class User {
  String username;
  String password;
  int loggedIn = 0;

  User(this.username, this.password, this.loggedIn);

  Map<String, Object?> toMap() {
    return {
      'username': username,
      'password': password,
      'loggedIn': loggedIn,
    };
  }

  void encryptPassword() {
    var bytes = utf8.encode(password);
    password = sha256.convert(bytes).toString();
  }

  @override
  String toString() {
    return 'User(username: $username, password: $password, loggedIn: $loggedIn)';
  }
}
