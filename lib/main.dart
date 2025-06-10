
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/ui/edit_inventory_item/edit_inventory_item_screen.dart';
import 'package:namer_app/ui/manage_inventory/manage_inventory_screen.dart';

void main() {
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      routes: <String, WidgetBuilder> {
      // '/inventory': (BuildContext context) => InventoryCarousel(),
      '/manage-inventory': (BuildContext context) =>  ManageInventoryScreen(),
      '/edit-inventory-item': (BuildContext context) => const EditInventoryItemScreen(),
    },
      home: ManageInventoryScreen(),
    );
  }
}

/****WIDGETS FOR UI
 * CircleAvatar
 */
