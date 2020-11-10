import 'package:flutter/material.dart';

class MyAppRoundButton extends StatelessWidget {
  final Function onPress;
  final String buttonText;
  final double fontSize;
  final Color textColor;
  final Color buttonColor;
  final double height;

  const MyAppRoundButton(
      {@required this.onPress,
      @required this.buttonText,
      Key key,
      this.fontSize = 14,
      this.textColor = Colors.black,
      this.buttonColor = Colors.white,
      this.height = 36.0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: RaisedButton(
        key: key,
        color: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        onPressed: onPress,
        highlightElevation: 0,
        elevation: 1,
        child: Container(
          child: Text(buttonText,
              maxLines: 1,
              style: TextStyle(
                  fontSize: 12,
                  color: textColor,
                  fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}
