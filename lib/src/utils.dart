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
      {required BuildContext context,
      required Widget page,
      bool removeBackStack = false}) async {
    await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (_) => !removeBackStack,
    );
  }
}
