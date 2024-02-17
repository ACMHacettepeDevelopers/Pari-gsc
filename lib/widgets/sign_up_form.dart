import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pari_gsc/models/user.dart';
import 'package:pari_gsc/views/authentication_viewmodel.dart';
import 'package:pari_gsc/views/base_view.dart';
import '../providers/login_form_provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  late String? selectedCountry = " ";
  TextEditingController countryController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    countryController.dispose();
    nameController.dispose();
    surnameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign Up",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                            validator: TextFieldValidator,
                            controller: nameController,
                            decoration:
                                const InputDecoration(hintText: "Name"))),
                    const SizedBox(width: 10),
                    Expanded(
                        child: TextFormField(
                            validator: TextFieldValidator,
                            controller: surnameController,
                            decoration:
                                const InputDecoration(hintText: "Surname"))),
                    const SizedBox(height: 10),
                  ],
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 10),
                TextFormField(
                    controller: emailController,
                    validator: emailValidator,
                    decoration: const InputDecoration(
                      hintText: "example@gmail.com",
                      helperText: "Enter your email",
                    )),
                const SizedBox(height: 10),
                TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    validator: passwordValidator,
                    decoration: const InputDecoration(hintText: "Password")),
                const SizedBox(height: 10),
                TextFormField(
                    obscureText: true,
                    validator: passwordValidator,
                    decoration: const InputDecoration(
                        hintText: "Enter the Password Again")),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: signUpUser, child: const Text("Sign Up")),
                const SizedBox(height: 20),
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    return TextButton(
                      onPressed: () => {
                        ref.read(loginFormProvider.notifier).state =
                            AuthFormState.login,
                      },
                      child: const Text("Have an account? Sign in here"),
                    );
                  },
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Future<void> signUpUser() async {
    if (_formKey.currentState!.validate()) {
      var result = await AuthenticationViewModel.authenticateUser(
        authType: AuthType.register,
        email: emailController.text,
        password: passwordController.text,
        country: selectedCountry!,
        name: nameController.text,
        surname: surnameController.text,
      );
      if (result != null && mounted) {
        UserClass newUser =
            UserClass(uid: FirebaseAuth.instance.currentUser!.uid);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BaseView()),
        );
      } else {
        print(result!.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result!.toString())));
      }
    }
  }

  String? TextFieldValidator(value) {
    if (value == null || value.isEmpty) {
      return 'This field is mandatory';
    }
    return null;
  }

  String? passwordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters long";
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? emailValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter e-mail address';
    }

    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@hacettepe\.edu\.tr$")
        .hasMatch(value)) {
      return "Invalid e-mail";
    }
    return null;
  }
}
