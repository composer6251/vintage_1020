import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/ui/core/ui/util/image_util.dart';
import 'package:vintage_1020/ui/core/ui/widgets/inventory_carousel/hero_card.dart';

class BoothInventoryCarousel extends ConsumerStatefulWidget {
  BoothInventoryCarousel({
    super.key,
    required this.inventoryItems,
    required this.flexWeights,
  });
  final List<InventoryItemLocal> inventoryItems;
  final List<int> flexWeights;

  @override
  ConsumerState<BoothInventoryCarousel> createState() => _InventoryCarouselState();
}

class _InventoryCarouselState extends ConsumerState<BoothInventoryCarousel> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    print('INVENTORY CAROUSEL WIDGET Inventory size ${widget.inventoryItems.length}');

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: height, maxHeight: height),
      child: CarouselView.weighted(
        itemSnapping: true,
        flexWeights: widget.flexWeights,
        children: widget.inventoryItems
            .map(
              (i) => HeroLayoutCard(
                item: i,
              ),
            )
            .toList(),
      ),
    );
  }
}
