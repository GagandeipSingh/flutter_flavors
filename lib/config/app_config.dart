import 'package:flutter/material.dart';

/// Holds all client-specific configuration loaded from configs/<flavor>.json.
class AppConfig {
  final String flavor;
  final String appName;
  final String apiUrl;
  final String primaryColor;
  final String secondaryColor;
  final String accentColor;
  final String logoPath;
  final String iconPath;
  final String supportEmail;
  final String websiteUrl;
  final String termsUrl;
  final String privacyUrl;

  const AppConfig({
    required this.flavor,
    required this.appName,
    required this.apiUrl,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
    required this.logoPath,
    required this.iconPath,
    required this.supportEmail,
    required this.websiteUrl,
    required this.termsUrl,
    required this.privacyUrl,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json, String flavor) {
    return AppConfig(
      flavor: flavor,
      appName: json['appName'] as String,
      apiUrl: json['apiUrl'] as String,
      primaryColor: json['primaryColor'] as String,
      secondaryColor: json['secondaryColor'] as String,
      accentColor: json['accentColor'] as String,
      logoPath: json['logoPath'] as String,
      iconPath: json['iconPath'] as String,
      supportEmail: json['supportEmail'] as String,
      websiteUrl: json['websiteUrl'] as String,
      termsUrl: json['termsUrl'] as String,
      privacyUrl: json['privacyUrl'] as String,
    );
  }

  /// Parses a hex color string like `#1E88E5` into a Flutter [Color].
  Color get primaryColorValue => _hexToColor(primaryColor);
  Color get secondaryColorValue => _hexToColor(secondaryColor);
  Color get accentColorValue => _hexToColor(accentColor);

  static Color _hexToColor(String hex) {
    final cleaned = hex.replaceFirst('#', '');
    return Color(int.parse('FF$cleaned', radix: 16));
  }

  @override
  String toString() => 'AppConfig(flavor: $flavor, appName: $appName)';
}
