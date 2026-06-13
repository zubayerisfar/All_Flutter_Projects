import 'package:flutter/material.dart';
import 'package:animation_full/implicit_animation/container_animation.dart';
import 'package:animation_full/implicit_animation/button_animation.dart';
import 'package:animation_full/implicit_animation/pulsating_animation.dart';
import 'package:animation_full/implicit_animation/tap_drag_animation.dart';
import 'package:animation_full/explicit_animation/login_screen_animation.dart';
import 'package:animation_full/explicit_animation/pulsating_animation_explicit.dart';
import 'package:animation_full/explicit_animation/list_animation.dart';
import 'package:animation_full/explicit_animation/progressbar_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Animation Demo')),
        body: CircularProgressBarDemo(),
      ),
    );
  }
}
