import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:pari_gsc/widgets/chat_tile.dart";
import "package:pari_gsc/widgets/disclaimer.dart";
import "chat_room.dart";
import 'package:pari_gsc/utils/chat_dislaimer.dart';

class ChatView extends StatefulWidget {
  @override
  State<ChatView> createState() => _ChatState();
}

class _ChatState extends State<ChatView> {
  String? guidelineRead;
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((prefs) => {
          setState(() {
            guidelineRead = prefs.getString("guidelineRead");
            if (guidelineRead == null) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => AlertDialog(
                  content: const Disclaimer(),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          await prefs.setString("guidelineRead", "true");
                          Navigator.of(context).pop();
                        },
                        child: const Text("I agree"))
                  ],
                ),
              );
            }
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          ChatTile(
            postId: "8VvQ1uEHM0QlSZM9hTrM",
            title: "General",
            desc: "Chat with all international students",
          ),
        ],
      ),
    );
  }
}
