import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/property_card_item_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PropertiesContainer extends StatelessWidget {
  const PropertiesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 11,
        itemBuilder: (context, index) {
          if (index < 10) {
            return PropertyItem(
              onTap: () => {
                // todo navigation of the property
                print("Tapped ${index}nth item")
              },
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      // todo apply the functioning for nevigation to
                      // properties screen
                      print("See all from property list tapped");
                    },
                    splashColor: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            FontAwesomeIcons.locationArrow,
                            size: 40,
                            color: Colors.blue,
                          ),
                          Text(
                            AppLocalizations.of(context)!.seeAllText,
                            style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
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
