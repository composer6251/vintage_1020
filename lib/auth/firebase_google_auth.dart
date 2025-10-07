

// import 'package:firebase_auth/firebase_auth.dart';

// final GoogleSignIn _googleSignIn = GoogleSignIn();



// Future<User?> signInWithGoogle() async {
//   try {
//     // Trigger the authentication flow
//     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

//     if (googleUser == null) {
//       // The user canceled the sign-in
//       return null;
//     }

//     // Obtain the auth details from the request
//     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//     // Create a new credential
//     final OAuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     // Sign in to Firebase with the credential
//     UserCredential userCredential = await _auth.signInWithCredential(credential);
//     print("Signed in with Google: ${userCredential.user?.uid}");
//     return userCredential.user;
//   } on FirebaseAuthException catch (e) {
//     print("Google Sign-in error: $e");
//     return null;
//   } catch (e) {
//     print("General error during Google Sign-in: $e");
//     return null;
//   }
// }
