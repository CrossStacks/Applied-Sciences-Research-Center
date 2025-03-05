import 'package:flutter/material.dart';

class Dimensions {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1500 &&
      MediaQuery.of(context).size.width >= 850;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1500;
}
