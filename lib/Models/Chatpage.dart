import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/Services/auth/AuthServices.dart';
import 'package:flutter_application_1/Services/auth/ChatServices.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;

  ChatPage({Key? key, required this.receiverEmail}) : super(key: key);

  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void sendMessage() {
    String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      _chatService.sendMessage(receiverEmail, messageText);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8FFC0CB),
      appBar: AppBar(
        title: Text(receiverEmail),
        backgroundColor: Colors.pink,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _chatService.getMessageStream(receiverEmail),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                List<DocumentSnapshot> messageDocs = snapshot.data!.docs;
                print('Message Docs: ${messageDocs.length}');
                return ListView.builder(
                  itemCount: messageDocs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data =
                        messageDocs[index].data() as Map<String, dynamic>;
                    print('Message Data: $data');

                    bool isSentByCurrentUser = data['senderEmail'] ==
                        _authService.getCurrentUser()?.email;
                    print('Is Sent By Current User: $isSentByCurrentUser');

                    Alignment alignment = isSentByCurrentUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft;
                    Color backgroundColor =
                        isSentByCurrentUser ? Colors.pink : Colors.white;

                    return Align(
                      alignment: alignment,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        margin:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['message'],
                              style: TextStyle(
                                fontSize: 16,
                                color: isSentByCurrentUser
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              data['senderEmail'],
                              style: TextStyle(
                                fontSize: 12,
                                color: isSentByCurrentUser
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: sendMessage,
                  icon: Icon(Icons.send),
                  color: Colors.pink,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
