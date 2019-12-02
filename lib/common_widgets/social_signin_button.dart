import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/custom_raised_button.dart';

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton(
      {@required String text,
      Color color,
      Color textColor,
      @required String image,
      VoidCallback onPressed})
      : assert(text != null),
        assert(image != null),
        super(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset(image),
                  Text(
                    text,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  Opacity(opacity: 0.0, child: Image.asset(image)),
                ]),
            color: color,
            onPressed: onPressed);
}
