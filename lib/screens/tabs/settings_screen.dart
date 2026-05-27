import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(children: [
        SwitchListTile(
          value: appState.themeMode == ThemeMode.dark,
          title: const Text('Dark Mode'),
          onChanged: (v) => context.read<AppState>().toggleTheme(v),
        ),
        ListTile(
          title: const Text('Language'),
          subtitle: Text(appState.locale.languageCode == 'hi' ? 'Hindi' : 'English'),
          trailing: DropdownButton<String>(
            value: appState.locale.languageCode,
            items: const [DropdownMenuItem(value: 'en', child: Text('English')), DropdownMenuItem(value: 'hi', child: Text('हिंदी'))],
            onChanged: (v) {
              if (v != null) context.read<AppState>().setLanguage(v);
            },
          ),
        )
      ]),
    );
  }
}
