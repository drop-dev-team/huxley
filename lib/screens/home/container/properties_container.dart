import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/property_card_item_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PropertiesContainer extends StatelessWidget {
  const PropertiesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Adjust height as needed to fit PropertyItem and the "See All" button
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 11, // 10 Property items + 1 "See All" item
        itemBuilder: (context, index) {
          if (index < 10) { // First 10 items are PropertyItems
            return const PropertyItem();
          } else { // The 11th item is the "See All" button
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: Material(
                  color: Colors.transparent, // Make Material widget transparent
                  child: InkWell(
                    onTap: () {
                      print("See all from property list tapped");
                      // Navigate to the "See All" page or perform an action
                    },
                    splashColor: Colors.grey.withOpacity(0.1), // Customizable splash color
                    borderRadius: BorderRadius.circular(20), // Circular radius for the splash effect
                    child: Padding(
                      padding: const EdgeInsets.all(8.0), // Padding around the splash area
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            FontAwesomeIcons.locationArrow, size: 40, color: Colors.blue,
                          ),
                          Text(
                            AppLocalizations.of(context)!.seeAllText,
                            style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
