import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/services/auth.dart';
import 'package:time_tracker_flutter_course/app/signin/validator.dart';
import 'package:time_tracker_flutter_course/common_widgets/form_submit_button.dart';

enum EmailSignInFormType { signin, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {
  final AuthBase authBase;

  EmailSignInForm({@required this.authBase});

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  String email;

  final TextEditingController emailEditingController =
      new TextEditingController();
  final TextEditingController pwdEditingController =
      new TextEditingController();
  final FocusNode _emailfocusNode = FocusNode();
  final FocusNode _pwdfocusNode = FocusNode();

  EmailSignInFormType _formType = EmailSignInFormType.signin;

  String get _email => emailEditingController.text;
  String get _pwd => pwdEditingController.text;
  bool _submitted = false;
  bool isLoading = false;

  void toggleForm() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.signin
          ? EmailSignInFormType.register
          : EmailSignInFormType.signin;
    });

    emailEditingController.clear();
    pwdEditingController.clear();
  }

  void submit() async {
    setState(() {
      _submitted = true;
      isLoading = true;
    });
    try {
      await Future.delayed(Duration(seconds: 3));
      if (_formType == EmailSignInFormType.signin) {
        await widget.authBase.signInWithEmailandPassword(_email, _pwd);
      } else {
        await widget.authBase.createUserWithEmailandPassword(_email, _pwd);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _emailEditingComplete() {
    final newFocus =
        widget.emailValidator.isValid(_email) ? _pwdfocusNode : _emailfocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  List<Widget> _buildChildren() {
    final primarytext =
        _formType == EmailSignInFormType.signin ? 'Sigin in' : 'Create account';
    final secondarytext = _formType == EmailSignInFormType.signin
        ? 'Need an account ? Register'
        : 'Have an account ? Sign in';

    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.pwdValidator.isValid(_pwd) &&
        !isLoading;

    Widget _buildEmailTextField() {
      bool showErrText = _submitted && !widget.emailValidator.isValid(_email);
      return TextField(
        enabled: isLoading == false,
        onEditingComplete: _emailEditingComplete,
        focusNode: _emailfocusNode,
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        controller: emailEditingController,
        onChanged: (email) => _updateState(),
        decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'test@test.com',
            errorText: showErrText ? widget.invalidEmailErrorText : null),
      );
    }

    Widget _buildPassTextField() {
      bool showErrText = _submitted && !widget.pwdValidator.isValid(_pwd);

      return TextField(
        enabled: isLoading == false,
        onChanged: (pwd) => _updateState(),
        onEditingComplete: submit,
        focusNode: _pwdfocusNode,
        textInputAction: TextInputAction.done,
        controller: pwdEditingController,
        obscureText: true,
        decoration: InputDecoration(
            labelText: 'Password',
            errorText: showErrText ? widget.invalidPwdErrorText : null),
      );
    }

    return [
      _buildEmailTextField(),
      SizedBox(
        height: 8,
      ),
      _buildPassTextField(),
      SizedBox(
        height: 20,
      ),
      FormSubmitButton(
        onPressed: submitEnabled ? submit : null,
        text: primarytext,
      ),
      SizedBox(
        height: 8,
      ),
      FlatButton(
        onPressed: !isLoading ? toggleForm : null,
        child: Text(secondarytext),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: _buildChildren()),
    );
  }

  _updateState() {
    print("update sta");
    setState(() {});
  }
}
