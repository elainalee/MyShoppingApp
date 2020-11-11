import 'package:flutter/material.dart';
import 'package:ldp/common/ldp_theme.dart';
import 'package:ldp/model/user_view_model.dart';

// import 'database/check_db_connection.dart';
import 'ldp_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ldp Demo',
      theme: buildLdpTheme(context),

      home: LdpScreen(userViewModel: UserViewModel(username: "admin", password: "00000"), 
        listingID: "-MLkrcZq4IO766ZEF9pX"),
        // child: CheckDataBaseConnection()
    );
  }
}