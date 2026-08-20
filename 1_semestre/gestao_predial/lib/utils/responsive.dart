import 'package:flutter/material.dart';

class Responsive {
  const Responsive._();

  static bool isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 600;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= 600 && width < 1024;
  }

  static EdgeInsets screenPadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.symmetric(horizontal: 20, vertical: 24);
    }

    if (isTablet(context)) {
      return const EdgeInsets.symmetric(horizontal: 40, vertical: 34);
    }

    return const EdgeInsets.symmetric(horizontal: 64, vertical: 44);
  }

  static EdgeInsets backButtonPadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.only(left: 16, top: 12);
    }

    return const EdgeInsets.only(left: 28, top: 24);
  }

  static double loginCardWidth(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final horizontalPadding = isMobile(context) ? 40.0 : 80.0;
    final available = size.width - horizontalPadding;
    final maxWidth = isMobile(context) ? 380.0 : 460.0;

    if (available < 320) {
      return available;
    }

    return available.clamp(320.0, maxWidth).toDouble();
  }

  static EdgeInsets loginCardPadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.fromLTRB(24, 30, 24, 26);
    }

    if (isTablet(context)) {
      return const EdgeInsets.fromLTRB(36, 40, 36, 36);
    }

    return const EdgeInsets.fromLTRB(42, 46, 42, 42);
  }
}
