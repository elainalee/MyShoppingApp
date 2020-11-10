import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ItemViewModel {
  final listingID;
  final category;
  final description;
  final image;
  final price;
  final sellerID;
  final tags;
  final title;
  
  ItemViewModel({@required this.listingID, this.category, this.description, this.image,
                this.price, this.sellerID, this.tags, this.title});


  static Future<ItemViewModel> of(String listingID) async {
    final DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("items");
    String catValue, desValue, imageValue, sidValue, titleValue;
    List<String> tagsValue;
    double priceValue;

    await dbRef.once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> values = snapshot.value;
      catValue = values[listingID]["category"] ?? "";
      desValue = values[listingID]["description"] ?? "";
      imageValue = values[listingID]["image"] ?? "";
      priceValue = values[listingID]["price"] ?? 0;
      sidValue = values[listingID]["sellerid"] ?? "";
      titleValue = values[listingID]["title"] ?? "";

      // values[listingID]["tags"].forEach((key,values) {
      //   print(key);
      //   print(values);
      // });
    });

    return ItemViewModel(
      listingID: listingID,
      category: catValue,
      description: desValue,
      image: imageValue,
      price: priceValue,
      sellerID: sidValue,
      // TODO: implement this part
      tags: "",
      title: titleValue);
  }
}