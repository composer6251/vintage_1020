import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/data/model/inventory_item/inventory_item.dart';
import 'package:vintage_1020/domain/providers/firestore_provider/firestore_provider.dart';
import 'package:vintage_1020/domain/providers/inventory_local_provider/inventory_local_provider.dart';
import 'package:vintage_1020/ui/core/ui/util/image_util.dart';
import 'package:vintage_1020/ui/core/ui/widgets/inventory_carousel/hero_card.dart';

class InventoryCarousel extends ConsumerStatefulWidget {
  const InventoryCarousel({
    super.key,
    // required this.models,
    required this.width,
    required this.height,
    required this.flexWeights,
  });

  // final List<InventoryItem> models;
  final double width;
  final double height;
  final List<int> flexWeights;

  @override
  ConsumerState<InventoryCarousel> createState() => _InventoryCarouselState();
}

class _InventoryCarouselState extends ConsumerState<InventoryCarousel> {
  List<File?> itemImages = [];

  void setItemImages(List<String> itemImageUrls) async {
     itemImages = await getAssetsFromInventoryAlbum();
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(firestoreProviderProvider);
    final images = ref.watch(inventoryLocalProvider.notifier).getInventoryLocal();

    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              
              ],
            ),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: widget.height * .7),
          child: CarouselView.weighted(
            // controller: controller,
            itemSnapping: true,
            flexWeights: widget.flexWeights,
            children: images
                .map(
                  (i) => HeroLayoutCard(
                    item: i,
                    height: widget.height,
                    width: widget.width,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
