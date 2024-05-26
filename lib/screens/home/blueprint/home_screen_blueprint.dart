import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../auth/login/controllers/auth_controller.dart';
import '../../auth/login/widgets/logo_image_widget.dart';
import '../container/properties_app_bar_properties_container.dart';
import '../widgets/huxley_app_title.dart';
import '../container/app_bar.dart';
import '../container/properties_container.dart';

class HomeScreenBlueprint extends StatelessWidget {
  const HomeScreenBlueprint({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: MyAppBar(),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: const IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    LogoImageWidget(),
                    HuxleyAppTitle(),
                    PropertiesAppBarPropertiesContainer(),
                    PropertiesContainer(),
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
