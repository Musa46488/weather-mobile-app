import 'package:flutter/widgets.dart';

abstract class ResponsiveHelper {
  ResponsiveHelper._();
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static Orientation orientation(BuildContext context) =>
      MediaQuery.of(context).orientation;

  static bool isLandscape(BuildContext context) =>
      orientation(context) == Orientation.landscape;

  static bool isMobile(BuildContext context) {
    final width = screenWidth(context);
    final height = screenHeight(context);

    return isLandscape(context) ? height < 600 : width < 600;
  }

  static bool isTablet(BuildContext context) {
    final width = screenWidth(context);
    final height = screenHeight(context);

    final value = isLandscape(context) ? height : width;
    return value >= 600 && value < 1200;
  }

  static bool isDesktop(BuildContext context) {
    final width = screenWidth(context);
    final height = screenHeight(context);

    final value = isLandscape(context) ? height : width;
    return value >= 1200;
  }

  static EdgeInsets padding(BuildContext context) {
    final ref = isLandscape(context)
        ? screenHeight(context)
        : screenWidth(context);

    if (ref >= 1200) {
      return EdgeInsets.symmetric(horizontal: ref * 0.1, vertical: 24);
    } else if (ref >= 600) {
      return EdgeInsets.symmetric(horizontal: ref * 0.05, vertical: 16);
    } else {
      return EdgeInsets.symmetric(horizontal: ref * 0.04, vertical: 14);
    }
  }

  static double fontSize(
    BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    if (isDesktop(context)) return desktop;
    if (isTablet(context)) return tablet;
    return mobile;
  }

  static double dimension(
    BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    if (isDesktop(context)) return desktop;
    if (isTablet(context)) return tablet;
    return mobile;
  }

  static double heightPercentage(BuildContext context, double percentage) {
    return screenHeight(context) * percentage;
  }

  static double widthPercentage(BuildContext context, double percentage) {
    return screenWidth(context) * percentage;
  }
}
