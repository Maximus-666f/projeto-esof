import 'package:flutter/material.dart';
import 'map_class.dart';
import 'profile.dart';
import 'search.dart';

void main() {
  runApp(
    MaterialApp(
      // for test purposes only
      initialRoute: '/map',
      //

      routes: {
        // '/' : (context) => Loading(),
        // '/login': (context) => Login(),
        '/map': (context) => MapClass(),
        '/profile': (context) => Profile(),
        // '/edit_profile': (context) => EditProfile(),
        '/search': (context) => Search(),
      },
    ),
  );
}
