import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcnd_mobile/di/providers.dart';
import 'package:mcnd_mobile/ui/settings/settings_model.dart';
import 'package:mcnd_mobile/ui/shared/hooks/use_once.dart';

class SettingsScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final viewmodel = useProvider(settingsViewModelProvider);
    useOnce(() => viewmodel.load());
    final state = useProvider(settingsViewModelProvider.state);
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(
          'Settings',
          maxLines: 1,
          maxFontSize: 30,
          minFontSize: 15,
        ),
      ),
      body: Builder(
        builder: (context) {
          if (state == null) {
            return Container();
          }

          return ListView(
            children: [
              const SettingsHeader(text: 'Azan Notifications'),
              ...state.azanSettingsItems.map((e) => SettingsItem(
                    item: e,
                    options: state.azanSettingsOptions,
                  )),
            ],
          );
        },
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
  final AzanSettingsItem item;
  final List<String> options;

  const SettingsItem({
    required this.item,
    required this.options,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      title: Text(item.salahName),
      subtitle: Text(options[item.selectedSetting]),
    );
  }
}
