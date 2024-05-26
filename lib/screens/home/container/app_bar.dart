import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:huxley/screens/home/container/user_circular_avatar_container.dart';

import '../../controller/controller/user_controller.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final UserController _userController = Get.find<UserController>();

  MyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppLocalizations.of(context)!.helloAppBarText,
                style: const TextStyle(color: Colors.grey, fontSize: 18)),
            Text(AppLocalizations.of(context)!.goodMorningAppBarText,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            Text(_userController.user.value?.displayName?.split(" ")[0] ?? "",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.search,
            size: 32,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(
            Icons.notifications,
            size: 32,
          ),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
        UserCircularAvatarContainer(
          photoURL: _userController.user.value?.photoURL,
        ),
        const SizedBox(width: 16),
      ],
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
