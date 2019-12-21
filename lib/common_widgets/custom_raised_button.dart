import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;

  const CustomRaisedButton(
      {Key key, this.color, this.textColor, this.child, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.06,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          color: color,
          onPressed: onPressed,
          child: child,
          disabledColor: color,
        ),
      ),
    );
  }
}
