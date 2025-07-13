import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/ui/auth_gate/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';
import 'package:vintage_1020/ui/edit_inventory_item/edit_inventory_tab.dart';
import 'package:vintage_1020/ui/home_screen/home_screen.dart';

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
        colorScheme: const ColorScheme.light(
          // primary: Colors.white, // Date pickersubmit, tab bar selected button color
          secondary: Colors.black,
          primaryContainer: Colors.red,
          secondaryContainer: Colors.redAccent, 
          surface: Colors.white, // Background color
          onSurface: Colors.black, // Search bar text color
          onPrimary: Colors.black,
        ),
      ),
      routes: <String, WidgetBuilder>{
        // '/inventory': (BuildContext context) => InventoryCarousel(),
        '/manage-inventory': (BuildContext context) => HomeScreen(),
        '/edit-inventory-item': (BuildContext context) =>  EditItemTab(),
      },
      home: AuthGate(),
    );
  }
}
