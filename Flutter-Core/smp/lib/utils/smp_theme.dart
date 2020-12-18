import 'package:flutter/material.dart';
import 'package:myapp_core/common/colors.dart';

ThemeData buildSmpTheme(final BuildContext context) {
  final theme = Theme.of(context);
  bool isDark = theme.brightness == Brightness.dark;

  return theme.copyWith(
      textTheme: Theme.of(context).textTheme.copyWith(
          headline3: TextStyle(
              color: ma_textDarkGrey,
              fontSize: 21,
              fontWeight: FontWeight.w400),
          subtitle1: TextStyle(
              color: ma_textLightGrey,
              fontSize: 14,
              fontWeight: FontWeight.w400),
          bodyText1: TextStyle(
              color: ma_textDarkGrey,
              fontSize: 16,
              fontWeight: FontWeight.w400)),
      backgroundColor: Colors.white,
      iconTheme: Theme.of(context).iconTheme.copyWith(color: ma_textDarkGrey),
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
          color: myPurple,
          // iconTheme:
          //     Theme.of(context).iconTheme.copyWith(color: myPurple, size: 14),
          textTheme: Theme.of(context).textTheme.copyWith(
                headline1: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
                headline2: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              )),
      floatingActionButtonTheme:
          Theme.of(context).floatingActionButtonTheme.copyWith()
      // buttonTheme: Theme.of(context).buttonTheme.copyWith(
      //       buttonColor: isDark ? Colors.black : Colors.white,
      //     ),
      );
}
