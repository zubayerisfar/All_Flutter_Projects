import 'package:firebase_learn/email_verification.dart';
import 'package:firebase_learn/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learn/authenticate/login_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          if (snapshot.data!.emailVerified) {
            return HomeScreen();
          } else {
            return EmailVerificationScreen(); // tell user to check email
          }
        }

        return LoginScreen(); // not logged in
      },
    );
  }
}
