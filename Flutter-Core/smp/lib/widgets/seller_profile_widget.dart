import 'package:flutter/material.dart';
import 'package:myapp_core/common/constants.dart';
import 'package:myapp_core/common/database_constants.dart';
import 'package:myapp_core/models/seller_view_model.dart';

import '../utils/size_config.dart';

class SellerProfileWidget extends StatelessWidget {
  const SellerProfileWidget({
    Key key,
    this.sellerViewModel,
  }) : super(key: key);
  final SellerViewModel sellerViewModel;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize ?? 10;
    return SizedBox(
      height: defaultSize * 24, // 240
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: CustomShape(),
            child: Container(
              height: defaultSize * 15, //200
              color: Theme.of(context).primaryColor,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: defaultSize), //12
                  height: defaultSize * 14, //168
                  width: defaultSize * 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: defaultSize * 0.6, //7.2
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          (_isValidURL(sellerViewModel?.sellerImageURL ?? ""))
                              ? NetworkImage(sellerViewModel?.sellerImageURL)
                              : AssetImage(
                                  'assets/images/placeholder_noimage.jpg',
                                  package: ASSET_PACKAGE),
                    ),
                  ),
                ),
                Text(sellerViewModel?.sellerName ?? "",
                    style: Theme.of(context).textTheme.headline3),
                SizedBox(height: defaultSize / 2), //5
                Text(sellerViewModel?.sellerID ?? "",
                    style: Theme.of(context).textTheme.subtitle1)
              ],
            ),
          )
        ],
      ),
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

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
