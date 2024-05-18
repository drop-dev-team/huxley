import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:huxley/screens/controller/menu/navigation_menu.dart';
import 'dart:io'; // Ensure you have this import for accessing Platform.localeName

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Extract the platform locale
    String platformLocale = Platform.localeName; // Get locale from the OS, e.g., 'en_US'
    List<String> localeParts = platformLocale.split('_'); // Split into parts ['en', 'US']
    Locale currentLocale = Locale(localeParts[0], localeParts.length > 1 ? localeParts[1] : '');

    return MaterialApp(
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
      locale: currentLocale, // Set locale based on the platform
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
