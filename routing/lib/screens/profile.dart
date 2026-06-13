import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:routing/widgets/bottom_navbar.dart";

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Screen')),
      body: Column(
        children: [
          Center(child: const Text('This is the Profile Screen')),
          ElevatedButton(
            onPressed: () {
              context.pushNamed('profile-sample');
            },
            child: const Text('Go To Sample View'),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }
}

class SampleViewInsideScaffold extends StatelessWidget {
  const SampleViewInsideScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample Screen')),
      body: Column(
        children: [
          Center(child: const Text('This is the Sample Screen')),
          ElevatedButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('Go Back'),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }
}
