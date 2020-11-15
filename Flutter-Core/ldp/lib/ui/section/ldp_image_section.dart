import 'package:flutter/material.dart';
import 'package:ldp/utils/constants.dart';
import 'package:myapp_core/common/constants.dart';
import 'package:myapp_core/common/database_constants.dart';

class LdpImageSection extends StatelessWidget {
  final String imageURL;
  const LdpImageSection({
    this.imageHeight = PHOTO_HEIGHT, Key key,
    this.imageURL}) : super(key: key);
  
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: imageHeight,
      width: double.infinity,
      decoration: BoxDecoration(
              image: DecorationImage(
                  image: 
                  (_isValidURL(imageURL ?? "")) 
                    ? NetworkImage(imageURL)
                    : AssetImage('assets/images/placeholder_noimage.jpg',
                      package: ASSET_PACKAGE),
                  fit: BoxFit.fitWidth,
                  alignment:Alignment.topCenter
                  )),
    );
  }

  bool _isValidURL(String imageURL) {
    if (imageURL.startsWith("https://firebasestorage.googleapis.com/v0/b/my-app-leej.appspot.com/o/$ITEMS_IMAGES")) {
      return true;
    }
    return false;
  }
}


