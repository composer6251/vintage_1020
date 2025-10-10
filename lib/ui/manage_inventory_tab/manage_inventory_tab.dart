import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    void redirectToEditInventoryItem(InventoryItemLocal item) {
      ref.read(asyncInventoryNotifierProviderProvider.notifier).makeCurrentInventoryItem(item.id!);
      Navigator.pushNamed(context, '/edit-inventory-item', arguments: item);
    }

    return Column(
      children: [
        Container(child: Text('Inventory items is ${inventory.length}'),),
        Expanded(
          // flex: 4,
          child: ListView.builder(
            itemExtent: 200,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  redirectToEditInventoryItem(inventory[index]);
                },
                child: ManageInventoryItemTile(
                  model: inventory[index],
                ),
              );
            },
            itemCount: inventory.length,
          ),
        ),
      ],
    );
  }
}
