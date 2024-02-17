import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pari_gsc/models/comment_model.dart';
import 'package:pari_gsc/providers/user_provider.dart';
import 'package:pari_gsc/services/comment_service.dart';
import 'package:pari_gsc/widgets/comment_card.dart';

List<CommentModel> getDummyComments(String postID) {
  return [
    CommentModel(
      commentID: "1",
      postID: postID,
      username: "John Doe",
      timestamp: DateTime.now().subtract(Duration(days: 1)),
      content: "Amazing product, highly recommended!",
      UID: "user123",
    ),
    CommentModel(
      commentID: "2",
      postID: postID,
      username: "Jane Smith",
      timestamp: DateTime.now().subtract(Duration(hours: 2)),
      content: "Does it come in black?",
      UID: "user456",
    ),
    // Add more comments as needed
  ];
}

class CommentView extends StatefulWidget {
  final List<CommentModel> postcomments;
  final String postID;

  CommentView({required this.postID, required this.postcomments});

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  CommentService commentService = CommentService();
  var _commentsStreamController =
      StreamController<List<CommentModel>>.broadcast();
  late List<CommentModel> comments;

  @override
  void initState() {
    super.initState();
    comments = widget.postcomments;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void _showCommentBottomSheet(BuildContext context, String postID) {
    TextEditingController commentController = TextEditingController();

    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'COMMENTS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: comments.length,
                    itemBuilder: (_, index) {
                      return CommentCard(comment: comments[index]);
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          controller: commentController,
                          decoration: InputDecoration(
                            hintText: 'Write your comment here...',
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        if (commentController.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Error!"),
                                content: Text(
                                    "Please enter some content before proceeding."),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          String commentText = commentController.text;
                          commentController.clear();
                          commentService.addComment(
                            container.read(userProvider)!.uid,
                            postID,
                            commentText,
                          );
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
