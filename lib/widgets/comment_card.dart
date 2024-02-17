import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pari_gsc/models/comment_model.dart';
import 'package:pari_gsc/models/user.dart';
import 'package:pari_gsc/providers/user_provider.dart';
import 'package:pari_gsc/services/comment_service.dart';

class CommentCard extends StatelessWidget {
  final CommentModel comment;

  CommentCard({required this.comment});

  @override
  Widget build(BuildContext context) {
    CommentService commentService = CommentService();

    final now = comment.timestamp;
    final formattedDate = DateFormat.yMMMd().format(now);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer(builder: (_, WidgetRef ref, __) {
        UserClass? user = container.read(userProvider);

        return Card(
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          //backgroundImage: NetworkImage(comment.profilePicUrl),
                          radius: 20,
                          child: Icon(Icons.person),
                        ),
                        SizedBox(width: 8),
                        Text(
                          comment.username,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.60,
                        ),
                        child: Text(
                          comment.content,
                          style: TextStyle(fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 10,
                        ),
                      ),
                    ),
                    Text(
                      formattedDate,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                if (comment.UID ==
                    user!.uid) // Check if the user matches the comment owner

                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Confirm Deletion"),
                            content: Text(
                                "Are you sure you want to delete this comment?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  commentService.deleteComment(
                                      comment.postID, comment.commentID);
                                },
                                child: Text("Yes"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("No"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.remove_circle_outline),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
