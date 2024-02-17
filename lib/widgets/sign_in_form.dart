import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pari_gsc/views/authentication_viewmodel.dart';
import 'package:pari_gsc/views/base_view.dart';
import '../models/user.dart';
import '../providers/login_form_provider.dart';
import '../providers/user_provider.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
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
                  "Sign In",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextFormField(
                    controller: emailController,
                    validator: AuthenticationViewModel.emailValidator,
                    decoration: const InputDecoration(hintText: "E-mail")),
                const SizedBox(height: 10),
                TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    validator: AuthenticationViewModel.passwordValidator,
                    decoration: const InputDecoration(hintText: "Password")),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: signInUser, child: const Text("Sign In")),
                const SizedBox(height: 20),
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    return TextButton(
                        onPressed: () => ref
                            .read(loginFormProvider.notifier)
                            .state = AuthFormState.register,
                        child:
                            const Text("Don't have an account? Sign up here"));
                  },
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Future<void> signInUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        var result = await AuthenticationViewModel.authenticateUser(
          authType: AuthType.login,
          email: emailController.text,
          password: passwordController.text,
        );

        if (result is UserClass && mounted) {
          print("User is logged in: ${result.uid}");

          UserClass user = UserClass(uid: result.uid);

          container.read(userProvider.notifier).state = user;

          print(container.read(userProvider));

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return BaseView();
              },
            ),
          );
        } else {
          print(result!.toString());

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result.toString())),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An error occurred: $e")),
        );
      }
    }
  }
}
