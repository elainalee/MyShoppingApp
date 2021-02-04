import 'package:flutter/material.dart';
import 'package:myapp_core/common/colors.dart';

ThemeData buildMyAppTheme(final BuildContext context) {
  final theme = Theme.of(context);
  bool isDark = theme.brightness == Brightness.dark;

  return theme.copyWith(
      primaryColor: myPurple,
      backgroundColor: Colors.white,
      textTheme: Theme.of(context).textTheme.copyWith(
          headline2: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w400),
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
              fontWeight: FontWeight.w400),
          bodyText2: TextStyle(
              color: ma_textDarkGrey,
              fontSize: 16,
              fontWeight: FontWeight.w400)),
      accentTextTheme: Theme.of(context).textTheme.copyWith(
          headline1: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400)),
      iconTheme: Theme.of(context).iconTheme.copyWith(color: ma_textDarkGrey),
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
          color: Colors.white,
          iconTheme: Theme.of(context)
              .iconTheme
              .copyWith(color: Colors.black, size: 18),
          textTheme: Theme.of(context).textTheme.copyWith(
                headline1: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
                headline2: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              )),
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
            buttonColor: isDark ? Colors.black : Colors.white,
          ),
      floatingActionButtonTheme: Theme.of(context)
          .floatingActionButtonTheme
          .copyWith(backgroundColor: myPurple, foregroundColor: Colors.white),
      cardColor: ma_lightGrey4
      // buttonTheme: Theme.of(context).buttonTheme.copyWith(
      //       buttonColor: isDark ? Colors.black : Colors.white,
      //     ),
      );
}
