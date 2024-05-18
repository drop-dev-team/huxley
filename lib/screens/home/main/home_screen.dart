import 'package:flutter/material.dart';
import 'package:huxley/screens/home/container/app_bar.dart';
import 'package:huxley/screens/home/container/properties_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(), // Custom AppBar already defined
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.network(
              'https://www.creativefabrica.com/wp-content/uploads/2021/03/20/Mountain-logo-Design-Graphics-9785421-1-1-580x435.png', // Replace with your actual logo asset path
              height: 350, // Set as needed
            ),
          ),
          const Center(
            child: Text(
              "HUXLEY",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20), // Space before the property section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Property",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to the property listings page
                  },
                  child: TextButton(
                    onPressed: () {  },
                    child: const Text(
                      "See All",
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),

                  ),
                ),
              ],
            ),
          ),
          const PropertiesContainer(), // Horizontal list of properties
        ],
      ),
    );
  }
}
