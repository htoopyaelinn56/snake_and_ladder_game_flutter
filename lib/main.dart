import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake_and_ladder_game/src/feature/core_game/presentation/play_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'dart:io' show Platform;

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb && (Platform.isLinux || Platform.isWindows || Platform.isMacOS)) {
    await DesktopWindow.setMinWindowSize(const Size(1200, 900));
    await DesktopWindow.setWindowSize(const Size(1200, 900));
  }
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // const primaryColorSeed = Color.fromARGB(255, 0, 153, 255);
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          elevation: 2,
        ),
      ),
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        defaultScale: true,
        breakpoints: const [
          ResponsiveBreakpoint.resize(650, name: MOBILE),
          ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
      ),
      home: const PlayScreen(),
    );
  }
}
