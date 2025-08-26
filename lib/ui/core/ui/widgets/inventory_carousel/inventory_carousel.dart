import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:vintage_1020/domain/models/mock/build_mock_models.dart';
import 'package:vintage_1020/ui/core/ui/widgets/hero_card.dart';

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
  // My booth tab?
  // Need List<InventoryItem> for carousel
  // Need CurrentInventoryItem from provider for HeroCard

  // Edit InventoryItem?
  // Need InventoryItem for carousel
  // Need PrimaryImageUrl for HeroCard
  @override
  Widget build(BuildContext context) {
    // final items = ref.watch(inventoryRepositoryProvider);

    final items = BuildMockModels.buildMyBoothMockModels();
    final mockItems = BuildMockModels.buildEditInventoryItemModels();

    // Update firestore user_inventory db
    // Create firestoreInventory.getInventoryByEmail

    // Initialize inventory

    // Display inventory

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
            children: mockItems.map((model) {
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
}
