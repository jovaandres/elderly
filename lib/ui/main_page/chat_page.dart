import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workout_flutter/main.dart';
import 'package:workout_flutter/widget/message_bubble.dart';

class ChatPage extends StatefulWidget {
  static const routeName = '/chat_page';

  @override
  State<StatefulWidget> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final _messageTextController = TextEditingController();
  late User _activeUser;

  final _firestore = FirebaseFirestore.instance;

  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() {
    try {
      var currentuser = auth.currentUser;

      if (currentuser != null) {
        _activeUser = currentuser;
      }
    } catch (e) {
      print(e);
    }
  }

  void dispose() {
    super.dispose();
    _messageTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community Chat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('community_chat_id_bi13rb8')
                    .orderBy('dateCreated', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    final messages =
                        snapshot.data?.docs as List<QueryDocumentSnapshot>;
                    List<MessageBubble> messageBubbles = [];
                    for (var message in messages) {
                      final messageText = message.data()?['text'];
                      final messageSender = message.data()?['sender'];
                      final senderEmail = message.data()?['email'];

                      final messageBubble = MessageBubble(
                        sender: messageSender,
                        text: messageText,
                        isMyChat: _activeUser.email == senderEmail,
                      );
                      messageBubbles.add(messageBubble);
                    }
                    return ListView(
                      reverse: true,
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      children: messageBubbles,
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageTextController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  child: Icon(Icons.send),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                  onPressed: () {
                    _firestore.collection('community_chat_id_bi13rb8').add({
                      'sender': userData?.name,
                      'text': _messageTextController.text,
                      'email': _activeUser.email,
                      'dateCreated': Timestamp.now()
                    });
                    _messageTextController.clear();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
