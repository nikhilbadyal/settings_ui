import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/SettingsScreen.dart';
import 'package:settings_ui/util/ThemeData.dart';

void main() {
  runApp(MyApp());
}

late _MyAppState settingUI;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color uiColor = Colors.deepOrangeAccent;
  bool isDarkMode = true;

  void callSetState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    settingUI = this;
    return MaterialApp(
      title: 'Settings UI',
      theme: isDarkMode ? blackTheme(uiColor) : lightTheme(uiColor),
      home: SettingsScreen(),
    );
  }
}
