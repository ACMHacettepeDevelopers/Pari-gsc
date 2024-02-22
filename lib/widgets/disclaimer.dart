import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pari_gsc/utils/chat_dislaimer.dart';

class Disclaimer extends StatelessWidget {
  const Disclaimer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.warning_amber),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text.rich(TextSpan(
            text: "By using this chat app, you agree to abide by these ",
            children: [
              TextSpan(
                  text: "general rules and guidelines.",
                  style: TextStyle(decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => showDialog(
                          context: context,
                          builder: (context) =>
                              AlertDialog(content: Text(disclaimer)),
                        ))
            ])),
      ),
    ]);
  }
}
