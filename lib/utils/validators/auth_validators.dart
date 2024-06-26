import 'package:thesimpsons/constants/text_constants.dart';

class AuthValidators {

  static const String emailErrMsg =
      TextConstants.invalidEmail;
  static const String passwordErrMsg =
      TextConstants.passwordChars;

  String? emailValidator(String? val) {
    final String email = val as String;

    // Email uzunluğu <=6 ise geçersizdir
    if (email.length <= 6) return emailErrMsg;

    // @ olup olmadığını kontrol eder
    final hasAtSymbol = email.contains('@');
    // @ nerede kontrol eder
    final indexOfAt = email.indexOf('@');
    // @ sayısını kontrol eder
    final numbersOfAt = "@".allMatches(email).length;

    if (!hasAtSymbol) return emailErrMsg;

    if (numbersOfAt != 1) return emailErrMsg;

    if (indexOfAt == 0 || indexOfAt == email.length - 1) return emailErrMsg;

    return null;
  }

  // Password validator
  String? passwordValidator(String? val) {
    final String password = val as String;

    if (password.isEmpty || password.length <= 5) return passwordErrMsg;

    return null;
  }

}