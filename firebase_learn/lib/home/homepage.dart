import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => FirebaseAuth.instance.signOut(), // ✅ sign out
            tooltip: 'Sign Out',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Logged in as:\n${user?.email}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            // email verified badge
            Text(
              user?.emailVerified == true ? '✅ Email Verified' : '⚠️ Email Not Verified',
              style: TextStyle(
                color: user?.emailVerified == true ? Colors.green : Colors.orange,
              ),
            ),
            const SizedBox(height: 20),
            // resend verification if not verified
            if (user?.emailVerified == false)
              ElevatedButton(
                onPressed: () async {
                  await user?.sendEmailVerification();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Verification email sent!')),
                  );
                },
                child: const Text('Resend Verification Email'),
              ),
          ],
        ),
      ),
    );
  }
}