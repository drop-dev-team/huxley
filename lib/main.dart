import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:huxley/screens/auth/login/controller/state_controller.dart';
import 'package:huxley/screens/auth/login/main/login_main.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'firebase_options.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthController());
  Locale testLocale = const Locale('fr', 'FR');
  bool testMode = true;

  runApp(MyApp(locale: testLocale, testMode: testMode));
}

class MyApp extends StatelessWidget {
  final Locale locale;
  final bool testMode;

  const MyApp({
    super.key,
    required this.locale,
    this.testMode = false,
  });

  @override
  Widget build(BuildContext context) {
    Locale effectiveLocale = testMode
        ? locale
        : Locale(Platform.localeName.split('_')[0],
            Platform.localeName.split('_')[1]);

    return MaterialApp(
      locale: effectiveLocale,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('fr', 'FR'),
        Locale('es', 'ES'),
        Locale('es', 'MX'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return locale;
      },
      title: 'Huxley',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          foregroundColor: Colors.black,
        ),
        useMaterial3: true,
      ),
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: 'MOBILE'),
          const Breakpoint(start: 451, end: 800, name: 'TABLET'),
          const Breakpoint(start: 801, end: 1920, name: 'DESKTOP'),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => LogInScreen(),
      },
    );
  }
}
