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
- Dart sdk: `>=2.17.6 <4.0.0`
- Flutter: `>=2.5.0`
- Android: `minSdkVersion 19`
- iOS: `minSdkVersion 11`
- native iOS and Android INFOnline libraries

You will get the native iOS and Android libraries via email from INFOnline Support. The native libraries are not public!

## Configuration

Add `flutter_infonline_library` as a [dependency in your pubspec.yaml file](https://flutter.io/using-packages/).

### iOS
Open ``ios/Podfile`` in your project. Make sure platform is uncommented and has a minimum version of 11.

```bash
platform :ios, '11.0'
```

Open XCode and add a new Run Script under "Bild Phases".

```bash
$PROJECT_DIR/INFOnlineLibrary/copy-framework.sh
```

Finally, download the iOS INFOnline library and copy the source folder to your iOS project folder.

```bash
ios/INFOnlineLibrary
```

### Android
Download the Android INFOnline library and copy the *.aar file into the follow folder in your project.

```bash
android/app/libs/infonlinelib_2.4.0.aar
```

Now open the ``android/app/build.gradle`` file and make sure your SDK version is >= 19.

```bash
android {
  defaultConfig {
    minSdkVersion 26
    targetSdkVersion 30
  }
}
```

Add your Ad Manager app ID (identified in the Ad Manager UI) to your app's AndroidManifest.xml file.

```bash
<manifest>
    <application>
        <!-- Sample Ad Manager app ID: ca-app-pub-3940256099942544~3347511713 -->
        <meta-data
            android:name="com.google.android.gms.ads.APPLICATION_ID"
            android:value="ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy"/>
    </application>
</manifest>
```

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
