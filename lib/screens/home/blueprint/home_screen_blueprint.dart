import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huxley/screens/home/container/app_bar.dart';
import 'package:huxley/screens/home/container/properties_container.dart';
import '../../auth/login/controllers/auth_controller.dart';
import '../../auth/login/widgets/logo_image_widget.dart';
import '../container/properties_app_bar_properties_container.dart';
import '../widgets/huxley_app_title.dart';

class HomeScreenBlueprint extends StatelessWidget {
  const HomeScreenBlueprint({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: MyAppBar(
        userName: authController.user.value?.displayName ?? "Guest",
        photoURL: authController.user.value?.photoURL,
      ),
      body: LayoutBuilder(  // Provides bounds to SingleChildScrollView
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: const IntrinsicHeight(  // Ensures the column attempts to be as tall as its parent
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(  // Makes LogoImageWidget expand to fill the available space
                      child: LogoImageWidget(),
                    ),
                    HuxleyAppTitle(),
                    PropertiesAppBarPropertiesContainer(),
                    Expanded(  // Makes PropertiesContainer expand to fill the available space
                      child: PropertiesContainer(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
