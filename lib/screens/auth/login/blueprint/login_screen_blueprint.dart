import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:huxley/screens/auth/login/controllers/text_editing_controller.dart';
import 'package:huxley/screens/auth/login/widgets/hyper_link_routing_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../dynamic/layout/responsive_sizer.dart';
import '../../../completition/email/checkers/user_state_checker.dart';
import '../../../completition/email/main/completition_screen.dart';
import '../../../controller/menu/navigation_menu.dart';
import '../containers/phone_email_textfield_corpus_selector_container.dart';
import '../controllers/auth_controller.dart';
import '../controllers/screen_state_controller.dart';
import '../widgets/auth_button_wrapper_widget.dart';
import '../widgets/continue_button_widget.dart';
import '../widgets/image_logo_widget.dart';

import '../widgets/or_divider_widget.dart';

class LogInScreenBluePrint extends StatefulWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();
  final ResponsiveSizer responsiveSizer = ResponsiveSizer();
  final ScreenStateController screenStateController =
  Get.find<ScreenStateController>();

  LogInScreenBluePrint({super.key});

  @override
  State<LogInScreenBluePrint> createState() => _LogInScreenBluePrintState();
}

class _LogInScreenBluePrintState extends State<LogInScreenBluePrint> {
  bool isSignUp = false;
  late final AuthController _authController;
  late final TextEditingWidgetController controller;


  @override
  void initState() {
    super.initState();
    _authController = Get.find<AuthController>();
    Get.put(TextEditingWidgetController());
    controller = Get.find<TextEditingWidgetController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ImageLogoWidget(),
              SizedBox(height: widget.responsiveSizer.spacingSize(context)),
              Text(
                widget.screenStateController.isSignUp.value
                    ? AppLocalizations.of(context)!.signUpText
                    : AppLocalizations.of(context)!.logInText,
                style: TextStyle(
                    fontSize: widget.responsiveSizer.titleSize(context),
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: widget.responsiveSizer.spacingSize(context)),
              InputFieldWrapper(),
              SizedBox(height: widget.responsiveSizer.spacingSize(context)),


              ContinueButtonWidget(
                onPressed: () {
                  if (widget.screenStateController.isSignUp.value) {
                    _handleSignUp(context);
                  } else {
                    _handleSignIn(context);
                  }
                },
              ),


              OrDividerWidget(),
              AuthButtonWrapperWidget(
                onPressed: () {
                  _authController.signInWithGoogle(
                      onSuccess: () {
                        _navigateToHome(context);
                      },
                      onError: () {
                        Get.snackbar(
                            AppLocalizations.of(context)!.googleOnErrorAuth,
                            AppLocalizations.of(context)!
                                .googleOnErrorAuthText);
                      },
                      context: context);
                },
                icon: Image.asset('assets/logos/g-logo.png',
                    width: 28, height: 28),
                buttonText: widget.screenStateController.isSignUp.value
                    ? AppLocalizations.of(context)!.loginWithGoogleText
                    : AppLocalizations.of(context)!.singUpWithGoogleText,
                textColor: Colors.black,
                buttonColor: Colors.white,
              ),
              SizedBox(height: widget.responsiveSizer.spacingSize(context)),
              AuthButtonWrapperWidget(

                onPressed: () => print("Sign in with Apple"),
                icon: const Icon(FontAwesomeIcons.apple,
                    color: Colors.white, size: 28),
                buttonText: widget.screenStateController.isSignUp.value
                    ? AppLocalizations.of(context)!.loginWithAppleText
                    : AppLocalizations.of(context)!.signUpWithAppleText,
                textColor: Colors.white,
                buttonColor: Colors.black,
              ),
              SizedBox(height: widget.responsiveSizer.spacingSize(context)),
              HyperLinkRoutingWidget(
                initialTextLeftSide:
                !widget.screenStateController.isSignUp.value
                    ? AppLocalizations.of(context)!.dontHaveAnAccountText
                    : AppLocalizations.of(context)!.haveAnAccountText,
                hyperLinkHintText: !widget.screenStateController.isSignUp.value
                    ? AppLocalizations.of(context)!.singUpText
                    : AppLocalizations.of(context)!.logInText,
                onTap: () =>
                    setState(() {
                      widget.screenStateController.isSignUp.value = !widget
                          .screenStateController.isSignUp.value;
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _handleSignUp(BuildContext context) {
    if (controller.confirmPasswordController?.text ==
        controller.passwordController.text) {
      _signUpWithEmailAndPassword(context);
    } else {
      _showErrorSnackbar(
          context, AppLocalizations.of(context)!.passwordMismatchError);
    }
  }

  void _handleSignIn(BuildContext context) {
    _signInWithEmailAndPassword(context);
  }

  void _signUpWithEmailAndPassword(BuildContext context) {
    _authController.signUpWithEmailAndPassword(
        email: controller.emailController.text,
        password: controller.passwordController.text,
        onError: () =>
        {
        _showErrorSnackbar(context, AppLocalizations.of(context)!.errorSingUpWithEmailAndPassword)
        },
        onSuccess: () =>
        {
          _navigateToHome(context)
        },
        context: context
    );
  }

  void _signInWithEmailAndPassword(BuildContext context) {
    _authController.signInWithEmailAndPassword(
      email: controller.emailController.text,
      password: controller.passwordController.text,
      onError: () =>
      {
      _showErrorSnackbar(context, AppLocalizations.of(context)!.errorSignInEmailAndPassword)
    },
      onSuccess: () =>
      {
        _navigateToHome(context)
      },
      context: context,

    );
  }

  void _navigateToHome(BuildContext context) {
    UserStateChecker().navigateOnFieldsFilled(context);
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
