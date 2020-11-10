import 'package:flutter/material.dart';

class UserViewModel {
  UserViewModel({@required this.username, @required this.password});
  final username;
  final password;

  static UserViewModel of(List<String> userInfo) =>
      UserViewModel(username: userInfo[0], password: userInfo[1]);
}
