import 'package:flutter/material.dart'
    show BuildContext, Navigator, MaterialPageRoute, Widget;

import 'package:responsive_framework/responsive_wrapper.dart';
import 'dart:io' show Platform;

class Utils {
  static bool isDesktop(BuildContext context) {
    return ResponsiveWrapper.of(context).isDesktop ||
        ResponsiveWrapper.of(context).isTablet;
  }

  static bool isMobileDevice() {
    return Platform.isAndroid || Platform.isFuchsia || Platform.isIOS;
  }

  static Future<void> pagePusher(
      {required Widget page,
      required BuildContext context,
      bool removeBackStack = false}) async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
      (_) => !removeBackStack,
    );
  }
}
