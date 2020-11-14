import 'package:flutter/material.dart';

class MyAppPopUp extends StatelessWidget {
  final String popupText;

  MyAppPopUp({
    this.popupText,
  });

  @override
  Widget build(BuildContext context) {
    
    return AlertDialog(
      title: Text(
        popupText
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: (){
              Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}