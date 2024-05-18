import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/property_card_item_widget.dart'; // Ensure the file is imported correctly

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
            return GestureDetector(
              onTap: () {
                // Navigate to the "See All" page or perform an action
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {}, // Define action for See All icon
                        icon: const Icon(FontAwesomeIcons.locationArrow, size: 40,),
                      ),
                      const Text(
                        "See All",
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ],
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
