import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/data/providers/inventory_notifier.dart';
import 'package:vintage_1020/data/providers/my_booth_filter/current_booth_provider.dart';
import 'package:vintage_1020/ui/image_widget_util/image_widget_util.dart';

class QuickAddItemsToBoothWidget extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch booths

    // Watch selected booth
    final selectedBooth = ref.read(currentBoothProvider);

    // Watch inventoryfiltered
    final inventory = ref.read(inventoryProvider);

    // Add dropdown for booth

    // Add submit bar

    // Create checkbox tile for each inventory item

    // Add filter on top

    return Column(
      children: [
        ListView.builder(
          itemExtent: 200,
          itemBuilder: (context, index) {
            return Container(
              child: CheckboxListTile(
                value: false,
                secondary: ImageWidgetUtil.getItemImage(
                  selectedBooth.currentBoothImageUrls?.first,
                ),
                onChanged: (value) => value,
              ),
            );
          },
          itemCount: inventory.length,
        ),
      ],
    );
  }
}
