import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';

class SelectBoothWidget extends HookConsumerWidget {
  SelectBoothWidget({required super.key, required this.currentBooths});

  late final List<MyBooth> currentBooths;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBooth = useState(currentBooths[0]);

    final inventory = ref.watch(inventoryLocalProvider);

    MyBooth setInventoryForBooth() {
      MyBooth booth = selectedBooth.value;
      List<InventoryItemLocal> boothInventoryItems =
          selectedBooth.value.boothInventory = inventory
              .where(
                (item) =>
                    selectedBooth.value.boothInventoryIds.contains(item.id),
              )
              .toList();
      booth.boothInventory = boothInventoryItems;

      return booth;
    }

    return Expanded(
      child: ListView.builder(
        itemExtent: 150,
        scrollDirection: Axis.horizontal,
        itemCount: currentBooths.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              selectedBooth.value == currentBooths[index];
              setInventoryForBooth();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Badge(
                  label: Text(
                    currentBooths[index].boothItemsCount.toString() ?? '0',
                  ),
                  child: FaIcon(FontAwesomeIcons.tent),
                ),
                Text(currentBooths[index].boothName),
              ],
            ),
          );
        },
      ),
    );
  }
}
