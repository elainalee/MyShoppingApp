import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../exceptions/wrong_price_format.dart';
import '../common/database_constants.dart';

Future<StorageUploadTask> uploadImageFile(File imageFile) async {
    String fileName = basename(imageFile?.path ?? null);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('item_images/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageFile ?? null);
    return uploadTask;
  }

double priceTextToDouble(String priceText) {
  try {
      double price;
      price = double.parse(priceText);
      return price;
    } catch (err) {
      throw WrongPriceFormatException();
    }

}

void uploadListingData({String imageURL, String title, double price,
  String category, String origin, String description}) {
    final DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("example");

    databaseReference.push().set({
      "title": title, 
      "price": price,
      "category": category,
      "origin": origin,
      "description": description,
      "image": imageURL ?? ""
    });
    print("TRUE: LISTING UPLOADED");
  }

String uploadToCart({String itemID, String userID}) {
  try {
      DatabaseReference dbRef = FirebaseDatabase.instance.reference().child(CARTS_TABLE);
      if (itemID != null && userID != null) {
        dbRef.push().set({C_IID: itemID, C_UID: userID,});
        return "this item is added to cart.";
      } else {
        return "Failed to add the item. Please try again.";
      }
    } catch (err) {
      return "Failed to add the item. Please try again.";
    }
}