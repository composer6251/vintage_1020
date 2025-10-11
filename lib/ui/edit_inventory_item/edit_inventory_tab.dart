import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/data/providers/current_inventory_item/current_inventory_item.dart';
import 'package:vintage_1020/ui/core/ui/widgets/inventory_carousel/inventory_carousel.dart';

class EditItemTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(currentInventoryItemProvider);
  
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('Return to inventory'),)
      ],),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 3,
            child: InventoryCarousel(
              inventoryItems: [item],
              flexWeights: [3],
            ),
          ),
        ],
      ),
    );
  }
}
