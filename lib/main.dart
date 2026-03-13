import 'package:flutter/material.dart';

import 'config/config_loader.dart';
import 'core/theme/app_theme.dart';
import 'features/home/home_page.dart';

/// Entry point.
/// 1. Ensure Flutter bindings are initialised.
/// 2. Load the client config for the current flavor.
/// 3. Build the app with the branded theme.
///
/// Run with:
///   flutter run --flavor clientA --dart-define=FLAVOR=clientA
///   flutter run --flavor clientB --dart-define=FLAVOR=clientB
///
/// Generate launcher icons:
///   dart run flutter_launcher_icons -f flutter_launcher_icons-clientA.yaml
///   dart run flutter_launcher_icons -f flutter_launcher_icons-clientB.yaml
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigLoader.load();
  runApp(const WhiteLabelApp());
}

class WhiteLabelApp extends StatelessWidget {
  const WhiteLabelApp({super.key});

  @override
  Widget build(BuildContext context) {
    final config = ConfigLoader.instance;

    return MaterialApp(
      title: config.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.fromConfig(config),
      home: const HomePage(),
    );
  }
}
