import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:huxley/screens/controller/menu/navigation_menu.dart';
import 'firebase_options.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // For testing: manually adjust these values as needed for different testing scenarios
  Locale testLocale = const Locale('fr', 'FR');  // Example: Testing with French locale
  bool testMode = true;  // Toggle this to enable or disable test mode

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
    Locale effectiveLocale = testMode ? locale : Locale(Platform.localeName.split('_')[0], Platform.localeName.split('_')[1]);

    return MaterialApp(
      locale: effectiveLocale,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('es', 'MX'),
        Locale('fr', 'FR'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
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
      home: const NavigationMenu(),
    );
  }
}
