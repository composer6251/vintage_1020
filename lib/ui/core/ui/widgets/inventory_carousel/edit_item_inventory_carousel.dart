import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/ui/core/ui/widgets/inventory_carousel/hero_card.dart';

class InventoryCarousel extends ConsumerStatefulWidget {
  InventoryCarousel({
    super.key,
    required this.inventoryItems,
    // Display text
    required this.flexWeights,
  });
  final List<InventoryItemLocal> inventoryItems;
  final List<int> flexWeights;

  @override
  ConsumerState<InventoryCarousel> createState() => _InventoryCarouselState();
}

class _InventoryCarouselState extends ConsumerState<InventoryCarousel> {
  @override
  Widget build(BuildContext context) {
    print('INVENTORY CAROUSEL WIDGET Inventory size ${widget.inventoryItems.length}');

    return CarouselView.weighted(
      itemSnapping: true,
      flexWeights: widget.flexWeights,
      children: widget.inventoryItems
          .map(
            (i) => HeroLayoutCard(
              item: i,
            ),
          )
          .toList(),
    );
  }
}
