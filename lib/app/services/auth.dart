import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User {
  final String uid;

  User({@required this.uid});
}

abstract class AuthBase {
  Stream<User> get onAuthStateChanged;
  Future<User> currentUser();
  Future<User> signInAnonymously();
  Future<void> signOut();
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  User _userfromfirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }

    return User(uid: user.uid);
  }

  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userfromfirebase);
  }

  @override
  Future<User> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return _userfromfirebase(user);
  }

  @override
  Future<User> signInAnonymously() async {
    final authresult = await _firebaseAuth.signInAnonymously();
    final user = authresult.user;
    return _userfromfirebase(user);
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final signinaccount = await googleSignIn.signIn();

    if (signinaccount != null) {
      final auth = await signinaccount.authentication;
      if (auth.accessToken != null && auth.idToken != null) {
        final authresult = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.getCredential(
                idToken: auth.idToken, accessToken: auth.accessToken));
        final user = authresult.user;

        return _userfromfirebase(user);
      } else {
        throw PlatformException(
            code: 'MISSING_ACCESS_TOKEN', message: 'Missing google auth token');
      }
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Signin aborted by user');
    }
  }

  @override
  Future<User> signInWithFacebook() async {
    final facebooklogin = FacebookLogin();
    final result = await facebooklogin.logInWithReadPermissions(
      ['public_profile'],
    );
    if (result.accessToken != null) {
      final authResult = await _firebaseAuth.signInWithCredential(
        FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token),
      );
      return _userfromfirebase(authResult.user);
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Signin aborted by user');
    }
  }

  @override
  Future<void> signOut() async {
    final googleSignin = GoogleSignIn();
    googleSignin.signOut();

    final facebooklogin = FacebookLogin();
    facebooklogin.logOut();

    await _firebaseAuth.signOut();
  }
}
