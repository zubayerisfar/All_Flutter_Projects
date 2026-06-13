import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthSyncPage extends StatefulWidget {
  const AuthSyncPage({super.key});

  @override
  State<AuthSyncPage> createState() => _AuthSyncPageState();
}

class _AuthSyncPageState extends State<AuthSyncPage> {
  // 1. Instantiate the async version locally. No cache involved.
  final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
  
  String sessionToken = 'Fetching from disk...';

  @override
  void initState() {
    super.initState();
    _loadToken(); // Fetch from physical disk when page opens
  }

  // 2. Reading requires 'await' because it travels to the device's hard drive
  Future<void> _loadToken() async {
    final token = await asyncPrefs.getString('session_token');
    setState(() {
      sessionToken = token ?? 'Not logged in';
    });
  }

  // 3. Writing also goes straight to the hard drive
  Future<void> _login() async {
    final newToken = 'token_${DateTime.now().millisecondsSinceEpoch}';
    await asyncPrefs.setString('session_token', newToken);
    _loadToken(); // Refresh the UI to show the new token
  }

  Future<void> _logout() async {
    await asyncPrefs.remove('session_token');
    _loadToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auth (Async)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Current Token:\n$sessionToken', textAlign: TextAlign.center),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Simulate Login (Write to Disk)'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _logout,
              child: const Text('Simulate Logout (Delete from Disk)'),
            ),
          ],
        ),
      ),
    );
  }
}