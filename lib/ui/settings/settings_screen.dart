import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(
          'Settings',
          maxLines: 1,
          maxFontSize: 30,
          minFontSize: 15,
        ),
      ),
      body: ListView(
        children: const [
          SettingsHeader(text: 'Azan Notifications'),
          SettingsItem(
            text: 'Fajr',
            subtext: 'Short Azan',
          ),
          SettingsItem(
            text: 'Sunrise',
            subtext: 'Silent Notification',
          ),
          SettingsItem(
            text: 'Zuhr',
            subtext: 'Short Azan',
          ),
          SettingsItem(
            text: 'Asr',
            subtext: 'Short Azan',
          ),
          SettingsItem(
            text: 'Maghrib',
            subtext: 'Short Azan',
          ),
          SettingsItem(
            text: 'Isha',
            subtext: 'Short Azan',
          ),
        ],
      ),
    );
  }
}

class SettingsHeader extends StatelessWidget {
  final String text;

  const SettingsHeader({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0).copyWith(bottom: 0),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xff818181),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final String text;
  final String subtext;

  const SettingsItem({
    required this.text,
    required this.subtext,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog<void>(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return Dialog(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                        child: Text(
                          'Fajr Notification',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      RadioListTile<int>(
                        value: 0,
                        groupValue: 1,
                        onChanged: (value) {},
                        title: const Text('No notification'),
                      ),
                      RadioListTile<int>(
                        value: 1,
                        groupValue: 1,
                        onChanged: (value) {},
                        title: const Text('Silent notification'),
                      ),
                      RadioListTile<int>(
                        value: 0,
                        groupValue: 1,
                        onChanged: (value) {},
                        title: const Text('Short Azan'),
                      ),
                      RadioListTile<int>(
                        value: 0,
                        groupValue: 1,
                        onChanged: (value) {},
                        title: const Text('Full Azan'),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      ButtonBar(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text('Ok'),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Cancel'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
        title: Text(text),
        subtitle: Text(subtext),
      ),
    );
  }
}
