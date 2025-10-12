import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/data/providers/current_inventory_item/current_inventory_item.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/ui/manage_inventory_tab/widgets/manage_inventory_item_tile.dart';

class ManageInventoryTab extends HookConsumerWidget {
  const ManageInventoryTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<InventoryItemLocal> inventory = ref.watch(
      inventoryLocalProvider,
    );

    final _selectedFilter = useState<String>('All');

    void updateSelectedFilter(String newFilter) {
      _selectedFilter.value = newFilter;

      ref.read(filteredInventoryProvider.notifier).update(InventoryFilter.all);
    }

    void redirectToEditInventoryItem(InventoryItemLocal item) async {
      print('redirect to edit inventor with item ${item.id}');
      ref
          .read(currentInventoryItemProvider.notifier)
          .updateCurrentInventoryItem(item);
      Navigator.pushNamed(context, '/edit-inventory-item');
    }

    return Column(
      children: [
        Container(child: Text('Inventory items is ${inventory.length}')),
        SegmentedButton(
          multiSelectionEnabled: true,
          segments: <ButtonSegment<String>>[
            ButtonSegment(value: 'All'),
            ButtonSegment(value: 'Sold'),
            ButtonSegment(value: 'Not Sold'),
            ButtonSegment(value: 'Not Listed'),
            
          ], 
          selected: _selectedFilter,
          onSelectionChanged: ,
        ),
    

        Expanded(
          child: ListView.builder(
            itemExtent: 200,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  print('Item index select on manage inventory: $index');
                  redirectToEditInventoryItem(inventory[index]);
                },
                child: ManageInventoryItemTile(model: inventory[index]),
              );
            },
            itemCount: inventory.length,
          ),
        ),
      ],
    );
  }
}
