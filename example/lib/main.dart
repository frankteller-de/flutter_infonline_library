import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_infonline_library/flutter_infonline_library.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await InfonlineLibrary.instance.android.setDebugModeEnabled(true);
  
    await InfonlineLibrary.instance.session(IOLSessionType.szm).android.initIOLSession(
      offerIdentifier: '<yourIdentifier>', debug: true, type: IOLPrivacyType.ack
    );

    //await InfonlineLibrary.instance.session(IOLSessionType.szm).sendLoggedEvents();
    //await InfonlineLibrary.instance.session(IOLSessionType.szm).terminateSession();

    await Future.delayed(const Duration(seconds: 2));
    await InfonlineLibrary.instance.session(IOLSessionType.szm).setCustomConsent('FF00800000');

    await Future.delayed(const Duration(seconds: 2));
    await InfonlineLibrary.instance.session(IOLSessionType.szm).logViewEvent(
      type: IOLViewEventType.appeared,
      category: '<category>'
    );

    await InfonlineLibrary.instance.session(IOLSessionType.szm).sendLoggedEvents();
  }
  if (Platform.isIOS) {
    await InfonlineLibrary.instance.ios.setDebugLogLevel(IOLDebugLevel.trace);

    await Future.delayed(const Duration(seconds: 2));
    await InfonlineLibrary.instance.session(IOLSessionType.szm).ios.startSession(
      offerIdentifier: '<yourIdentifier>', type: IOLPrivacyType.ack
    );

    await Future.delayed(const Duration(seconds: 2));
    await InfonlineLibrary.instance.session(IOLSessionType.szm).setCustomConsent('FF00800000');

    await Future.delayed(const Duration(seconds: 2));
    await InfonlineLibrary.instance.session(IOLSessionType.szm).logViewEvent(
      type: IOLViewEventType.appeared,
      category: '<category>'
    );

    //List<String> logs = await InfonlineLibrary.instance.ios.mostRecentLogs(0);
    //print('InfonlineLibrary Logs: ${logs.join("\n\n")}');
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Infonline Plugin'),
        ),
        body: const Center(
          child: Text('Running'),
        ),
      ),
    );
  }
}
