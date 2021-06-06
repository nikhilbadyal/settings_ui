# Settings UI for Flutter


<p align="center">
  <img src="https://i.imgur.com/cSWCUsd.png" height="250px">
  <img src="https://i.imgur.com/N7dSrF9.png" height="250px">
  <img src="https://i.imgur.com/4POezmu.png" height="250px">
</p>



## Basic Usage:
```dart
      SettingsList(
        sections: [
          SettingsSection(
            title: 'Section',
            tiles: [
              SettingsTile(
                title: 'Language',
                subtitle: 'English',
                leading: Icon(Icons.language),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                title: 'Use fingerprint',
                leading: Icon(Icons.fingerprint),
                switchValue: value,
                onToggle: (bool value) {},
              ),
            ],
          ),
        ],
      )
```
<br>
<br>
