import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/authentication.dart';

enum AuthType { login, register }

final class AuthenticationViewModel {
  static Future authenticateUser({
    required AuthType authType,
    required String email,
    required String password,
    String? country,
    String? name,
    String? surname,
  }) async {
    try {
      Auth auth = Auth();
      var result;

      if (authType == AuthType.login) {
        result = await auth.signInUser(email: email, password: password);
      } else if (authType == AuthType.register) {
        result = await auth.signUpUser(
            email: email,
            password: password,
            country: country!,
            name: name!,
            surname: surname!);
        print(result);
      }
      return result;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<void> signOutUser() async {
    Auth auth = Auth();
    await auth.logoutUser();
  }

  static String? passwordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null;
  }

  static String? emailValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter e-mail address';
    }

    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return "Invalid e-mail";
    }
    return null;
  }
}
