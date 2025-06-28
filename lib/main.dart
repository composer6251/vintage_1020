import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/ui/auth_gate/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';
import 'package:vintage_1020/ui/edit_inventory_item/edit_inventory_item_screen.dart';
import 'package:vintage_1020/ui/landing_inventory/landing_inventory_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    // setPathUrlStrategy();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // INITIALIZE Firestore persistence
    FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);
  } else {
    await Firebase.initializeApp();
  }
  // Wrap entire app in ProviderScope to use RiverPod
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vintage 1020',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          secondary: Colors.white70,
          surface: Color(0xFF1A237E),
          onSurface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A237E),
          elevation: 0,
        ),
      ),
      routes: <String, WidgetBuilder>{
        // '/inventory': (BuildContext context) => InventoryCarousel(),
        '/manage-inventory': (BuildContext context) => LandingInventoryScreen(),
        '/edit-inventory-item': (BuildContext context) =>
            const EditInventoryItemScreen(),
      },
      home: AuthGate(),
      
    );
  }
}
