import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/services/auth.dart';
import 'package:time_tracker_flutter_course/app/signin/enail_signin_page.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/common_widgets/signin_button.dart';
import 'package:time_tracker_flutter_course/common_widgets/social_signin_button.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;

  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Sign in failed',
      exception: exception,
    ).show(context);
  }

  Future<void> _signinAnonumously() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final auth = Provider.of<AuthBase>(context);

      await auth.signInAnonymously();
      setState(() {
        _isLoading = false;
      });
    } on PlatformException catch (e) {
      _showSignInError(context, e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signinWithGoogle() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final auth = Provider.of<AuthBase>(context);

      await auth.signInWithGoogle();
      setState(() {
        _isLoading = false;
      });
    } on PlatformException catch (e) {
      print(e.code + "... dett...." + e.details);

      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      } else {
        print(e.code);
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signinWithFacebook() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final auth = Provider.of<AuthBase>(context);

      await auth.signInWithFacebook();
      setState(() {
        _isLoading = false;
      });
    } on PlatformException catch (e) {
      _showSignInError(context, e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _signinWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
        fullscreenDialog: true, builder: (context) => EmailSigninPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 0.0,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(),
          SizedBox(
            height: 48.0,
          ),
          SocialSignInButton(
            onPressed: _isLoading ? null : _signinWithGoogle,
            color: Colors.white,
            text: 'Sigin in with Google',
            image: 'images/google-logo.png',
            textColor: Colors.black,
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            onPressed: _isLoading ? null : _signinWithFacebook,
            color: Color(0xFF334D92),
            text: 'Sigin in with Facebook',
            textColor: Colors.white,
            image: 'images/facebook-logo.png',
          ),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
            onPressed: () => _isLoading ? null : _signinWithEmail(context),
            color: Colors.red[700],
            text: 'Sigin in with Email',
            textColor: Colors.white,
          ),
          SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'OR',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.0, color: Colors.black),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          SignInButton(
            onPressed: _isLoading ? null : _signinAnonumously,
            color: Colors.yellow[800],
            text: 'Go Anonymous',
            textColor: Colors.white,
          )
        ],
      ),
    );
  }

  Widget buildHeader() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        'Sign in',
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headline
            .copyWith(fontWeight: FontWeight.w600, fontSize: 32),
      ),
    );
  }
}
