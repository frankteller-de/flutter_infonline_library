# Unoffical INFOnline Flutter Library

[![Pub](https://img.shields.io/pub/v/flutter_infonline_library.svg)](https://pub.dartlang.org/packages/flutter_infonline_library)
[![Build Status](https://github.com/codeforce-dev/flutter_infonline_library/workflows/Dart/badge.svg)](https://github.com/codeforce-dev/flutter_infonline_library/actions)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](https://github.com/codeforce-dev/flutter_infonline_library/blob/main/LICENSE)
[![package publisher](https://img.shields.io/pub/publisher/path.svg)](https://pub.dev/publishers/codeforce.dev/packages)
[![Awesome Flutter](https://img.shields.io/badge/Awesome-Flutter-blue.svg?longCache=true)]()

Library for pseudonym measurements

The INFOnline Flutter Library supports parallel operation of sessions of the following measurement systems:

* IOMp/SZM (INFOnline Library iOS/Android)
* ÖWA (INFOnline Library iOS/Android)

If you are interested in census measurements look at [flutter\_iomb_library](https://github.com/codeforce-dev/flutter_iomb_library):

* IOMb/Census (IOMb Library iOS/Android)

## Requirements

Flutter >=3.44 / Dart >=3.12, Java 17, Android API 21+, and iOS 13+.
The consuming Flutter SDK may require higher OS versions (Flutter 3.47: API 24 / iOS 15).
The Dart API is unchanged; older Flutter projects must use the previous release line.
Examples use Flutter 3.47, AGP 9.1 / Gradle 9.3.1, and iOS 15.

## Configuration

### iOS

Swift Package Manager (default in Flutter 3.44+) and CocoaPods share the same Swift source.
INFOnlineLibrary 2.7.0 and its privacy manifests are bundled for both package managers.
Do not manually link another copy of the framework.

### Android

Place the vendor's [`infonlinelib_2.5.0.aar`](https://github.com/INFOnline-sg/libs-appsensor-iomp-android) in `android/app/libs`.
Add this repository to the app's `allprojects.repositories` (or equivalent settings repositories):

```groovy
flatDir {
    dirs rootProject.file('app/libs')
    content { includeModule('de.infonline.lib', 'infonlinelib_2.5.0') }
}
```

The plugin supplies Ads Identifier 18.1.0 and Google Play Services Base 18.5.0.
Base is required by the vendor's direct `GoogleApiAvailability` calls; apps do not need to add it separately.
These versions retain API 21 support, and Gradle can resolve compatible newer versions required by other app dependencies.
The full Google Mobile Ads SDK is not included, so this plugin does not require a Mobile Ads application ID.

### Android tooling

The plugin uses `kotlin.compilerOptions` and lets Flutter provide Kotlin integration.
Flutter 3.44 supports the legacy Kotlin setup; Flutter 3.47 / AGP 9 supports built-in Kotlin.
Enable `android.builtInKotlin=true` only after all app plugins support it, and retain Flutter's `android.newDsl=false` setting.
See the example for configuration. Validate a minified release build with your vendor credentials and measurement identifiers.

# Usage
Simple example to test the plugin in your project.
## Example

```dart
import 'package:flutter_infonline_library/flutter_infonline_library.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    // Enable logging, that will display in your IDE console.
    await InfonlineLibrary.instance.android.setDebugModeEnabled(true);

    // Create a new Android session
    await InfonlineLibrary.instance.session(IOLSessionType.szm).android.initIOLSession(
      offerIdentifier: '<yourIdentifier>', debug: true, type: IOLPrivacyType.ack
    );
  }
  else if (Platform.isIOS) {
    // Enable logging, that will only display in your XCode console.
    await InfonlineLibrary.instance.ios.setDebugLogLevel(IOLDebugLevel.trace);

    // Create a new iOS session
    await InfonlineLibrary.instance.session(IOLSessionType.szm).ios.startSession(
      offerIdentifier: '<yourIdentifier>', type: IOLPrivacyType.ack
    );
  }

  // Log an view event
  await InfonlineLibrary.instance.session(IOLSessionType.szm).logViewEvent(
    type: IOLViewEventType.appeared,
    category: '<yourCategory>'
  );
}
```

# Supported functions

## Shared for all platforms
```dart
InfonlineLibrary.instance.session(IOLSessionType.szm).logViewEvent(
  type: IOLViewEventType.appeared,
  category: '<yourCategory>'
);

InfonlineLibrary.instance.session(IOLSessionType.szm).sendLoggedEvents();

InfonlineLibrary.instance.session(IOLSessionType.szm).terminateSession();

InfonlineLibrary.instance.session(IOLSessionType.szm).setCustomConsent('<String>');
```
For more informations look at the offical [iOS](https://docs.infonline.de/infonline-measurement/integration/lib/iOS/pseudonym/ios_pseudonym_funktionen/) and [Android documentation](https://docs.infonline.de/infonline-measurement/integration/lib/android/pseudonym/android_pseudonym_funktion/).

## iOS specified
```dart
InfonlineLibrary.instance.ios.setDebugLogLevel(IOLDebugLevel.trace);

InfonlineLibrary.instance.session(IOLSessionType.szm).ios.startSession(
  offerIdentifier: '<yourIdentifier>',
  type: IOLPrivacyType.ack
);

List<String> logs = await InfonlineLibrary.instance.ios.mostRecentLogs(0);
```
For more informations look at the offical [iOS documentation](https://docs.infonline.de/infonline-measurement/integration/lib/iOS/pseudonym/ios_pseudonym_funktionen/).

## Android specified
```dart
InfonlineLibrary.instance.android.setDebugModeEnabled(true);

InfonlineLibrary.instance.session(IOLSessionType.szm).android.initIOLSession(
  offerIdentifier: '<yourIdentifier>',
  debug: true,
  type: IOLPrivacyType.ack
);
```
For more informations look at the offical [Android documentation](https://docs.infonline.de/infonline-measurement/integration/lib/android/pseudonym/android_pseudonym_funktion/).
