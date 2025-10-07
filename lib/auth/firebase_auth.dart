import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

// Register a new user
Future<User?> signUp(String email, String password) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    print("User registered: ${userCredential.user?.uid}");
    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
    // Handle other errors
    return null;
  }
}

// Sign in an existing user
Future<User?> signIn(String email, String password) async {
  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    print("User signed in: ${userCredential.user?.uid}");
    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
    // Handle other errors
    return null;
  }
}

// Sign out
Future<void> signOut() async {
  await _auth.signOut();
  print("User signed out.");
}

// Sign in anonymously
Future<User?> signInAnonymously() async {
  try {
    UserCredential userCredential = await _auth.signInAnonymously();
    print("Signed in anonymously: ${userCredential.user?.uid}");
    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case 'operation-not-allowed':
        print("Anonymous auth hasn't been enabled for this project.");
      default:
        print("Unknown error: $e");
    }
    return null;
  }
}

