import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/ui/ui_container/ui_container.dart';

class AuthGate extends HookConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If the user is NOT logged in (snapshot.hasData is false or snapshot.data is null)
        if (!snapshot.hasData) {
          return SignInScreen(
            showAuthActionSwitch: true,
            providers: [
              // This is where you list the authentication providers you want to offer.
              EmailAuthProvider(),
              // If you enabled Google Sign-In, you'd add:
              // GoogleProvider(clientId: "YOUR_WEBCLIENT_ID"), // Replace with your actual Web Client ID if supporting web
            ],
            // Customize the header (top part) of the sign-in screen
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('resources/branding/booth-August.jpeg'),
                ),
              );
            },
            // Customize the subtitle messages (e.g., "Welcome, please sign in!")
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text('Welcome to Vintage 1020, please sign in!')
                    : const Text('Welcome to Vintage 1020, please sign up!'),
              );
            },
            // Customize the footer (bottom part, e.g., terms and conditions)
            footerBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'By signing in, you agree to our terms and conditions.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
            // Add a side panel for larger screens (e.g., web or desktop)
            sideBuilder: (context, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  // Use the same image or a different one for the side panel
                  child: Image.asset('resources/branding/wateree.jpeg'),
                ),
              );
            },
          );
        }
      // Get user credentials:
      // TODO: Add email to SharedPreferences or Hive
      final userEmail = snapshot.data?.email ?? 'No email';
      // getInventoryByUserEmail(userEmail);
      // ref.watch(userNotifierProvider.notifier).setUserEmail(userEmail);
        return UiContainer();
      },
    );
  }
}
