import 'dart:isolate';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:mukuru_app/app_blocs.dart';
import 'package:mukuru_app/app_repositories.dart';
import 'package:mukuru_app/ui/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();

  var appConfig = const AppRepositories(
    appBlocs: AppBlocs(
      app: MyApp(),
    ),
  );
  runApp(appConfig);

  AndroidAlarmManager.periodic(const Duration(minutes: 1), 1, printHello);
}

printHello() {
  print('refreshing data');
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exchange App',
      home: SplashScreen(),
    );
  }
}
