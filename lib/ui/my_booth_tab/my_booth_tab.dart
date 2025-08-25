import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/data/api/b_t_api/b_t_api.dart';
import 'package:vintage_1020/domain/models/model/inventory_item/inventory_item.dart';
import 'package:vintage_1020/providers/inventory/inventory.dart';
import 'package:vintage_1020/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/providers/user_provider/user_provider.dart';
import 'package:vintage_1020/ui/core/ui/widgets/inventory_carousel/inventory_carousel.dart';

class MyBoothTab extends ConsumerWidget {

  void getInventoryByEmail(String userEmail) {
    getInventoryByUserEmail(userEmail).then((items) {
      if (items != null) {
        // ref.read(inventoryNotifierProvider.notifier).buildUserInventory(items.whereType<InventoryItem>().toList());
        print(items);
      }
    });
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    final inventoryItems = userEmail != null
        ? ref.watch(getUserInventoryProvider(userEmail: userEmail))
        : const AsyncValue.data([]);
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    
    // TODO implement actual inventory item stream
    // getInventoryItemStream().map((event) => {print(event)});

    return Scaffold(
        body: inventoryItems.when(
          error: (err, stack) => Text('Error $err'),
          loading: () => const Center(child: CircularProgressIndicator()),
          data: (items) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              InventoryCarousel(
                width: width,
                height: height * .40,
                flexWeights: [3],
              ),
              InventoryCarousel(
                width: width,
                height: height * .25,
                flexWeights: [1, 2, 1],
              ),
              // TextButton(onPressed:() => getInventoryByEmail(userEmail), child: Text('Refresh Inventory'))
            ],
          );
        }
    ));
  }
}
