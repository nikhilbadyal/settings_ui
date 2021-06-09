import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/SettingsScreen.dart';
import 'package:settings_ui/util/ThemeData.dart';

void main() {
  runApp(const MyApp());
}

late _MyAppState settingUI;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color uiColor = Colors.deepOrangeAccent;
  bool isDarkMode = false;

  void callSetState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    settingUI = this;
    debugPrint(isDarkMode.toString());
    return MaterialApp(
      title: 'Settings UI',
      theme: isDarkMode ? blackTheme(uiColor) : lightTheme(uiColor),
      home: const SettingsScreen(),
    );
  }
}
