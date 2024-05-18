import 'package:flutter/material.dart';
import 'package:huxley/screens/home/constants/home_screen_constants.dart';
import 'package:huxley/screens/home/container/app_bar.dart';
import 'package:huxley/screens/home/container/properties_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              HomeScreenConstants.placeHolderLogo,
              height: 350, // Adjust as needed
              alignment: Alignment.center,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.appTitle,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                  AppLocalizations.of(context)!.propertyText,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to the property listings page
                    },
                    child: Text(
                      AppLocalizations.of(context)!.seeAllText,
                      style: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const PropertiesContainer(), // Horizontal list of properties
          ],
        ),
      ),
    );
  }
}
