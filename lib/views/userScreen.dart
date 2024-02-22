import "dart:convert";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import "package:pari_gsc/views/authentication_screen.dart";

class UserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final Map userDetails = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Card(
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Name:"),
                                Text(userDetails["firstName"]),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Surname:"),
                                Text(userDetails["lastName"]),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Country:"),
                                Text(userDetails["country"]),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Email:"),
                                Text(userDetails["email"]),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const AuthenticationScreen(),
                        ));
                      },
                      child: const Text("Log Out")),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red.shade300),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                                "Are you sure you want to delete your account?"),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    try {
                                      await FirebaseAuth.instance.currentUser!
                                          .delete()
                                          .then((value) =>
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text(
                                                  "User deleted.",
                                                ),
                                                duration: Duration(seconds: 5),
                                              )));
                                      Navigator.pop(context);

                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                        builder: (context) =>
                                            AuthenticationScreen(),
                                      ));
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "You need to log out and sign in again to delete your account")));
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text("Yes"),
                                  style: TextButton.styleFrom(
                                      foregroundColor: Colors.red.shade300)),
                              TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text("No"))
                            ],
                          ),
                        );
                      },
                      child: const Text("Delete Account")),
                ],
              ),
            );
          }
          return const CircularProgressIndicator();
        });
  }

  Future<Map<String, dynamic>> getUserDetails() async {
    // Dummy data for testing
    return {
      "firstName": "John",
      "lastName": "Doe",
      "country": "USA",
      "email": "john.doe@example.com",
    };
  }
}
