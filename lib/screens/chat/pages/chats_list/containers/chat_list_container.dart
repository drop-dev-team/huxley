import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,  // Ensures all children are centered in the stack
                        children: [
                          Icon(FontAwesomeIcons.cloud, color: Colors.black38, size: 40),
                          Align(
                            alignment: Alignment.center,  // Ensures this icon is centered on the cloud icon
                            child: Icon(FontAwesomeIcons.exclamation, color: Colors.white, size: 25),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        // todo int (.arb files text and reference to app_localizations.dart file)
                        "Failed to fetch chats. Please pull down to refresh.",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
