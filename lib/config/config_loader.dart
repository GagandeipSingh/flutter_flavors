import 'dart:convert';

import 'package:flutter/services.dart';

import 'app_config.dart';

/// Loads and caches the [AppConfig] for the current build flavor.
///
/// Call [ConfigLoader.load] once during app startup (before [runApp]).
/// Access the loaded config anywhere via [ConfigLoader.instance].
///
/// Select a flavor at build time:
///   flutter run  --flavor clientA
///   flutter build apk --flavor clientB
class ConfigLoader {
  ConfigLoader._();

  static AppConfig? _instance;

  /// The loaded [AppConfig]. Throws if `load()` was not called first.
  static AppConfig get instance {
    assert(
      _instance != null,
      'ConfigLoader.load() must be called before accessing ConfigLoader.instance',
    );
    return _instance!;
  }

  /// Reads configs/<flavor>.json from the asset bundle and parses it.
  /// Falls back to "clientA" when no flavor is supplied.
  static Future<void> load() async {
    const flavor = String.fromEnvironment('FLUTTER_APP_FLAVOR', defaultValue: 'clientA');
    final jsonString = await rootBundle.loadString('configs/$flavor.json');
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    _instance = AppConfig.fromJson(json, flavor);
  }
}
