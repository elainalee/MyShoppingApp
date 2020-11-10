
import 'package:flutter/material.dart';

ThemeData buildLdpTheme(final BuildContext context) {
  final theme = Theme.of(context);
  bool isDark = theme.brightness == Brightness.dark;

  return theme.copyWith(
    textTheme: Theme.of(context).textTheme.copyWith(
      headline2: TextStyle(
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.w400
      ),
      subtitle1: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w300
      ),
      bodyText1: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w400
      )
    ),
    backgroundColor: Colors.white,
    buttonTheme: Theme.of(context).buttonTheme.copyWith(
      buttonColor: isDark ? Colors.black : Colors.white,
    )
  );
}