import 'firebase_authentication.dart';
import 'package:flutter/material.dart';
import 'verify_email.dart';
import 'login.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuthentication().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Something went wrong');
        } else if (snapshot.hasData) {
          return VerifyEmail();
        } else {
          return Login();
        }
      },
    );
  }
}