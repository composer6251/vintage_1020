import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/data/providers/firestore_provider/firestore_provider.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart'
    hide userEmail;
import 'package:vintage_1020/data/providers/my_booth_provider/my_booths_notifier.dart';

class MyBoothsAppBar extends ConsumerWidget {
  @override
  AppBar build(BuildContext context, WidgetRef ref) {
    FirebaseAuth auth = FirebaseAuth.instance;
    void deleteAllInventory() {
      ref.read(inventoryLocalProvider.notifier).deleteUserInventoryByEmail();
    }

    void deleteAllBooths() {
      ref.read(myBoothsProvider.notifier).deleteUserBooths();
    }

    return AppBar(
      actions: [
        IconButton(
          onPressed: deleteAllInventory,
          icon: Icon(Icons.delete_forever_sharp),
        ),
        IconButton(
          onPressed: deleteAllBooths,
          icon: Icon(Icons.delete_forever_sharp),
        ),
        IconButton(onPressed: auth.signOut, icon: Icon(Icons.logout_outlined)),
      ],
      backgroundColor: Colors.blue,
      title: Text(
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        'Welcome, $userEmail!!',
      ),
    );
  }
}
