import 'package:flutter/material.dart';
import 'package:ldp/utils/constants.dart';

class LdpImageSection extends StatelessWidget {

  const LdpImageSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image(
              image: AssetImage('assets/images/admin_pineapple_1.jpg',
                  package: ASSET_PACKAGE)),
        ],
      );
  }
}


