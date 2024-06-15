import 'package:flutter/material.dart';
import '../../../managers/chat/chats_manager.dart';
import '../../../widgets/chat_card_item_widget.dart';

class ChatListContainer extends StatefulWidget {
  const ChatListContainer({super.key});

  @override
  State<ChatListContainer> createState() => _ChatListContainerState();
}

class _ChatListContainerState extends State<ChatListContainer> {
  late Future<List<ChatCardItem>> chatItemsFuture;

  @override
  void initState() {
    super.initState();
    chatItemsFuture = ChatsManager().getUserChats(); // Fetch chats on initialization
  }

  Future<void> refreshChatList() async {
    setState(() {
      chatItemsFuture = ChatsManager().getUserChats(); // Refresh the chat list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refreshChatList,
        child: FutureBuilder<List<ChatCardItem>>(
          future: chatItemsFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("Error: ${snapshot.error}");
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, color: Colors.red, size: 40),
                      SizedBox(height: 20),
                      Text(
                        "Failed to fetch chats. Please pull down to refresh.",
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return snapshot.data![index];  // Assuming ChatCardItem is a Widget
              },
            );
          },
        ),
      ),
    );
  }
}
