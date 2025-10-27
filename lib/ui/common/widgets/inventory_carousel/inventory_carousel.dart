import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/ui/common/widgets/inventory_carousel/widgets/inventory_item_image_widget.dart';

class InventoryItemCarousel extends HookConsumerWidget {
  InventoryItemCarousel({
    super.key,
    required this.inventoryItems,
    required this.flexWeights,
  });
  final List<InventoryItemLocal> inventoryItems;
  final List<int> flexWeights;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return CarouselView.weighted(
      itemSnapping: true,
      flexWeights: flexWeights,
      children: inventoryItems
          .map(
            (itemUrl) => InventoryItemImage(
              item: itemUrl,
            ),
          )
          .toList(),
    );
  }
}
