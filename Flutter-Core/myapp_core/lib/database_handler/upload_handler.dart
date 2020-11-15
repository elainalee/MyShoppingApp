import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../exceptions/wrong_price_format.dart';
import '../common/database_constants.dart';

Future<StorageUploadTask> uploadImageFile(File imageFile) async {
    String fileName = basename(imageFile?.path ?? null);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('$ITEMS_IMAGES/$fileName');
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
  String category, String origin, String description, String sellerID}) {
    final DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child(ITEMS_SELL_TABLE);

    databaseReference.push().set({
      I_TITLE: title, 
      I_PRICE: price,
      I_CATEGORY: category,
      I_ORIGIN: origin,
      I_DESCRIPTION: description,
      I_IMAGE: imageURL ?? "",
      I_SID: sellerID ?? ""
    });
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