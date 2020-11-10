import 'package:flutter/material.dart';
import 'package:myapp_core/common/colors.dart';

class MyAppSquareButton extends StatelessWidget {
  final Function onPress;
  final String buttonText;
  final double fontSize;
  final Color textColor;
  final Color buttonBorderColor;
  final Color buttonColor;
  final double buttonBorderRadius;
  final double height;
  final double buttonElevation;

  const MyAppSquareButton(
      {@required this.onPress,
      @required this.buttonText,
      Key key,
      this.fontSize = 14,
      this.textColor = ma_lightGrey1,
      this.buttonColor = Colors.white,
      this.buttonBorderColor = ma_lightGrey1,
      this.buttonBorderRadius = 3,
      this.height = 25.0,
      this.buttonElevation = 0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: RaisedButton(
        key: key,
        color: buttonColor,
        shape: RoundedRectangleBorder(side: BorderSide(
            color: buttonBorderColor,
            width: 0.5,
            style: BorderStyle.solid
          ), borderRadius: BorderRadius.circular(buttonBorderRadius)),
        onPressed: onPress,
        highlightElevation: 1,
        elevation: buttonElevation,
        child: Container(
          child: Text(buttonText,
              maxLines: 1,
              style: TextStyle(
                  fontSize: fontSize,
                  color: textColor,
                  fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}
