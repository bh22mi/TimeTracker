import 'package:time_tracker_flutter_course/common_widgets/custom_raised_button.dart';
import 'package:flutter/material.dart';

class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton({
    String text,
    VoidCallback onPressed,
  }) : super(
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            textColor: Colors.white,
            onPressed: onPressed,
            color: Colors.red);
}
