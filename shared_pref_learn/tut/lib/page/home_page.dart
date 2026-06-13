import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_page.dart';
import 'auth_sync_page.dart';

class HomePage extends StatelessWidget {
  final SharedPreferencesWithCache prefsWithCache;
  final VoidCallback onThemeChanged; // The function from main.dart

  const HomePage({
    super.key, 
    required this.prefsWithCache, 
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Local Storage Hub')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SettingsPage(
                    prefsWithCache: prefsWithCache,
                    onThemeChanged: onThemeChanged,
                  ),
                ),
              ),
              child: const Text('Go to Settings (WithCache)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AuthSyncPage()),
              ),
              child: const Text('Go to Auth (Async Playground)'),
            ),
          ],
        ),
      ),
    );
  }
}