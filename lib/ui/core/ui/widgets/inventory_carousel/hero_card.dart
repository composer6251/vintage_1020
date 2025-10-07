import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/data/model/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/ui/core/ui/widgets/inventory_carousel/carousel_image.dart';

class HeroLayoutCard extends ConsumerWidget {
  HeroLayoutCard({
    super.key,
    required this.item,
    // required this.height,
    // required this.width,
  });

  final InventoryItemLocal item;
  // final double height;
  // final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

      print('ITEM HAS ${item.itemImageUrls?.length} images');
    return item.primaryImageUrl == null
        ? Container(child: Text('You have no inventory yet. Press the + in the bottom right corner to add an item!'),)
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: item.itemImageUrls!.map((url) =>
               Expanded(
                 child: Align(
                  alignment: Alignment.topCenter,
                   child: AspectRatio(
                    aspectRatio: 16 / 9,
                     child: CarouselImage(
                      url: url
                      ),
                   ),
                 ),
               )).toList(),
          );
            
  }
}