import 'package:flutter/material.dart';
import 'package:ldp/common/ldp_theme.dart';
import 'package:ldp/model/user_view_model.dart';

import 'ldp_screen.dart';
// import 'utils/check_db_connection.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ldp Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Theme(
        data: buildLdpTheme(context),
        child: LdpScreen(userViewModel: UserViewModel(username: "admin", password: "00000"), 
        listingID: "-MLkrcZq4IO766ZEF9pX"),
        // child: CheckDataBaseConnection()
      )
    );
  }
}