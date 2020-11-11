import 'package:flutter/material.dart';
import 'package:ldp/utils/constants.dart';

class LdpImageSection extends StatelessWidget {
  const LdpImageSection({
    this.imageHeight = PHOTO_HEIGHT, Key key}) : super(key: key);
  
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: imageHeight,
      width: double.infinity,
      decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/admin_pineapple_1.jpg',
                  package: ASSET_PACKAGE),
                  fit: BoxFit.fitWidth,
                  alignment:Alignment.topCenter
                  )),
    );
  }
}


