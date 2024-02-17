import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserClass? _userFromFirebaseUser(User? user) {
    return user != null ? UserClass(uid: user.uid) : null;
  }

  Future signUpUser({
    required String email,
    required String password,
    required String name,
    required String surname,
    required String country,
  }) async {
    final String apiUrl = "https://createnewuser-mmnpyehg3a-ew.a.run.app/";

    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      FirebaseAuth.instance.currentUser!.updateDisplayName("$name $surname");

      if (user != null) {
        String uid = user.uid;

        final response = await http.post(
          Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'UID': uid,
            'email': email,
            'username': ("$name $surname"),
            'firstName': name,
            'lastName': surname,
            'country': country,
          }),
        );

        if (response.statusCode != 200) {
          await user.delete();
          return "error while adding user in database";
        } else {
          return _userFromFirebaseUser(user);
        }
      } else {
        return "firebase user cannot be created";
      }

      /*final data = jsonDecode(response.body);
      final uid = data['uid'];*/
    } catch (e) {
      return "error while signing in";
    }
  }

  Future signInUser({required String email, required String password}) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserClass user = UserClass(uid: userCredential.user!.uid);
      return user;
      ;
    } catch (e) {
      print('Error signing in: $e');
      return 'Error signing in: $e';
    }
  }

  Future<void> logoutUser() async {
    await _auth.signOut();
  }
}
