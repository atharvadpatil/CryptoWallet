import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
