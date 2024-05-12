import 'package:flutter/material.dart';
import 'package:projeto_engenharia_software/firebase_options.dart';
import 'map_class.dart';
import 'profile.dart';
import 'search.dart';
import 'login.dart';
import 'widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'forgot_password.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'bin_finder',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      // for test purposes only
      initialRoute: '/widget_tree',
      //

      routes: {
        // '/' : (context) => Loading(),
        '/widget_tree': (context) => WidgetTree(),
        '/login': (context) => Login(),
        '/map': (context) => MapClass(),
        '/profile': (context) => Profile(),
        'forgot_password': (context) => ForgotPassword(),
        '/search': (context) => Search(),
      },
    ),
  );
}
