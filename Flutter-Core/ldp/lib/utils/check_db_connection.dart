// example class to test if firebase and native connection works
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CheckDataBaseConnection extends StatefulWidget {
  CheckDataBaseConnection({Key key}) : super(key: key);

  @override
  _CheckDataBaseConnectionState createState() => _CheckDataBaseConnectionState();
}

class _CheckDataBaseConnectionState extends State<CheckDataBaseConnection> {
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