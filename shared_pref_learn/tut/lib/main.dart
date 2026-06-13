import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'page/home_page.dart';

void main() async {
  // Ensure Flutter engine is ready to talk to the native disk
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Initialize the cache BEFORE the app starts
  final prefsWithCache = await SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(
      allowList: <String>{'theme_mode'}, // We only want the theme in RAM
    ),
  );

  // Pass the loaded cache directly into the app
  runApp(MyApp(prefsWithCache: prefsWithCache));
}

class MyApp extends StatefulWidget {
  final SharedPreferencesWithCache prefsWithCache;
  const MyApp({super.key, required this.prefsWithCache});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 2. Synchronous Read! Instantly grabs the value from RAM. No 'await' needed.
  late bool isDarkMode = widget.prefsWithCache.getBool('theme_mode') ?? false;

  // 3. The callback function to change the theme
  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
    // Save the new choice to the disk in the background
    widget.prefsWithCache.setBool('theme_mode', isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preferences Tutorial',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      
      // 4. Pass the cache and the toggle function down to the Home Page
      home: HomePage(
        prefsWithCache: widget.prefsWithCache, 
        onThemeChanged: toggleTheme,
      ),
    );
  }
}