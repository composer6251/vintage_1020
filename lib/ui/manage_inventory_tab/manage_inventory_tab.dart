import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/data/model/inventory_item/inventory_item.dart';
import 'package:vintage_1020/data/model/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/domain/providers/inventory_local_provider/inventory_local_provider.dart';
import 'package:vintage_1020/domain/providers/inventory_notifier/async_inventory_notifier_provider.dart';
import 'package:vintage_1020/ui/manage_inventory_tab/manage_inventory_item_tile.dart';

class ManageInventoryTab extends ConsumerWidget {
  const ManageInventoryTab({super.key});
  // final TabController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final List<InventoryItemLocal> inventory = ref.watch(inventoryLocalProvider);

    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;

    void redirectToEditInventoryItem(InventoryItemLocal item) {
      ref.read(asyncInventoryNotifierProviderProvider.notifier).makeCurrentInventoryItem(item.id!);
      // controller.index = 2; // Switch to EditItemTab
      Navigator.pushNamed(context, '/edit-inventory-item', arguments: item);
    }

    return Column(
      children: [
        Expanded(
          flex: 4,
          child: ListView.separated(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  redirectToEditInventoryItem(inventory[index]);
                  // ref
                  //   .read(inventoryNotifierProvider.notifier)
                  //   .makeCurrentInventoryItem(items[index].id);
                    
                  // Navigator.pushNamed(
                  //   context,
                  //   '/edit-inventory-item',
                  //   arguments: items[index],
                  // );
                },
                child: ManageInventoryItemTile(
                  model: inventory[index],
                  width: width / 2,
                  height: height / 4.25,
                ),
              );
            },
            separatorBuilder: (_, _) => Divider(),
            itemCount: inventory.length,
          ),
        ),
      ],
    );
  }
}
