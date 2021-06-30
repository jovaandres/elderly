import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMyChat;

  MessageBubble(
      {required this.sender, required this.text, required this.isMyChat});

  final senderBorderRadius = BorderRadius.only(
    topRight: Radius.circular(20),
    bottomLeft: Radius.circular(20),
    topLeft: Radius.circular(20),
  );

  final otherBorderRadius = BorderRadius.only(
    topRight: Radius.circular(20),
    topLeft: Radius.circular(20),
    bottomRight: Radius.circular(20),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMyChat ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            color: isMyChat ? Colors.lightBlueAccent : Colors.white,
            borderRadius: isMyChat ? senderBorderRadius : otherBorderRadius,
            elevation: 5.0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Linkify(
                text: text,
                style: TextStyle(
                  color: isMyChat ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
                onOpen: (link) async {
                  String url = link.url;
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch ${link.url}';
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
