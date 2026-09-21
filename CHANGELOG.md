## 0.14.0

* **Breaking:** requires Flutter 3.44 / Dart 3.12 or newer, iOS 13+, and Android API 21+ (or the consuming Flutter SDK's higher minimum).
* Supports Swift Package Manager and CocoaPods using shared Swift sources.
* Migrates Android to the compilerOptions DSL and Java 17, compatible with Flutter's built-in Kotlin integration.
* Keeps the Dart API and vendor SDK versions unchanged.
* Updates the examples to Flutter 3.47+, iOS 15+, and AGP 9 with built-in Kotlin enabled.
* Declares Google Play Services Base directly so clean consumers satisfy the vendor SDK and R8 without app-level Google dependencies.
* Android repository configuration now belongs to the consuming app; configure the licensed INFOnline AAR repository as documented.

## 0.13.1
* Downgrade ads-id to 18.1.0 for better compatibility

## 0.13.0
* Upgrade gradle version to 1.8.20

## 0.12.0
* Upgrade gradle version to 1.8.0

## 0.11.17
* Registrar fix

## 0.11.16
* de.infonline.lib upgraded to infonlinelib_2.5.0.aar

## 0.11.15
* iOS Lib embedded

## 0.10.7+17
* Bugfixes

## 0.10.7+16
* Bugfixes

## 0.10.7+15
* Bugfixes

## 0.10.6+14
* de.infonline.lib upgraded to infonlinelib_2.4.0.aar

## 0.10.5+13
* IMPORTANT! That version changed from objc to swift lib. Please insert the INFOnlineLibrary.xcframework folder and delete the INFOnlineLibrary folder from https://git.infonline.de/.

## 0.9.4+12
* Enum Fix by @KevinHaendel
* Upgrade to major-versions

## 0.9.3+11
* Fixed: Unable to get provider com.google.android.gms.ads.MobileAdsInitProvider: java.lang.IllegalStateException
* libs updated

## 0.9.3+10
* bugfixes

## 0.9.1

* first release