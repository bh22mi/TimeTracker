import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/services/auth.dart';
import 'package:time_tracker_flutter_course/app/signin/email_signin_form.dart';

class EmailSigninPage extends StatelessWidget {
  final AuthBase authBase;

  EmailSigninPage({@required this.authBase});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
              child: EmailSignInForm(
            authBase: authBase,
          )),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
