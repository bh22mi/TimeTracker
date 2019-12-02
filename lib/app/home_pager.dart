import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/services/auth.dart';

class HomePage extends StatelessWidget {
  final AuthBase auth;

  HomePage({@required this.auth});

  Future<void> _signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
        actions: <Widget>[
          FlatButton(
            onPressed: _signOut,
            child: Icon(
              Icons.subdirectory_arrow_right,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
