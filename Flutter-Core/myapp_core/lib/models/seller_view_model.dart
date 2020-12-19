import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myapp_core/common/database_constants.dart';

class SellerViewModel {
  final sellerName;
  final sellerID;
  final storeName;
  final sellerImageURL;

  SellerViewModel(
      {this.storeName,
      this.sellerImageURL,
      this.sellerName,
      @required this.sellerID});

  static Future<SellerViewModel> of(String sellerID) async {
    final DatabaseReference dbRef =
        FirebaseDatabase.instance.reference().child(SELLER_TABLE);
    String storeName, sellerName, sellerImageURL;

    await dbRef.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      storeName = values[sellerID][S_SHOPNAME] ?? "";
      sellerImageURL = values[sellerID][S_SELLERIMAGE] ?? "";
      sellerName = values[sellerID][S_SELLERNAME] ?? "";
    });

    return SellerViewModel(
        sellerID: sellerID,
        storeName: storeName,
        sellerImageURL: sellerImageURL,
        sellerName: sellerName);
  }
}
