import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // sign in with email and password
  Future<void> signInWithEmailAndPassword(String email, String password) async {

    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // sign up with email and password
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
    // initialize user information in database
    final database = FirebaseDatabase.instance.ref();
    final user_information = database.child('/users_info/${FirebaseAuth.instance.currentUser!.uid}');
    await user_information.set(
      {
        'black_bins': {
          'added': 0,
          'liked': 0,
          'disliked': 0,
        },
        'green_bins': {
          'added': 0,
          'liked': 0,
          'disliked': 0,
        },
        'yellow_bins': {
          'added': 0,
          'liked': 0,
          'disliked': 0,
        },
        'blue_bins': {
          'added': 0,
          'liked': 0,
          'disliked': 0,
        },
      },
    );
  }

  // sign out
  Future signOut() async {
    await _auth.signOut();
  }
}