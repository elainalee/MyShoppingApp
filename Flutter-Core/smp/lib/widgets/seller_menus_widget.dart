import 'package:flutter/material.dart';

import '../utils/size_config.dart';

class SellerMenusWidget extends StatelessWidget {
  const SellerMenusWidget({
    Key key,
    this.menuIcon,
    this.menuTitle,
    this.onPress,
  }) : super(key: key);
  final IconData menuIcon;
  final String menuTitle;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize ?? 10;
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: defaultSize * 2, vertical: 20),
        child: SafeArea(
          child: Row(
            children: <Widget>[
              Icon(menuIcon,
                  size: defaultSize * 1.9,
                  color: Theme.of(context).iconTheme.color),
              SizedBox(width: defaultSize * 2),
              Text(menuTitle, style: Theme.of(context).textTheme.bodyText1),
              Spacer(),
              Icon(Icons.arrow_forward_ios,
                  size: defaultSize * 1.3,
                  color: Theme.of(context).iconTheme.color)
            ],
          ),
        ),
      ),
    );
  }
}
