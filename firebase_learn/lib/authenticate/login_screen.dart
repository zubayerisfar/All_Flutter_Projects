import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLogin = true;
  String errorMessage = '';
  String successMessage = '';

  Future<void> submit() async {
    setState(() { errorMessage = ''; successMessage = ''; });
    try {
      if (isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      } else {
        UserCredential cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        // send verification email on signup
        await cred.user?.sendEmailVerification();
        setState(() => successMessage = 'Verification email sent! Check your inbox.');
      }
    } on FirebaseAuthException catch (e) {
      setState(() => errorMessage = e.message ?? 'Error occurred');
    }
  }

  Future<void> sendPasswordReset() async {
    if (emailController.text.trim().isEmpty) {
      setState(() => errorMessage = 'Enter your email first');
      return;
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      setState(() => successMessage = 'Password reset email sent!');
    } on FirebaseAuthException catch (e) {
      setState(() => errorMessage = e.message ?? 'Error occurred');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isLogin ? 'Login' : 'Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            if (errorMessage.isNotEmpty)
              Text(errorMessage, style: const TextStyle(color: Colors.red)),
            if (successMessage.isNotEmpty)
              Text(successMessage, style: const TextStyle(color: Colors.green)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: submit,
              child: Text(isLogin ? 'Login' : 'Sign Up'),
            ),
            if (isLogin)
              TextButton(
                onPressed: sendPasswordReset,
                child: const Text('Forgot Password?'),
              ),
            TextButton(
              onPressed: () => setState(() => isLogin = !isLogin),
              child: Text(isLogin
                  ? "Don't have an account? Sign Up"
                  : "Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}