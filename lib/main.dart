import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_screen.dart';
import 'package:settings_ui/util/theme_data.dart';

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
  Color primaryColor = Colors.blueAccent;
  Color accentColor = Colors.blueAccent;
  bool isDarkMode = true;

  void callSetState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    settingUI = this;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Settings UI',
      theme: isDarkMode
          ? blackTheme(primaryColor, accentColor)
          : lightTheme(primaryColor, accentColor),
      home: const SettingsScreen(),
    );
  }
}
