import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/data/model/inventory_item/inventory_item.dart';
import 'package:vintage_1020/domain/api/b_t_api/b_t_api.dart';
import 'package:vintage_1020/ui/core/ui/widgets/inventory_carousel/inventory_carousel.dart';

class MyBoothTab extends ConsumerWidget {
  // void getInventoryByEmail(String userEmail) {
  //   getInventoryByUserEmail(userEmail).then((items) {
  //     if (items != null) {
  //       // ref.read(inventoryNotifierProvider.notifier).buildUserInventory(items.whereType<InventoryItem>().toList());
  //       print(items);
  //     }
  //   });
  // }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final inventoryItems = BuildMockModels.buildEditInventoryItemModels();
    // final inventoryItems = userEmail != null
    //     ? ref.watch(userNotifierProvider.notifier).build(userEmail: userEmail))
    //     : const AsyncValue.data([]);
    // final items = ref
    //     .watch(inventoryNotifierProvider.notifier)
    //     .fetchUserInventory(userEmail);
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          InventoryCarousel(
            width: width,
            height: height * .50,
            flexWeights: [3],
          ),

          InventoryCarousel(
            width: width,
            height: height * .40,
            flexWeights: [1, 2, 1],
          ),
          // TextButton(onPressed:() => getInventoryByEmail(userEmail), child: Text('Refresh Inventory'))
        ],
      ),
    );
  }
}
