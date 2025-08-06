import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/domain/models/mock/build_mock_models.dart';
import 'package:vintage_1020/providers/inventory_provider.dart';
import 'package:vintage_1020/ui/core/ui/widgets/inventory_carousel/inventory_carousel.dart';

class InventoryOverviewTab extends ConsumerWidget {
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final items = ref.watch(inventoryNotifierProvider);
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;

    return Column(
      children: [
        items.isEmpty? 
        const Center(child: 
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(style: TextStyle(fontSize: 32), 'No items in inventory. Click the '),
              Icon(color: Colors.blue, Icons.add_circle_outline, size: 48),
              Text(style: TextStyle(fontSize: 32),' button to add an item.'),
            ],
          ))
          : 
          SearchBar(
            onChanged: (String value) => [],
            leading: const Icon(Icons.search),
            hintText: 'Search',
          ),
          InventoryCarousel(
            models: items,
            height: height / 2,
            width: width,
            flexWeights: [1, 2, 1],
          ),
      ],
    );
  }
}
