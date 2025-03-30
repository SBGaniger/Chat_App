import 'package:chat_app/components/my_drawer.dart';
import 'package:flutter/material.dart';
import '../authonication/auth_service.dart';
import '../components/user_tile.dart';
import '../services/chat/chat_service.dart';
import 'chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // Get current user ID
  String? get currentUserId {
    return _authService.getCurrentUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  // Build a list of users except for the current logged-in user.
  Widget _buildUserList() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _chatService.getUsersStream(), // Ensure correct function name
      builder: (context, snapshot) {
        // Handle error
        if (snapshot.hasError) {
          return const Center(child: Text("Error loading users"));
        }

        // Show loading indicator
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // If no users are found
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No users found"));
        }

        // Return ListView with user data, filtering out the current user
        return ListView(
          children: snapshot.data!
              .where((userData) => userData['uid'] != currentUserId)
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  // Build individual list tile for user
  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    return UserTile(
      text: userData['email'],
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              receiverEmail: userData['email'],
              receiverID: userData['uid'],
            ),
          ),
        );
      },
    );
  }
}
