import 'package:flutter/cupertino.dart';

class Media {
  static late double screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
  }
}
