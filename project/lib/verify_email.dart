import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'map_class.dart';
import 'dart:async';

class VerifyEmail extends StatefulWidget {
  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool is_email_verified = false;

  @override
  void initState() {
    super.initState();

    is_email_verified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!is_email_verified) {
      FirebaseAuth.instance.currentUser!.sendEmailVerification();

      Timer.periodic(
        Duration(seconds: 5),
        (timer) async {
          await FirebaseAuth.instance.currentUser!.reload();
          if (FirebaseAuth.instance.currentUser!.emailVerified) {
            setState(() {
              is_email_verified = true;
            });
            timer.cancel();
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return is_email_verified ? MapClass() : Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 10,
                      height: 1,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 8 / 10,
                      child: Center(
                        child: Text(
                          'Verify Email',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 10,
                      height: 1,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'A verification email has been sent to your email address. Please verify your email address to continue.',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance.currentUser?.sendEmailVerification();
                      },
                      child: Text('Resend Verification Email'),
                    ),
                    // sign out button
                    ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
  }
}
