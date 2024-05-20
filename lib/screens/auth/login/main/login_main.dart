import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huxley/screens/auth/login/constants/auth_constants.dart';
import 'package:huxley/screens/auth/login/widgets/hyper_link_routing_widgets.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../dynamic/layout/responsive_sizer.dart';
import '../containers/phone_email_textfield_corpus_selector_container.dart';
import '../widgets/or_divider_widget.dart';

class LogInController extends GetxController {
  var phoneNumber = ''.obs;

  void updatePhoneNumber(String number) {
    phoneNumber.value = number;
  }
}

class LogInScreen extends StatelessWidget {
  final ResponsiveSizer responsiveSizer = ResponsiveSizer();
  final LogInController controller = Get.put(LogInController());

  LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
                child: CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(AuthConstants.logoURL),
            )),
            SizedBox(height: responsiveSizer.spacingSize(context)),
            Text(
              AppLocalizations.of(context)!.logInText,
              style: TextStyle(
                  fontSize: responsiveSizer.titleSize(context),
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: responsiveSizer.spacingSize(context)),
            InputFieldWrapper(),
            SizedBox(height: responsiveSizer.spacingSize(context)),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(
                AppLocalizations.of(context)!.continueText,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            OrDividerWidget(),
            SignInButton(
              Buttons.apple,
              text: AppLocalizations.of(context)!.loginWithAppleText,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              onPressed: () {
                print('Clicked Apple Sign In');
              },
              padding: EdgeInsets.symmetric(
                  horizontal:
                      responsiveSizer.buttonEdgeInsetsDimensions(context)[0],
                  vertical:
                      responsiveSizer.buttonEdgeInsetsDimensions(context)[1]),
            ),
            SizedBox(height: responsiveSizer.spacingSize(context)),
            SignInButton(
              Buttons.google,
              text: AppLocalizations.of(context)!.loginWithGoogleText,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              onPressed: () {
                print('Clicked Google Sign In');
              },
              padding: EdgeInsets.symmetric(
                  horizontal:
                      responsiveSizer.buttonEdgeInsetsDimensions(context)[0],
                  vertical:
                      responsiveSizer.buttonEdgeInsetsDimensions(context)[1]),
            ),
            SizedBox(height: responsiveSizer.spacingSize(context)),
            HyperLinkRoutingWidget(
              initialTextLeftSide:
                  AppLocalizations.of(context)!.dontHaveAnAccountText,
              hyperLinkHintText: AppLocalizations.of(context)!.singUpText,
              onTap: () => {print("Sign up Navigation TODO")},
            ),
          ],
        ),
      ),
    );
  }
}
