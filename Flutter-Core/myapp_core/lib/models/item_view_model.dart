import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myapp_core/common/database_constants.dart';

class ItemViewModel {
  final listingID;
  final category;
  final description;
  final imageURL;
  final price;
  final sellerID;
  final tags;
  final title;
  final origin;

  ItemViewModel(
      {@required this.listingID,
      this.category,
      this.description,
      this.imageURL,
      this.price,
      this.sellerID,
      this.tags,
      this.title,
      this.origin});

  static Future<ItemViewModel> of(String listingID) async {
    final DatabaseReference dbRef =
        FirebaseDatabase.instance.reference().child(ITEMS_SELL_TABLE);
    String catValue,
        desValue,
        imageValue,
        sidValue,
        titleValue,
        originValue,
        priceValue;
    List<dynamic> tagsValue;

    await dbRef.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;

      catValue = values[listingID][I_CATEGORY] ?? "";
      desValue = values[listingID][I_DESCRIPTION] ?? "";
      imageValue = values[listingID][I_IMAGE] ?? "";
      priceValue = values[listingID][I_PRICE].toString() ?? "";
      sidValue = values[listingID][I_SID] ?? "";
      titleValue = values[listingID][I_TITLE] ?? "";
      originValue = values[listingID][I_ORIGIN] ?? "";
      // tagsValue = values[listingID][I_TAGS] ?? [];
    });

    return ItemViewModel(
        listingID: listingID,
        category: catValue,
        description: desValue,
        imageURL: imageValue,
        price: "\$ $priceValue",
        sellerID: sidValue,
        tags: tagsValue,
        title: titleValue,
        origin: originValue);
  }
}
