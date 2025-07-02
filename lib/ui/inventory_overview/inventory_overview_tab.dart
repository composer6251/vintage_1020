import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
