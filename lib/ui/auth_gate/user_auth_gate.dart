import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:vintage_1020/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/providers/user_provider/user_provider.dart';
import 'package:vintage_1020/ui/landing_screen/landing_screen.dart';
import 'dart:async';
// Your HomeScreen

// Change StatelessWidget to ConsumerStatefulWidget
class UserAuthGate extends ConsumerStatefulWidget {
  // <-- IMPORTANT CHANGE
  const UserAuthGate({super.key});

  @override
  ConsumerState<UserAuthGate> createState() => _AuthGateState(); // <-- IMPORTANT CHANGE
}

// Change State to ConsumerState
class _AuthGateState extends ConsumerState<UserAuthGate> {
  // <-- IMPORTANT CHANGE
  StreamSubscription<User?>? _authStateSubscription;
  bool _apiCallTriggeredForCurrentUser = false;

  @override
  void initState() {
    super.initState();

    // The 'ref' is available in ConsumerState, allowing you to interact with providers.
    // We use ref.read() here because we are *triggering an action*, not watching for changes.
    // Watching happens in the build method of ConsumerWidgets/ConsumerStatefulWidgets,
    // or through ref.listen.
    _authStateSubscription = FirebaseAuth.instance.authStateChanges().listen((
      user,
    ) async {
      if (user != null && !_apiCallTriggeredForCurrentUser) {
        print(
          'User ${user.email} is signed in! Triggering API call via Riverpod.',
        );
        _apiCallTriggeredForCurrentUser =
            true; // Set flag to prevent re-triggering
        ref.read(userNotifierProvider.notifier).setUserEmail(user.email!);
        String userEmail = ref.read(userNotifierProvider).userEmail;
        print(userEmail);

        // Trigger the API call on your Riverpod provider
        // We read the notifier, then call its method
        // await ref
        //     .read(inventoryNotifierProvider.notifier)
        //     .fetchUserInventory(user.email!);
        
      } else if (user == null) {
        print('User signed out. Clearing API data in Riverpod.');
        _apiCallTriggeredForCurrentUser = false; // Reset flag for next login

        // Clear any user-specific data from your providers when the user logs out
        // ref.read(inventoryNotifierProvider.notifier).clearUserInventory();
      }
    });
  }

  @override
  void dispose() {
    _authStateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The build method primarily manages the UI based on auth state
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // If no user is logged in, show the FirebaseUI SignInScreen
          return SignInScreen(
            providers: [EmailAuthProvider()],
            headerBuilder: (context, constraints, shrinkOffset) {
              return AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset('resources/branding/booth-August.jpeg'),
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text('Welcome, please sign in!')
                    : const Text('Welcome, please sign up!'),
              );
            },
            footerBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'By signing in, you agree to our terms and conditions.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
          );
        } else {
          // If a user is logged in, show the main application screen
          // Your HomeScreen can now *watch* the userSpecificDataProvider
          return LandingScreen();
        }
      },
    );
  }
}
