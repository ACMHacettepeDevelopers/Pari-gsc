import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final chatServiceProvider = Provider((ref) => ChatServiceImpl());

abstract class ChatService {
  Stream messagesStream(String postId);

  Future<void> addMessageToDb(
      {required String token,
      required String postId,
      required TextMessage textMessage});
}

class ChatServiceImpl extends ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream messagesStream(String postId) => _firestore
      .collection("ChatRooms")
      .doc(postId)
      .collection("Messages")
      .orderBy("createdAt", descending: true)
      .snapshots();

  @override
  Future<void> addMessageToDb(
      {required String token,
      required String postId,
      required TextMessage textMessage}) async {
    try {
      /*final Uri apiUrl = Uri.parse(
          "https://us-central1-pari-gsc.cloudfunctions.net/addMessage");

      final Map<String, dynamic> requestBody = {
        "token": "", // doesn't need a real token for now.
        'postId': postId,
        'message': jsonEncode(textMessage.toJson()),
      };

      final response = await http.post(apiUrl, body: requestBody);

      debugPrint(" ${jsonEncode(textMessage.toJson())} ");


      if (response.statusCode == 200) {
        print('Comment successfully deleted: ${response.body}');
      } else {
        print('Failed to add message: ${response.statusCode}');
      }*/
      await _firestore
          .collection("ChatRooms")
          .doc(postId)
          .collection("Messages")
          .add(textMessage.toJson());
    } catch (e) {
      debugPrint('Error adding message: $e');
    }
  }
}
