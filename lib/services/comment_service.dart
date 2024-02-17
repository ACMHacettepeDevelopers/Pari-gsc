import 'package:http/http.dart' as http;
import 'dart:convert';

class CommentService {
  Future<void> addComment(String uid, String postID, String comment) async {
    try {
      final Uri apiUrl =
          Uri.parse("https://addcomment-mmnpyehg3a-ew.a.run.app");

      final Map<String, dynamic> requestBody = {
        "UID": uid,
        "postID": postID,
        "comment": comment
      };

      final String requestBodyJson = jsonEncode(requestBody);

      final response = await http.post(apiUrl, body: requestBodyJson, headers: {
        "Content-Type": "application/json",
      });

      if (response.statusCode == 200) {
        print('Comment successfully created: ${response.body}');
      } else {
        print('Failed to create comment: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating comment: $e');
    }
  }

  Future<void> deleteComment(String commentID, String postID) async {
    try {
      final Uri apiUrl =
          Uri.parse("https://deletecommentfrompost-mmnpyehg3a-ew.a.run.app");

      final Map<String, String> requestBody = {
        'postID': commentID,
        'commentID': postID,
      };

      final response = await http.post(
        apiUrl,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        print('Comment successfully deleted: ${response.body}');
      } else {
        print('Failed to delete comment: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting comment: $e');
    }
  }
}
