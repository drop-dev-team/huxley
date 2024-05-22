import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:popover/popover.dart';

import '../widgets/menu_items.dart';

class UserCircularAvatarContainer extends StatelessWidget {
  final String? photoURL;
  const UserCircularAvatarContainer({super.key, required this.photoURL});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CircleAvatar(
        radius: 24,
        backgroundImage: NetworkImage(
          photoURL ??
              "https://avatar.iran.liara.run/public/boy?username=Ash",
        ),
      ),
      onTap: () {
        showPopover(
          context: context,
          bodyBuilder: (context) => SizedBox(
            child: ListItems(
              numberOfItems: 2,
              context: context,
              callbacks: [
                () => {
                  // todo User screen navigation Get.to();
                },
                () => {
                  // todo AuthController log out
                }
              ],
              titles: const [
                "Me",
                "Log out"
              ],
              icons: const [
                FontAwesomeIcons.userPen,
                FontAwesomeIcons.arrowRightFromBracket
              ],
            ),
          ),
          width: 150,
          // Match the width here
          height: ListItems.totalHeight,
          // Adjust based on content or screen
          direction: PopoverDirection.bottom,
          backgroundColor: Colors.white.withOpacity(0.5),
          barrierDismissible: true,
          transitionDuration: const Duration(milliseconds: 200),
          shadow: [const BoxShadow(color: Color(0x1F000000), blurRadius: 5)],
          arrowWidth: 12,
          arrowHeight: 12,
        );
      },
    );
  }
}
