import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/main.dart';
import 'package:settings_ui/settings/RadioButton.dart';
import 'package:settings_ui/util/ColorPicker.dart';
import 'package:settings_ui/settings/SettingSection.dart';
import 'package:settings_ui/settings/SettingsList.dart';
import 'package:settings_ui/settings/SettingsTiles.dart';

enum RadioButtonOptions { op1, op2, op3 }

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool tileManager = true;
  var initialRadioChoice = RadioButtonOptions.op2;
  var checkBoxManager = true;
  Color? iconColor = Colors.grey[600];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: BeveledRectangleBorder(),
        toolbarHeight: 60,
        title: Center(child: const Text('Settings UI')),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SafeArea(
          child: settingsList(),
        ),
      ),
    );
  }

  Widget settingsList() {
    return SettingsList(
      sections: [
        TilesSection(
          title: 'General',
          tiles: [
            SettingsTile(
              onPressed: (_) {
                Navigator.of(context).pop();
              },
              title: 'Back to home screen',
              leading: Icon(CupertinoIcons.back, color: iconColor),
            ),
            SettingsTile(
              title: 'Language',
              leading: Icon(Icons.language, color: iconColor),
              trailing: languageTrailing(),
            ),
            SettingsTile.switchTile(
              title: 'Stop Push Notification',
              leading: Icon(CupertinoIcons.bell, color: iconColor),
              switchActiveColor: Theme.of(context).accentColor,
              switchValue: tileManager,
              onToggle: toggleDarkMode,
            ),
          ],
        ),
        TilesSection(
          title: 'UI',
          tiles: [
            SettingsTile(
              trailing: Icon(
                CupertinoIcons.forward,
                color: iconColor,
              ),
              title: ' Accent Color',
              leading: Icon(
                Icons.color_lens_outlined,
                color: iconColor,
              ),
              onPressed: (_) {
                showPrimaryColorPicker();
              },
            ),
            SettingsTile.switchTile(
              title: ' Dark Mode',
              leading: Icon(CupertinoIcons.cloud_sun, color: iconColor),
              switchActiveColor: Theme.of(context).accentColor,
              switchValue: tileManager,
              onToggle: toggleDarkMode,
            ),
            SettingsTile.checkListTile(
              leading: Icon(EvaIcons.clock, color: iconColor),
              onChanged: onCheckChanged,
              enabled: checkBoxManager,
              title: 'Slow Down Animations',
            ),
          ],
        ),
        RadioButtonSection(
          title: 'Subscription',
          tiles: [
            RadioButton(
              label: 'Monthly',
              value: RadioButtonOptions.op1,
              groupValue: initialRadioChoice,
              onChanged: onRadioChanged,
            ),
            RadioButton(
              label: 'Yearly',
              value: RadioButtonOptions.op2,
              groupValue: initialRadioChoice,
              onChanged: onRadioChanged,
            ),
            RadioButton(
              label: 'Life Time',
              value: RadioButtonOptions.op3,
              groupValue: initialRadioChoice,
              onChanged: onRadioChanged,
            ),
          ],
        ),
        TilesSection(
          title: 'Security',
          tiles: [
            SettingsTile(
              title: 'Change Account Password',
              trailing: Icon(
                CupertinoIcons.forward,
                color: iconColor,
              ),
              leading: Icon(
                Icons.lock,
                color: iconColor,
              ),
              onPressed: (_) {
                showPrimaryColorPicker();
              },
            ),
            SettingsTile(
              title: 'Change Phone Number',
              trailing: Icon(
                CupertinoIcons.forward,
                color: iconColor,
              ),
              leading: Icon(
                Icons.phone,
                color: iconColor,
              ),
              onPressed: (_) {
                showPrimaryColorPicker();
              },
            ),
            SettingsTile(
              title: 'Remove Biometric',
              trailing: Icon(
                CupertinoIcons.forward,
                color: iconColor,
              ),
              leading: Icon(
                Icons.face_unlock_outlined,
                color: iconColor,
              ),
              onPressed: (_) {
                showPrimaryColorPicker();
              },
            ),
          ],
        ),
        TilesSection(
          title: 'Others',
          tiles: [
            SettingsTile.switchTile(
              title: 'Remind me to code',
              leading: Icon(CupertinoIcons.book, color: iconColor),
              switchActiveColor: Theme.of(context).accentColor,
              switchValue: tileManager,
              onToggle: toggleDarkMode,
            ),
          ],
        ),
      ],
    );
  }

  Future<void> toggleDarkMode(bool value) async {
    doSomething(value);
    settingUI.isDarkMode = value;
    tileManager = !tileManager;
    settingUI.callSetState();

    // });
  }

  Widget languageTrailing() {
    return PopupMenuButton(
      icon: Icon(Icons.arrow_drop_down, color: Theme.of(context).accentColor),
      iconSize: 30,
      onSelected: doSomething,
      itemBuilder: (_) => supportedLanguages
          .map(
            (e) => PopupMenuItem(
              value: e,
              child: Text(e.name),
            ),
          )
          .toList(),
    );
  }

  final supportedLanguages = <LanguageData>[
    LanguageData('🇺🇸', 'English', 'en'),
    LanguageData('in', 'Hindi', 'hi'),
  ];

  void doSomething(value) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 1),
        content: Text('You did something'),
      ),
    );
  }

  void onTileChanged(bool? value) {
    doSomething(value);

    setState(() {
      tileManager = !tileManager;
    });
  }

  void onCheckChanged(bool? value) {
    doSomething(value);

    setState(() {
      checkBoxManager = !checkBoxManager;
    });
  }

  void onRadioChanged(value) {
    doSomething(value);
    setState(() {
      initialRadioChoice = value;
    });
  }

  Future<void> showPrimaryColorPicker() async {
    final status = await showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => MyAlertDialog(
            title: const Text('Pick Color'),
            content: SingleChildScrollView(
              child: ColorPicker(
                availableColors: appColors,
                pickerColor: Colors.deepOrangeAccent,
                onColorChanged: (value) async {
                  settingUI.uiColor = value;
                  settingUI.callSetState();
                },
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Done'),
              ),
            ],
          ),
        ) ??
        false;
    if (status) {}
  }
}

class LanguageData {
  LanguageData(this.flag, this.name, this.languageCode);

  final String flag;
  final String name;
  final String languageCode;
}

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog({
    required this.content,
    required this.title,
    this.actions,
    Key? key,
  }) : super(key: key);

  final Widget title;
  final List<Widget>? actions;
  final Widget content;

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Center(child: title),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).iconTheme.color!.withOpacity(0.1),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        content: content,
        actions: actions,
      );
}

List<Color> appColors = <Color>[
  Colors.red,
  Colors.redAccent,
  Colors.pink,
  Colors.pinkAccent,
  Colors.purple,
  Colors.purpleAccent,
  Colors.deepPurple,
  Colors.deepPurpleAccent,
  Colors.indigo,
  Colors.indigoAccent,
  Colors.blue,
  Colors.blueAccent,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.orange,
  Colors.deepOrange,
  Colors.deepOrangeAccent,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
  const Color(0xFF006270),
  const Color(0xFFFF7582),
  const Color(0xFF355C7D),
  const Color(0xFFF64668),
  const Color(0xFFfd9400),
];
