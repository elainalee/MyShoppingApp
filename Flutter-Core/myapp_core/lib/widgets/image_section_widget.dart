import 'package:flutter/material.dart';
import 'package:myapp_core/common/constants.dart';
import 'package:myapp_core/common/database_constants.dart';

class ImageSectionWidget extends StatelessWidget {
  const ImageSectionWidget(
      {this.imageHeight = PHOTO_HEIGHT,
      Key key,
      @required this.imageURL,
      this.cardBorderTopRadius = 0})
      : super(key: key);
  final String imageURL;
  final double cardBorderTopRadius;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: imageHeight,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(cardBorderTopRadius)),
          image: DecorationImage(
              image: (_isValidURL(imageURL ?? ""))
                  ? NetworkImage(imageURL)
                  : AssetImage('assets/images/placeholder_noimage.jpg',
                      package: ASSET_PACKAGE),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter)),
    );
  }

  bool _isValidURL(String imageURL) {
    if (imageURL.startsWith(
        "https://firebasestorage.googleapis.com/v0/b/my-app-leej.appspot.com/o/$ITEMS_IMAGES")) {
      return true;
    }
    return false;
  }
}
