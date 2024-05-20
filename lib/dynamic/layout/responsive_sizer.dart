import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Provides responsive sizing utilities for Flutter widgets.
///
/// This class serves as a centralized tool for handling dynamic sizing across various
/// device screens such as mobiles, tablets, and desktops. It is designed to be editable,
/// allowing developers to customize and extend its functionality to accommodate specific
/// responsive behaviors needed for personalized widgets or components within the application.
///
/// Each method within the class can be adjusted or new methods can be added to return
/// dynamically calculated size values based on the device's screen size. This ensures
/// that all widgets maintain optimal appearance and functionality across different devices.
///
/// The class is particularly useful for:
/// - Dynamically adjusting font sizes for titles, subtitles, and body text.
/// - Determining the size of complex UI elements like cards, buttons, and panels.
/// - Ensuring consistent and aesthetically pleasing layouts that respond to various screen dimensions.
///
/// Developers are encouraged to modify and expand this class to meet the unique design
/// requirements of their applications, ensuring scalable and maintainable responsive designs.
class ResponsiveSizer {
  static final ResponsiveSizer _instance = ResponsiveSizer._internal();

  factory ResponsiveSizer() => _instance;

  ResponsiveSizer._internal();

  /// returns the size of a Title given the context
  /// -> [BuildContext context] parameter returns [double] of size
  double titleSize(BuildContext context) {

    if (ResponsiveBreakpoints.of(context).isTablet) {
      return 28; // Title size for tablets
    } else if (ResponsiveBreakpoints.of(context).isDesktop) {
      return 30; // Title size for desktop
    } else if (ResponsiveBreakpoints.of(context).isMobile){
      return 40; // Default title size for mobile
    } else {
      return 20;
    }
  }

  /// returns the size of a Sub-Title given the context
  /// -> [BuildContext context] parameter returns [double] of size
  double subtitleSize(BuildContext context) {
    return ResponsiveBreakpoints.of(context).isMobile ? 18 : 24;
  }

  double spacingSize(BuildContext context) {
    return ResponsiveBreakpoints.of(context).isMobile ? 18 : 24;
  }

  List<double> buttonEdgeInsetsDimensions(BuildContext context){
    if (ResponsiveBreakpoints.of(context).isMobile) {
      return [24, 18];
    } else if (ResponsiveBreakpoints.of(context).isTablet) {
      return [32, 24]; // Card size for tablets
    } else {
      return [40, 32]; // Card size for desktop
    }
  }


  /// returns the size of a normal text given the context
  /// -> [BuildContext] [context] parameter returns [double] of size
  double textSize(BuildContext context) {
    return ResponsiveBreakpoints.of(context).isMobile ? 16 : 20;
  }

  Size cardSize(BuildContext context) {
    if (ResponsiveBreakpoints.of(context).isMobile) {
      return const Size(300, 200); // Card size for mobile
    } else if (ResponsiveBreakpoints.of(context).isTablet) {
      return const Size(400, 300); // Card size for tablets
    } else {
      return const Size(500, 400); // Card size for desktop
    }
  }

  /// Returns the current Platform name in human readable
  ///
  /// gets [BuildContext] [context]
  /// return [String] platform name.
  String getCurrentPlatform(BuildContext context) {
    if (ResponsiveBreakpoints.of(context).isMobile) {
      return 'Mobile';
    } else if (ResponsiveBreakpoints.of(context).isTablet) {
      return 'Tablet';
    } else if (ResponsiveBreakpoints.of(context).isDesktop) {
      return 'Desktop';
    } else {
      return 'Unknown'; // unlikely
    }
  }
}
