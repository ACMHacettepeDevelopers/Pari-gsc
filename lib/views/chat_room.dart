import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/chat_service.dart';

class ChatRoom extends ConsumerStatefulWidget {
  const ChatRoom({super.key, required this.postId});
  final String postId;
  @override
  ConsumerState<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends ConsumerState<ChatRoom> {
  List<types.Message> _messages = [];
  final _chatUser = types.User(
    id: "TRdkT3Kh3Egh3rNf9E5FNWXEgnb2",
    firstName: "Orhun İnan",
  );

  ChatServiceImpl? _chatService;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _chatService = ref.watch(chatServiceProvider);
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: _chatService!.messagesStream("8VvQ1uEHM0QlSZM9hTrM"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<QueryDocumentSnapshot> messages = snapshot.data!.docs;
              List<types.Message> tempList = [];

              for (QueryDocumentSnapshot messageSnap in messages) {
                types.TextMessage message = types.TextMessage.fromJson(
                    messageSnap.data() as Map<String, dynamic>);
                tempList.add(message);
              }

              _messages = tempList;

              return Chat(
                theme: DefaultChatTheme(primaryColor: Colors.blue.shade300),
                showUserAvatars: true,
                showUserNames: true,
                messages: _messages,
                onMessageLongPress: _handleMessageLongPress,
                onSendPressed: _handleSendPressed,
                user: _chatUser,
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));

    return base64UrlEncode(values);
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  Future<void> _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _chatUser,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );
    await _chatService!.addMessageToDb(
        token: "", postId: widget.postId, textMessage: textMessage);

    _addMessage(textMessage);
  }

  void _handleMessageLongPress(BuildContext context, types.Message p1) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextButton(
            onPressed: () {
              final controller = TextEditingController();
              Navigator.of(context).pop();
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: TextField(
                      controller: controller,
                      decoration:
                          const InputDecoration(hintText: "Report Reason")),
                  actions: [
                    TextButton(
                        onPressed: () {
                          reportMessage(
                            reason: controller.text,
                            uid: p1.id,
                            name: p1.author.firstName!,
                          );
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Report Sent")));
                        },
                        child: const Text("Submit Report"))
                  ],
                ),
              );
            },
            child: const Text("Report")),
      ),
    );
  }

  void reportMessage({
    required String reason,
    required String uid,
    required String name,
  }) {
    FirebaseFirestore.instance.collection("Reports").add({
      "reason": reason,
      "reportedUID": uid,
      "reportedName": name,
      "reporterUID": FirebaseAuth.instance.currentUser!.uid
    });
  }
}
