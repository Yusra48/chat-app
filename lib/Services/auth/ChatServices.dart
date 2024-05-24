import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Models/message.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendMessage(String receiverID, String messageText) async {
    try {
      String currentUserID = _auth.currentUser!.uid;
      final currentUserEmail = _auth.currentUser!.email!;
      final Timestamp timestamp = Timestamp.now();

      Message newMessage = Message(
        senderID: currentUserID,
        senderEmail: currentUserEmail,
        receiverID: receiverID,
        message: messageText,
        timestamp: timestamp,
      );

      String chatRoomID = _getChatRoomID(currentUserID, receiverID);

      // Add message to the chat room's messages collection
      await _firestore
          .collection('Users')
          .doc(chatRoomID)
          .collection('messages')
          .add(newMessage.toMap());
    } catch (e) {
      print('Error sending message: $e');
      throw Exception('Failed to send message.');
    }
  }

  Stream<QuerySnapshot> getMessageStream(String otherUserID) {
    String currentUserID = _auth.currentUser!.uid;
    String chatRoomID = _getChatRoomID(currentUserID, otherUserID);

    // Retrieve messages for the chat room ordered by timestamp
    return _firestore
        .collection('Users')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  String _getChatRoomID(String userID1, String userID2) {
    // Create a unique chat room ID by sorting and concatenating user IDs
    List<String> ids = [userID1, userID2];
    ids.sort();
    return ids.join();
  }

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    // Stream of users from the 'Users' collection
    return _firestore.collection('Users').snapshots().map((querySnapshot) {
      List<Map<String, dynamic>> users = [];
      querySnapshot.docs.forEach((doc) {
        users.add(doc.data() as Map<String, dynamic>);
      });
      return users;
    });
  }
}
