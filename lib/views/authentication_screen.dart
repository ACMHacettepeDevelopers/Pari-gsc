import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/login_form_provider.dart';
import '../widgets/sign_in_form.dart';
import '../widgets/sign_up_form.dart';

class AuthenticationScreen extends ConsumerStatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  ConsumerState<AuthenticationScreen> createState() =>
      _AuthenticationScreenState();
}

class _AuthenticationScreenState extends ConsumerState<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    final authFormState = ref.watch(loginFormProvider);
    return Scaffold(
        body: AnimatedSwitcher(
            transitionBuilder: (child, animation) {
              return SlideTransition(
                position: Tween(begin: const Offset(1, 0), end: Offset.zero)
                    .animate(CurvedAnimation(
                        parent: animation, curve: Curves.easeInOutQuart)),
                child: child,
              );
            },
            duration: const Duration(milliseconds: 500),
            child: Container(
              key: ValueKey(authFormState),
              child: authFormState == AuthFormState.login
                  ? const SignInForm()
                  : const SignUpForm(),
            )));
  }
}
