import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vintage_1020/ui/auth_gate/user_auth_gate.dart';
import 'package:vintage_1020/ui/core/ui/widgets/dialog/edit_inventory_item_dialog.dart';
import 'package:vintage_1020/ui/edit_inventory_item/edit_inventory_tab.dart';

import 'firebase_options.dart';

import 'package:vintage_1020/utils/globals.dart' as globals;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
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
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /***KEY TO ACCESS BUILD CONTEXT THROUGHOUT APP FOR SNACKBARS...ETC */
      scaffoldMessengerKey: globals.scaffoldKey,
      debugShowCheckedModeBanner: false,
      title: 'Vintage 1020',
      theme: ThemeData(
        dividerTheme: DividerThemeData(
          space: 50,
          thickness: 2,
          color: Colors.blue,
          indent: 20,
          endIndent: 20,
          radius: BorderRadius.circular(8.0)
        ),
        colorScheme: const ColorScheme.light(
          primary: Colors.blue, // Date pickersubmit, tab bar selected button color, label text
          secondary: Colors.black, 
          primaryContainer: Color.fromARGB(149, 82, 1, 1),
          secondaryContainer: Color.fromARGB(1, 167, 34, 34),
          // surface: Colors.red, // Background color
          onSurface: Colors.black, // Search bar text color
          onPrimary: Colors.white,
        ),
      ),
      routes: <String, WidgetBuilder>{
        // TODO Leaving if we need routes instead of tabs
        // '/inventory': (BuildContext context) => InventoryCarousel(),
        // '/manage-inventory': (BuildContext context) => HomeScreen(),
        // '/edit-inventory-item': (BuildContext context) =>  EditInventoryItemDialog(),
      },
      home: const UserAuthGate(),
    );
  }
}
