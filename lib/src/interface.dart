import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'channel.dart';

enum IOLViewEventType {
  appeared,
  refreshed,
  disappeared
}
enum IOLPrivacyType {
  ack,
  lin,
  pio
}
enum IOLDebugLevel {
  off,
  error,
  warning,
  info,
  trace
}
enum IOLSessionType {
  szm,
  oewa
}

abstract class InfonlineLibrary extends PlatformInterface {
  /// Constructs a FlutterInfonlineLibraryPlatform.
  InfonlineLibrary() : super(token: _token);
  static final Object _token = Object();
  static InfonlineLibrary _instance = MethodChannelFlutterInfonlineLibrary();

  /// The default instance of [InfonlineLibrary] to use.
  ///
  /// Defaults to [MethodChannelFlutterInfonlineLibrary].
  static InfonlineLibrary get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [InfonlineLibrary] when
  /// they register themselves.
  static set instance(InfonlineLibrary instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  abstract final InfonlineLibraryPlatformIOS ios;
  abstract final InfonlineLibraryPlatformAndroid android;

  /// Map of various library types
  final Map<IOLSessionType, InfonlineLibrarySession> _libs = <IOLSessionType, InfonlineLibrarySession>{}; 

  /// Get session for session based events
  InfonlineLibrarySession session(IOLSessionType type) {
    return _libs[type] ?? _createSessionLib(type);
  }

  /// Create a new lib by session type only once
  InfonlineLibrarySession _createSessionLib(IOLSessionType type) {
    _libs[type] = MethodChannelFlutterInfonlineLibrarySession(type);
    return _libs[type]!;
  }
}

abstract class InfonlineLibrarySession {
  InfonlineLibrarySession(this._sessionType);

  final IOLSessionType _sessionType;
  IOLSessionType get sessionType => _sessionType;

  abstract final InfonlineLibraryPlatformSessionIOS ios;
  abstract final InfonlineLibraryPlatformSessionAndroid android;

  Future<void> logViewEvent({required IOLViewEventType type, required String category, String? comment}) async {
    throw UnimplementedError('logViewEvent() has not been implemented.');
  }

  Future<void> setCustomConsent(String consent) async {
    throw UnimplementedError('setCustomConsent() has not been implemented.');
  }

  Future<void> sendLoggedEvents() async {
    throw UnimplementedError('sendLoggedEvents() has not been implemented.');
  }

  Future<void> terminateSession() async {
    throw UnimplementedError('terminateSession() has not been implemented.');
  }
}

abstract class InfonlineLibraryPlatformSessionIOS {
  /// IOMp: IOMp/SZM (INFOnline Pseudonyme Library iOS)
  Future<void> startSession({ required String offerIdentifier, required IOLPrivacyType type, String? hybridIdentifier, String? customerData}) async {
    throw UnimplementedError('startIOMpSession() has not been implemented.');
  }
}
abstract class InfonlineLibraryPlatformIOS {
  Future<List<String>> mostRecentLogs(int limit) async {
    throw UnimplementedError('mostRecentLogs() has not been implemented.');
  }
  Future<void> setDebugLogLevel(IOLDebugLevel level) async {
    throw UnimplementedError('setDebugLogLevel() has not been implemented.');
  }
}

abstract class InfonlineLibraryPlatformSessionAndroid {
  /// IOMp: IOMp/SZM (INFOnline Pseudonyme Library iOS)
  Future<void> initIOLSession({required String offerIdentifier, required bool debug, required IOLPrivacyType type}) async {
    throw UnimplementedError('initIOLSession() has not been implemented.');
  }
}
abstract class InfonlineLibraryPlatformAndroid {
  Future<void> setDebugModeEnabled(bool enable) async {
    throw UnimplementedError('setDebugModeEnabled() has not been implemented.');
  }
}