import 'package:flutter/material.dart';

import 'package:pari_gsc/views/chat_room.dart';

class ChatTile extends StatelessWidget {
  const ChatTile(
      {super.key, required this.postId, required this.title, this.desc});

  final String postId;
  final String title;
  final String? desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChatRoom(postId: postId),
        )),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(colors: [
                Colors.deepPurple.shade300,
                Colors.deepPurple.shade400,
              ])),
          width: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                desc != null
                    ? Text(
                        desc!,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
