import 'package:flutter/material.dart';
import 'package:mukuru_app/app_blocs.dart';
import 'package:mukuru_app/app_repositories.dart';
import 'package:mukuru_app/ui/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var appConfig = const AppRepositories(
    appBlocs: AppBlocs(
      app: MyApp(),
    ),
  );
  runApp(appConfig);
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
