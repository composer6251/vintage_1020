import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:vintage_1020/data/mock/build_mock_models.dart';
import 'package:vintage_1020/domain/providers/inventory_notifier/async_inventory_notifier_provider.dart';
import 'package:vintage_1020/domain/repositories/inventory/inventory_repository.dart';
import 'package:vintage_1020/domain/providers/inventory_provider/inventory_provider.dart';
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
  late Future<void> _itemsFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _itemsFuture = ref.read(asyncInventoryNotifierProviderProvider.notifier).build();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _itemsFuture,
      builder: (context, asyncSnapshot) {
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
                children: _itemsFuture.map((model) {
                  return HeroLayoutCard(
                    item: model,
                    height: widget.height,
                    width: widget.width,
                  );
                }).toList(),
              ),
            ),
          ],
        );
      }
    );
  }
}
