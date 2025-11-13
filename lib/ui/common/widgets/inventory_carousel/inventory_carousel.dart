import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/data/providers/my_booth_filter/current_booth_provider.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';
import 'package:vintage_1020/ui/common/widgets/inventory_carousel/widgets/inventory_item_image_widget.dart';

class InventoryItemCarousel extends HookConsumerWidget {
  InventoryItemCarousel({
    super.key,
    required this.inventoryItems,
    required this.flexWeights,
  });
  // TODO: Not final so web version will display correctly
  List<InventoryItemLocal> inventoryItems;
  final List<int> flexWeights;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kIsWeb) {
      inventoryItems = [
        InventoryItemLocal.empty(''),
        InventoryItemLocal.empty(''),
      ];
      inventoryItems[0].boothName = 'BoothOne';
      inventoryItems[1].boothName = 'BoothTwo';

      inventoryItems[0].itemImageUrls = [
        '/Users/david/Coding Projects/vintage_1020/resources/images-furniture/9.jpeg',
        'resources/images-furniture/10.jpeg',
      ];

      inventoryItems[1].itemImageUrls = [
        'resources/images-furniture/11.jpeg',
        'resources/images-furniture/12.jpeg',
      ];
    }

    return CarouselView.weighted(
      itemSnapping: true,
      flexWeights: flexWeights,
      children: inventoryItems
          .map((itemUrl) => InventoryItemImage(item: itemUrl))
          .toList(),
    );
  }
}
