import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/ui/core/ui/util/image_util.dart';
import 'package:vintage_1020/ui/core/ui/widgets/inventory_carousel/hero_card.dart';

class InventoryCarousel extends ConsumerStatefulWidget {
  const InventoryCarousel({
    super.key,
    required this.inventoryItems,
    // required this.width,
    // required this.height,
    required this.flexWeights,
  });
  final List<InventoryItemLocal> inventoryItems;
  // final double width;
  // final double height;
  final List<int> flexWeights;



  @override
  ConsumerState<InventoryCarousel> createState() => _InventoryCarouselState();
}

class _InventoryCarouselState extends ConsumerState<InventoryCarousel> {

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    final List<InventoryItemLocal> inventory = ref.watch(inventoryLocalProvider);
    return 
        ConstrainedBox(
          // constraints: BoxConstraints.expand(),
          constraints: BoxConstraints(minHeight: height, maxHeight: height),
          child: 
          CarouselView.weighted(
            // controller: controller,
            itemSnapping: true,
            flexWeights: widget.flexWeights,
            children: inventory
                .map(
                  (i) => HeroLayoutCard(
                    item: i,
                    // height: widget.height,
                    // width: widget.width,
                  ),
                )
                .toList(),
          ),
       );

  }
}
