import 'package:flutter/material.dart';
import 'package:myapp_core/common/constants.dart';

class MyAppIcon extends StatelessWidget {
  final String iconSrc;

  const MyAppIcon({Key key, this.iconSrc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 14, //168
      width: 14,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.contain,
          image: AssetImage(iconSrc, package: ASSET_PACKAGE),
        ),
      ),
    );
  }
}
