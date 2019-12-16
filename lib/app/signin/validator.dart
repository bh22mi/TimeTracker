abstract class StringValidator {
  bool isValid(String val);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String val) {
    return val.isNotEmpty;
  }
}

class EmailAndPasswordValidators {
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator pwdValidator = NonEmptyStringValidator();
  final String invalidEmailErrorText = 'Email can\'t be null';
  final String invalidPwdErrorText = 'Password can\'t be null';
}
