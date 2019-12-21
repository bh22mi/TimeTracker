import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/services/auth.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_alert_dialog.dart';

class HomePage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignout(BuildContext context) async {
    final didiReqestSignOut = await PlatformAlertDialog(
      defaultActionText: 'OK',
      cancelActionText: 'Cancel',
      title: 'Logout',
      content: 'Are you sure that you want to Logout?',
    ).show(context);
    if (didiReqestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => _confirmSignout(context),
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
