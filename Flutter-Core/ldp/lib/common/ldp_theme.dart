import 'package:flutter/material.dart';
import 'package:myapp_core/common/colors.dart';

ThemeData buildLdpTheme(final BuildContext context) {
  final theme = Theme.of(context);
  bool isDark = theme.brightness == Brightness.dark;

  return theme.copyWith(
    textTheme: Theme.of(context).textTheme.copyWith(
        headline2: TextStyle(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.w400),
        subtitle1: TextStyle(
            color: Colors.black, fontSize: 17, fontWeight: FontWeight.w400),
        subtitle2: TextStyle(
            color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
        bodyText1: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
        bodyText2: TextStyle(color: Colors.black, fontSize: 15)),
    backgroundColor: Colors.white,
    appBarTheme: Theme.of(context).appBarTheme.copyWith(
        color: Colors.white,
        iconTheme:
            Theme.of(context).iconTheme.copyWith(color: myPurple, size: 14),
        textTheme: Theme.of(context).textTheme.copyWith(
              headline1: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            )),
    buttonTheme: Theme.of(context).buttonTheme.copyWith(
          buttonColor: isDark ? Colors.black : Colors.white,
        ),
  );
}
