import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/chat_card_item_widget.dart';

class ChatListContainer extends StatefulWidget {
  const ChatListContainer({super.key});

  @override
  State<ChatListContainer> createState() => _ChatListContainerState();
}

class _ChatListContainerState extends State<ChatListContainer> {
  late StreamController<List<Map<String, dynamic>>> chatStreamController;
  List<Map<String, dynamic>> chatItems = [
    {
      'name': 'New Contact',
      'message': 'Hey there! I\'m new here.',
      'time': 'Now',
      'unreadCount': 0,
    }
  ];

  @override
  void initState() {
    super.initState();
    chatStreamController = StreamController<List<Map<String, dynamic>>>();
    chatStreamController.add(chatItems); // Initialize stream with current items
  }

  @override
  void dispose() {
    chatStreamController.close(); // Always close controllers when no longer needed
    super.dispose();
  }

  Future<void> refreshChatList() async {
    await Future.delayed(const Duration(seconds: 2));
    chatItems.add({
      'name': 'New Contact',
      'message': 'Hey there! I\'m new here.',
      'time': 'Now',
      'unreadCount': 0,
    });
    chatStreamController.add(chatItems); // Add updated list to the stream
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        displacement: 80,
        onRefresh: refreshChatList,
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: chatStreamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0), // Ensure it's noticeable
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, color: Colors.red, size: 40),
                      SizedBox(height: 20),
                      Text(
                        "Failed to fetch chats. Please swipe Up to refresh.",
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No chat items available.'));
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return ChatCardItem(
                  name: item['name'],
                  message: item['message'],
                  time: item['time'],
                  unreadCount: item['unreadCount'],
                  onTap: () => print("Tapped on item ${item['name']}, ${index}"),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
