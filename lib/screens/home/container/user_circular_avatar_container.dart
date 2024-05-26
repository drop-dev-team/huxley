import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:huxley/screens/auth/login/main/login_main.dart';
import 'package:popover/popover.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../auth/login/controllers/auth_controller.dart';
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
      onTap: () async {
        // Optionally introduce a delay or perform an async operation
        await Future.delayed(const Duration(milliseconds: 100));  // Adjust time as necessary

        // Check if the widget is still mounted (i.e., the context is still valid)
        if (!context.mounted) return;

        showPopover(
          context: context,
          bodyBuilder: (context) => SizedBox(
            child: ListItems(
              numberOfItems: 3,
              context: context,
              callbacks: [
                    () {
                  // User screen navigation or any other action

                },
                    () {
                  // Handle log out or other actions
                      AuthController().logout();
                      Get.to(() => const LogInScreen());
                },
                    () {
                  // User support option

                }
              ],
              titles: [
                AppLocalizations.of(context)!.meUserOptionText,
                AppLocalizations.of(context)!.logOutUserText,
                "Support and Help"
              ],
              icons: const [
                FontAwesomeIcons.userPen,
                FontAwesomeIcons.arrowRightFromBracket,
                FontAwesomeIcons.circleInfo
              ],
            ),
          ),
          width: 180,
          height: 180,
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
