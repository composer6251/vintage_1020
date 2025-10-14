import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/data/providers/current_inventory_item/current_inventory_item.dart';
import 'package:vintage_1020/ui/core/ui/widgets/inventory_carousel/carousel_image.dart';
import 'package:vintage_1020/ui/core/ui/widgets/inventory_carousel/edit_item_inventory_carousel.dart';

class EditItemTab extends ConsumerStatefulWidget {


    @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditItemTabState();

}

class _EditItemTabState extends ConsumerState<EditItemTab> {

  @override
  Widget build(BuildContext context) {
    final item = ref.read(currentInventoryItemProvider);
    final List<File>? itemImages = item.getItemImages;
    final File displayImage = item.getPrimaryImage;

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Image.file(displayImage)
          ),
          Flexible(child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemExtent: 200,
            itemBuilder: (context, index) {
              return Image.file(
                fit: BoxFit.fill,
                  itemImages![index],
              );
            },
            itemCount: itemImages?.length,
          ),)
          // Flexible(
          //   flex: 3,
          //   child: InventoryCarousel(inventoryItems: [item], flexWeights: [3]),
          // ),
        ],
      ),
    );
  }
}
