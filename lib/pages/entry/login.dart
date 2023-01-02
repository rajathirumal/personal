import 'package:flutter/material.dart';
import 'package:personal/pages/entry/signup.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUp(),
              ),
            );
          },
          child: RichText(
            text: const TextSpan(
              text: 'New user? Sign up.',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ),
      ),
    );
  }
}
