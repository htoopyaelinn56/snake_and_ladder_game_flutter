import 'package:flutter/material.dart';
import 'package:flutter_snake_and_ladder_game/src/constants.dart';

import 'package:responsive_framework/responsive_wrapper.dart';
import 'dart:io' show Platform;

import '../main.dart';

class Utils {
  static bool isDesktop(BuildContext context) {
    return ResponsiveWrapper.of(context).isDesktop || ResponsiveWrapper.of(context).isTablet;
  }

  static bool isMobileDevice() {
    return Platform.isAndroid || Platform.isFuchsia || Platform.isIOS;
  }

  static Future<void> pagePusher({required BuildContext context, required Widget page, bool removeBackStack = false, bool replaceRoute = false}) async {
    if (replaceRoute) {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
      return;
    }

    await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (_) => !removeBackStack,
    );
  }

  static Future<void> showCommonSnackBar(String text, {Color? bgColor, double? width = 500}) async {
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        width: width,
        content: Text(
          text,
          style: TextStyle(color: bgColor ?? Theme.of(navigatorKey.currentContext!).colorScheme.scrim),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(navigatorKey.currentContext!).colorScheme.primaryContainer,
      ),
    );
  }

  static getWebsocketHostUrl({required bool isLocal}) {
    return isMobileDevice() ? 'ws://192.168.100.36:3000' : kWsUrl;
  }
}
