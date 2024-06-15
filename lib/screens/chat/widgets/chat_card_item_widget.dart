import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huxley/screens/chat/models/user/user_model.dart';

import '../pages/chat_page/main/chat_main.dart';

class ChatCardItem extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final int unreadCount;

  const ChatCardItem({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    this.unreadCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(name),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerLeft,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      secondaryBackground: Container(
        color: Colors.green,
        alignment: Alignment.centerRight,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Icon(Icons.archive, color: Colors.white),
        ),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          print('Deleted $name');
        } else if (direction == DismissDirection.endToStart) {
          print('Archived $name');
        }
      },
      child: InkWell(
        onTap: () => Get.to(()=> const ChatMain()),  // Use the provided onTap function here
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: Text(name.substring(0, 1)),
          ),
          title: Text(name),
          subtitle: Text(message),
          trailing: SizedBox(
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                if (unreadCount > 0)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text('$unreadCount', style: const TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
