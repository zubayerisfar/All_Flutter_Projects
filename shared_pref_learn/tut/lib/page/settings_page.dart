import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsPage extends StatelessWidget {
  final SharedPreferencesWithCache prefsWithCache;
  final VoidCallback onThemeChanged;

  const SettingsPage({
    super.key, 
    required this.prefsWithCache, 
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Synchronous read! Instantly gets the current state from RAM.
    final isDark = prefsWithCache.getBool('theme_mode') ?? false;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings (Cache)')),
      body: Center(
        child: SwitchListTile(
          title: const Text('Dark Mode'),
          subtitle: const Text('Instantly updates UI and saves to disk in background'),
          value: isDark,
          onChanged: (value) {
            // Trigger the callback that was passed all the way down from main.dart
            onThemeChanged();
          },
        ),
      ),
    );
  }
}