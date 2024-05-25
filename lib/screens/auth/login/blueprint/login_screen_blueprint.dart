import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:huxley/screens/auth/login/controllers/text_editing_controller.dart';
import 'package:huxley/screens/auth/login/widgets/hyper_link_routing_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../dynamic/layout/responsive_sizer.dart';
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

  @override
  void initState() {
    super.initState();
    _authController = Get.put(AuthController()); 
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
                    
                    var controller = Get.find<TextEditingWidgetController>();  
                    if (controller.confirmPasswordController?.text == controller.passwordController.text) {
                      
                      _authController.instance.signUpWithEmailAndPassword(
                        controller.emailController.text,
                        controller.passwordController.text,
                      ).then((userCredential) {
                        
                        Get.offAll(() => const NavigationMenu());
                      }).catchError((error) {
                        
                        Get.snackbar(
                          "Error",
                          AppLocalizations.of(context)!.errorSingUpWithEmailAndPassword,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        return null;  
                      });
                    } else {
                      
                      Get.snackbar(
                        "Error",
                        AppLocalizations.of(context)!.passwordMismatchError,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  } else {
                    
                    var controller = Get.find<TextEditingWidgetController>();  
                    _authController.instance.signInWithEmailAndPassword(
                      controller.emailController.text,
                      controller.passwordController.text,
                    ).then((userCredential) {
                      
                      Get.offAll(() => const NavigationMenu());  
                    }).catchError((error) {
                      
                      Get.snackbar(
                        "Error",
                        AppLocalizations.of(context)!.errorSignInEmailAndPassword,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    });
                  }
                },
              )



              ,
              OrDividerWidget(),
              AuthButtonWrapperWidget(
                onPressed: () {
                  _authController.signInWithGoogle(
                      onSuccess: () {
                        Get.offAll(() =>
                            const NavigationMenu()); 
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
                onTap: () => setState(() {
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
}
