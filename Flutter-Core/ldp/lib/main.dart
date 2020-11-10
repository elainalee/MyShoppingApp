import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ldp/common/ldp_theme.dart';
import 'package:ldp/model/user_view_model.dart';

import 'ldp_screen.dart';

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
        child: LdpScreen(userViewModel: UserViewModel(username: "admin", password: "00000")),
      )
    );
  }
}

// example class to test if firebase and native connection works
class LdpHomePage extends StatefulWidget {
  LdpHomePage({Key key}) : super(key: key);

  @override
  _LdpHomePageState createState() => _LdpHomePageState();
}

class _LdpHomePageState extends State<LdpHomePage> {
  // updated database settings in hidden files
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("example");

  void sendData() {
    databaseReference.push().set({"First Name": "Jenn", "Last Name": "Lee"});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("testing database page"),
        ),
        body: Center(
            child: FlatButton(
          child: Text("Press For"),
          color: Colors.red,
          onPressed: () {
            sendData();
          },
        )));
  }
}
