import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String username;
  final DateTime timestamp;
  final String content;
  final String postID;
  final String commentID;
  final String UID;

  CommentModel({
    required this.commentID,
    required this.postID,
    required this.username,
    required this.timestamp,
    required this.content,
    required this.UID,
  });
}
