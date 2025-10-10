import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/domain/inventory_item/inventory_item.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/ui/core/ui/widgets/inventory_carousel/inventory_carousel.dart';

class EditItemTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final InventoryItemLocal inventory = ref.watch(inventoryLocalProvider).first;
    final String? primaryImageUrl = inventory.primaryImageUrl;

    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
  
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InventoryCarousel(
            inventoryItems: [inventory],
            flexWeights: [3],
          ),
          // InventoryCarousel(
          //   inventoryItems: [inventory],
          //   flexWeights: [1, 2, 1],
          // ),
        ],
      ),
    );
  }
}
