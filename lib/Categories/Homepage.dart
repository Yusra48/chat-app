import 'package:flutter/material.dart';
import 'package:flutter_application_1/Categories/UserTile.dart';
import 'package:flutter_application_1/Models/Chatpage.dart';
import 'package:flutter_application_1/Services/auth/AuthServices.dart';
import 'package:flutter_application_1/Services/auth/ChatServices.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void logout(BuildContext context) async {
    try {
      await _authService.signOut();
      Navigator.of(context).pop();
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            color: const Color(0xFFFFF9C4),
            onPressed: () => logout(context),
          ),
        ],
        title: const Center(
          child: Text(
            'Home',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFF9C4),
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFE8FFC0CB),
      body: _buildUserList(context),
    );
  }

  Widget _buildUserList(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _chatService.getUsersStream(),
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final users = snapshot.data ?? [];
        final currentUserEmail = _authService.getCurrentUser()?.email ?? '';

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final userData = users[index];
            final userEmail = userData['email'] as String;

            if (userEmail != currentUserEmail) {
              return _buildUserListItem(context, userEmail);
            } else {
              return const SizedBox();
            }
          },
        );
      },
    );
  }

  Widget _buildUserListItem(BuildContext context, String userEmail) {
    return UserTile(
      text: userEmail,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(receiverEmail: userEmail),
          ),
        );
      },
    );
  }
}
