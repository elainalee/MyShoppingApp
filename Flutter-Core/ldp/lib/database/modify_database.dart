import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:myapp_core/common/database_constants.dart';

class AddToCartsDB extends StatelessWidget {
  final String itemID;
  final String userID;

  AddToCartsDB({
    this.itemID,
    this.userID,
  });

  @override
  Widget build(BuildContext context) {
    String textToShow = "Failed to add the item. Please try again.";
    try {
      DatabaseReference dbRef =
          FirebaseDatabase.instance.reference().child(CARTS_TABLE);
      if (itemID != null && userID != null) {
        dbRef.push().set({
          C_IID: itemID,
          C_UID: userID,
        });
        textToShow = "this item is added to cart.";
      }
    } catch (err) {}

    return AlertDialog(
      title: Text(textToShow),
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
