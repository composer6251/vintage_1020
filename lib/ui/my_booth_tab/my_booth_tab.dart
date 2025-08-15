import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/data/api/b_t_api/b_t_api.dart';
import 'package:vintage_1020/providers/inventory_provider.dart';
import 'package:vintage_1020/providers/user_provider.dart';
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
    
    final items = ref.watch(inventoryNotifierProvider);
    final userEmail = ref.read(userNotifierProvider).userEmail;
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    
    // TODO implement actual inventory item stream
    // getInventoryItemStream().map((event) => {print(event)});

    return Scaffold(
      body: Column(
        children: [
          InventoryCarousel(
            models: items,
            width: width,
            height: height * .20,
            flexWeights: [3],
          ),
          InventoryCarousel(
            models: items,
            width: width,
            height: height * .25,
            flexWeights: [1, 2, 1],
          ),
          TextButton(onPressed:() => getInventoryByEmail(userEmail), child: Text('Refresh Inventory'))
        ],
      ),
    );
  }
}
