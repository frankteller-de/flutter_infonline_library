import 'dart:io';

import 'package:flutter/services.dart';

import 'interface.dart';

class MethodChannelFlutterInfonlineLibrary extends InfonlineLibrary {
  @override
  final PlatformIOS ios = PlatformIOS();
  @override
  final PlatformAndroid android = PlatformAndroid();
}

class InfonlineLibraryHelpers {
  /// Cast dart enum into string
  static String enumToString<T extends Enum>(T value) {
    return value.toString().split('.').last;
  }
}

/// An implementation of [InfonlineLibrary] that uses method channels.
class MethodChannelFlutterInfonlineLibrarySession extends InfonlineLibrarySession {
  /// Session type constructor
  MethodChannelFlutterInfonlineLibrarySession(super.sessionType);

  /// The method channel used to interact with the native platform.
  final methodChannel = const MethodChannel('flutter_infonline_library');

  @override
  late final PlatformSessionIOS ios = PlatformSessionIOS(this);
  @override
  late final PlatformSessionAndroid android = PlatformSessionAndroid(this);

  @override
  Future<void> logViewEvent({required IOLViewEventType type, required String category, String? comment}) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('sessionType', () => InfonlineLibraryHelpers.enumToString(sessionType));
    args.putIfAbsent('type', () => InfonlineLibraryHelpers.enumToString(type));
    args.putIfAbsent('category', () => category);
    args.putIfAbsent('comment', () => comment);
    await methodChannel.invokeMethod<void>('logViewEvent', args);
  }

  @override
  Future<void> setCustomConsent(String consent) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('sessionType', () => InfonlineLibraryHelpers.enumToString(sessionType));
    args.putIfAbsent('consent', () => consent);
    await methodChannel.invokeMethod<void>('setCustomConsent', args);
  }

  @override
  Future<void> sendLoggedEvents() async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('sessionType', () => InfonlineLibraryHelpers.enumToString(sessionType));
    await methodChannel.invokeMethod<void>('sendLoggedEvents', args);
  }

  @override
  Future<void> terminateSession() async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('sessionType', () => InfonlineLibraryHelpers.enumToString(sessionType));
    await methodChannel.invokeMethod<void>('terminateSession', args);
  }
}

class PlatformSessionIOS extends InfonlineLibraryPlatformSessionIOS {
  final methodChannel = const MethodChannel('flutter_infonline_library');
  final InfonlineLibrarySession _mainLib;
  PlatformSessionIOS(this._mainLib);

  @override
  Future<void> startSession({required String offerIdentifier, required IOLPrivacyType type, String? hybridIdentifier, String? customerData}) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('sessionType', () => InfonlineLibraryHelpers.enumToString(_mainLib.sessionType));
    args.putIfAbsent('offerIdentifier', () => offerIdentifier);
    args.putIfAbsent('type', () => InfonlineLibraryHelpers.enumToString(type));
    args.putIfAbsent('hybridIdentifier', () => hybridIdentifier);
    args.putIfAbsent('customerData', () => customerData);
    await methodChannel.invokeMethod<void>('startIOMpSession', args);
  }
}

class PlatformIOS extends InfonlineLibraryPlatformIOS {
  final methodChannel = const MethodChannel('flutter_infonline_library');

  @override 
  Future<List<String>> mostRecentLogs(int limit) async {
    if (!Platform.isIOS) return [];
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('limit', () => limit);
    final List<dynamic>? logs = await methodChannel.invokeMethod<List<dynamic>>('mostRecentLogs', args);
    return logs?.map((log) => log.toString()).toList() ?? [];
  }

  @override
  Future<void> setDebugLogLevel(IOLDebugLevel level) async {
    if (!Platform.isIOS) return;
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('level', () => InfonlineLibraryHelpers.enumToString(level));
    await methodChannel.invokeMethod<void>('setDebugLogLevel', args);
  }
}

class PlatformSessionAndroid extends InfonlineLibraryPlatformSessionAndroid {
  final methodChannel = const MethodChannel('flutter_infonline_library');
  final InfonlineLibrarySession _mainLib;
  PlatformSessionAndroid(this._mainLib);

  @override
  Future<void> initIOLSession({required String offerIdentifier, required bool debug, required IOLPrivacyType type}) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('sessionType', () => InfonlineLibraryHelpers.enumToString(_mainLib.sessionType));
    args.putIfAbsent('privacySetting', () => InfonlineLibraryHelpers.enumToString(type));
    args.putIfAbsent('offerIdentifier', () => offerIdentifier);
    args.putIfAbsent('debug', () => debug);
    await methodChannel.invokeMethod<void>('initIOLSession', args);
  }
}

class PlatformAndroid extends InfonlineLibraryPlatformAndroid {
  final methodChannel = const MethodChannel('flutter_infonline_library');

  @override
  Future<void> setDebugModeEnabled(bool enable) async {
    if (!Platform.isAndroid) return;
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent('enable', () => enable);
    await methodChannel.invokeMethod<void>('setDebugModeEnabled', args);
  }
}