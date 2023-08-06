import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:budget/auth.dart';
import 'package:budget/pages/database.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      User? user = userCredential.user;
      if (user != null) {
        String displayName = user.displayName ?? '@username';
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
          arguments: displayName,
        );
      }
    } catch (e) {
      await Future.delayed(const Duration(seconds: 1));
      print("Error during login: $e");
    }
  }

  Future<void> _register() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      User? user = userCredential.user;
      if (user != null) {
        String displayName = user.displayName ?? '@username';
        // Here you can add a dummy data to Firestore using the DatabaseService
        await DatabaseService(uid: user.uid)
            .updateUserData('movie', 500); // Change these values as needed
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/',
          (route) => false,
          arguments: displayName,
        );
      }
    } catch (e) {
      await Future.delayed(const Duration(milliseconds: 300));
      print("Error during registration: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login/Register Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _register,
              child: const Text('Register'),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
