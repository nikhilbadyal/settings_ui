import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keepsettings/keepsettings.dart';
import 'package:settings_ui/main.dart';
import 'package:settings_ui/util/color_picker.dart';

enum RadioButtonOptions { op1, op2, op3 }

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool tileManager = settingUI.isDarkMode;
  var initialRadioChoice = RadioButtonOptions.op2;
  var checkBoxManager = true;

  // Color iconColor = Colors.black;
  double sliderCurVal = 20;
  var initialValue = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Settings UI')),
      ),
      body: SafeArea(
        child: settingsList(),
      ),
    );
  }

  Widget settingsList() {
    return SettingsList(
      sections: [
        TilesSection(
          title: 'Tiles',
          tiles: [
            SettingsTile(
              title: 'Language',
              leading: const Icon(Icons.language),
              trailing: languageTrailing(),
            ),
            SettingsTile.switchTile(
              title: 'Stop Push Notification',
              leading: const Icon(CupertinoIcons.bell),
              switchActiveColor: Theme.of(context).colorScheme.secondary,
              switchValue: tileManager,
              onToggle: toggleDarkMode,
            ),
            SettingsTile(
              trailing: const Icon(
                CupertinoIcons.forward,
              ),
              title: 'Primary Color',
              leading: const Icon(
                Icons.color_lens_outlined,
              ),
              onPressed: (_) {
                colorPicker(primaryColors, onPrimaryColorChange);
              },
            ),
            SettingsTile(
              trailing: const Icon(
                CupertinoIcons.forward,
              ),
              title: ' Accent Color',
              leading: const Icon(
                Icons.color_lens_outlined,
              ),
              onPressed: (_) {
                colorPicker(accentColors, onAccentColorChange);
              },
            ),
            SettingsTile.switchTile(
              title: ' Dark Mode',
              subtitle: 'Save your eyes',
              leading: const Icon(CupertinoIcons.cloud_sun),
              switchActiveColor: Theme.of(context).colorScheme.secondary,
              switchValue: tileManager,
              onToggle: toggleDarkMode,
              togglerShape: TogglerShapes.heart,
            ),
            SettingsTile.checkListTile(
              leading: const Icon(EvaIcons.clock),
              onChanged: onCheckChanged,
              enabled: checkBoxManager,
              title: 'Slow Down Animations',
            ),
            SettingsTile(
              onPressed: (_) {
                Navigator.of(context).maybePop();
              },
              title: 'Back to home screen',
              subtitle: 'Home',
              leading: const Icon(CupertinoIcons.back),
            ),
          ],
        ),
        SliderSection(
          slider: SliderTile(
            initialSliderValue: initialValue,
            onSliderChange: (value) {
              setState(() {
                initialValue = value;
              });
            },
            min: 0,
            max: 100,
          ),
          title: 'Slider',
        ),
        RadioButtonSection(
          title: 'Radio Button',
          tiles: [
            RadioButton<RadioButtonOptions>(
              label: 'Monthly',
              value: RadioButtonOptions.op1,
              groupValue: initialRadioChoice,
              onChanged: onRadioChanged,
            ),
            RadioButton<RadioButtonOptions>(
              label: 'Yearly',
              value: RadioButtonOptions.op2,
              groupValue: initialRadioChoice,
              onChanged: onRadioChanged,
            ),
            RadioButton<RadioButtonOptions>(
              label: 'Life Time',
              value: RadioButtonOptions.op3,
              groupValue: initialRadioChoice,
              onChanged: onRadioChanged,
            ),
          ],
        ),
      ],
    );
  }

  // ignore: avoid_positional_boolean_parameters
  Future<void> toggleDarkMode(bool value) async {
    doSomething(value);
    setState(() {
      settingUI.isDarkMode = !settingUI.isDarkMode;
      tileManager = !tileManager;
    });
    settingUI.callSetState();
  }

  Widget languageTrailing() {
    return PopupMenuButton(
      icon: Icon(Icons.arrow_drop_down,
          color: Theme.of(context).colorScheme.secondary),
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

  // ignore: avoid_positional_boolean_parameters
  void onTileChanged(bool? value) {
    doSomething(value);

    setState(() {
      tileManager = !tileManager;
    });
  }

  // ignore: avoid_positional_boolean_parameters
  void onCheckChanged(bool? value) {
    doSomething(value);

    setState(() {
      checkBoxManager = !checkBoxManager;
    });
  }

  void onRadioChanged(RadioButtonOptions? value) {
    doSomething(value);
    setState(() {
      if (value != null) {
        initialRadioChoice = value;
      }
    });
  }

  Future<void> colorPicker(List<Color> appColors, onColorChange) async {
    final status = await showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => MyAlertDialog(
            title: const Text('Pick Color'),
            content: SingleChildScrollView(
              child: ColorPicker(
                availableColors: appColors,
                pickerColor: Colors.deepOrangeAccent,
                onColorChanged: onColorChange,
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

  void onPrimaryColorChange(Color value) {
    setState(() {
      settingUI.primaryColor = value;
    });
    settingUI.callSetState();
  }

  void onAccentColorChange(Color value) {
    setState(() {
      settingUI.accentColor = value;
    });
    settingUI.callSetState();
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

List<Color> primaryColors = <Color>[
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.blue,
  Colors.indigo,
  Colors.cyan,
  Colors.teal,
  Colors.orange,
  Colors.deepOrange,
  Colors.amber,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
  Colors.black,
];

List<Color> accentColors = <Color>[
  Colors.redAccent,
  Colors.pinkAccent,
  Colors.purpleAccent,
  Colors.deepPurpleAccent,
  Colors.blueAccent,
  Colors.indigoAccent,
  Colors.cyanAccent,
  Colors.tealAccent,
  Colors.orangeAccent,
  Colors.deepOrangeAccent,
  Colors.lightBlueAccent,
  Colors.amberAccent,
  const Color(0xFFFF7582),
];
