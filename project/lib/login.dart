import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_authentication.dart';
import 'widget_tree.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? errorMessage = '';
  bool login_selected = true; // true for login, false for sign up

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signIn() async {
    try {
      await FirebaseAuthentication().signInWithEmailAndPassword(
        _controllerEmail.text,
        _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> signUp() async {
    try {
      await FirebaseAuthentication().signUpWithEmailAndPassword(
        _controllerEmail.text,
        _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: const AssetImage('assets/logo.png'),
              width: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 10,
                  height: 1,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 8 / 10,
                  child: TextField(
                    controller: _controllerEmail,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 10,
                  height: 1,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 10,
                  height: 1,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 8 / 10,
                  child: TextField(
                    controller: _controllerPassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 10,
                  height: 1,
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                showDialog(
                  context:context,
                  barrierDismissible: false,
                  builder: (context) => Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  ),
                );
                if (login_selected) {
                  await signIn();
                }
                else {
                  await signUp();
                };
                Navigator.of(context).pop();
              },
              child: login_selected ? const Text('Login', style: TextStyle(color: Colors.white)) : const Text('Sign Up', style: TextStyle(color: Colors.white)),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
            ),
            Text(errorMessage ?? '',
              style: const TextStyle(color: Colors.red),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  login_selected
                      ? "Don't have an account? "
                      : "Already have an account? ",
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      login_selected = !login_selected;
                    });
                  },
                  child: login_selected
                      ? const Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.green,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.green,
                        ),
                      )
                      : const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.green,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.green,
                        ),
                      ),
                ),
              ],
            ),
            // reset password button
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'forgot_password');
              },
              child: const Text(
                'Forgot Password',
                style: TextStyle(
                  color: Colors.green,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}