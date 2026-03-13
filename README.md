# flutter_flavors

A **white-label Flutter application** — one codebase, multiple branded client apps. Each flavor produces a fully independent app with its own name, icons, colors, logo, and API configuration.

---

## What is a White-Label App?

A white-label application is a software product built once and rebranded for multiple clients or businesses. Each client receives an application with its own branding and configuration while the underlying codebase remains shared.

**Benefits:**
- Features are developed once and reused across all client apps
- Bug fixes and updates apply to every client automatically
- Significantly lower costs compared to building separate apps
- Easily scale to dozens of branded apps from a single repo

---

## Flavors in This Project

| Flavor | App Name | Primary Color | API |
|--------|----------|---------------|-----|
| clientA | Alpha App | `#1E88E5` | https://api.alpha-corp.com |
| clientB | Beta App | `#43A047` | https://api.beta-solutions.com |

Each flavor has its own:
- JSON config (`configs/<flavor>.json`)
- Launcher icon (`assets/icons/<flavor>_icon.png`)
- Brand logo (`assets/brands/<flavor>_logo.svg`)
- Android resource set (`android/app/src/<flavor>/`)
- iOS scheme and xcconfig files

---

## Project Structure

```
flutter_flavors/
├── configs/
│   ├── clientA.json              # Client A configuration
│   └── clientB.json              # Client B configuration
├── assets/
│   ├── brands/                   # SVG logos per client
│   └── icons/                    # Launcher icon PNGs per client
├── lib/
│   ├── main.dart                 # Entry point
│   ├── config/
│   │   ├── app_config.dart       # AppConfig model
│   │   └── config_loader.dart    # Loads configs/<flavor>.json at runtime
│   ├── core/theme/
│   │   └── app_theme.dart        # ThemeData built from AppConfig
│   └── features/home/
│       └── home_page.dart        # Branded home screen
├── android/app/src/
│   ├── clientA/res/              # App name, colors, icons for clientA
│   └── clientB/res/              # App name, colors, icons for clientB
├── ios/Flutter/
│   ├── clientA-Debug.xcconfig
│   ├── clientA-Release.xcconfig
│   ├── clientB-Debug.xcconfig
│   └── clientB-Release.xcconfig
├── flutter_launcher_icons-clientA.yaml
└── flutter_launcher_icons-clientB.yaml
```

---

## Client Configuration

Each client is configured via a JSON file in `configs/`. Fields available:

```json
{
  "appName": "Alpha App",
  "apiUrl": "https://api.alpha-corp.com",
  "primaryColor": "#1E88E5",
  "secondaryColor": "#1565C0",
  "accentColor": "#82B1FF",
  "logoPath": "assets/brands/clientA_logo.svg",
  "iconPath": "assets/icons/clientA_icon.png",
  "supportEmail": "support@alpha-corp.com",
  "websiteUrl": "https://www.alpha-corp.com",
  "termsUrl": "https://www.alpha-corp.com/terms",
  "privacyUrl": "https://www.alpha-corp.com/privacy"
}
```

The active flavor is passed at build/run time via `--dart-define=FLAVOR=<flavor>` and loaded by `ConfigLoader` at app startup.

---

## Getting Started

### 1. Install dependencies

```bash
flutter pub get
```

### 2. Run a flavor

```bash
flutter run --flavor clientA --dart-define=FLAVOR=clientA
flutter run --flavor clientB --dart-define=FLAVOR=clientB
```

### 3. Generate launcher icons

```bash
dart run flutter_launcher_icons -f flutter_launcher_icons-clientA.yaml
dart run flutter_launcher_icons -f flutter_launcher_icons-clientB.yaml
```

### 4. Generate native splash screens

```bash
dart run flutter_native_splash:create
```

---

## Building

### Android — Release APK

```bash
flutter build apk --flavor clientA --dart-define=FLAVOR=clientA --release
flutter build apk --flavor clientB --dart-define=FLAVOR=clientB --release
```

Output: `build/app/outputs/flutter-apk/app-<flavor>-release.apk`

### Android — Release AAB (Play Store)

```bash
flutter build appbundle --flavor clientA --dart-define=FLAVOR=clientA --release
flutter build appbundle --flavor clientB --dart-define=FLAVOR=clientB --release
```

### iOS — Release IPA

```bash
flutter build ipa --flavor clientA --dart-define=FLAVOR=clientA --release
flutter build ipa --flavor clientB --dart-define=FLAVOR=clientB --release
```

---

## Adding a New Client

1. Add `configs/clientX.json` with all required fields
2. Add logo to `assets/brands/clientX_logo.svg`
3. Add icon to `assets/icons/clientX_icon.png`
4. Create `flutter_launcher_icons-clientX.yaml`
5. Add Android resource set at `android/app/src/clientX/res/values/strings.xml`
6. Add iOS xcconfig files: `ios/Flutter/clientX-Debug.xcconfig` and `clientX-Release.xcconfig`
7. Add an iOS scheme in Xcode for `clientX`
8. Register the flavor in `android/app/build.gradle.kts`
9. Run icon generation:
    ```bash
    dart run flutter_launcher_icons -f flutter_launcher_icons-clientX.yaml
    ```
