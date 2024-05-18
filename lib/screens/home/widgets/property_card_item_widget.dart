import 'package:flutter/material.dart';

class PropertyItem extends StatelessWidget {
  const PropertyItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,  // Width of the card
      height: 200, // Height of the card
      child: Card(
        clipBehavior: Clip.antiAlias, // Ensures the image (or any child) doesn't overlap the card's edges
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Adds rounded corners to the card
        ),
        child: Stack(
          alignment: Alignment.bottomLeft, // Aligns child to the bottom left
          children: [
            Image.network(
              'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', // Replace with your actual image URL
              fit: BoxFit.cover, // Ensures the image covers the card area without stretching
              width: double.infinity, // Ensures the image takes the full card width
              height: double.infinity, // Ensures the image takes the full card height
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.8), // Stronger opacity at bottom
                    Colors.transparent, // Transparent at the top
                  ],
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(8), // Padding inside the overlay container
                alignment: Alignment.bottomLeft,
                child: const Text(
                  '123 Shadowgate Dr',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
