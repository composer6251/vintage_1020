import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/data/providers/current_inventory_item/current_inventory_item.dart';
import 'package:vintage_1020/data/providers/filter_notifier.dart';
import 'package:vintage_1020/data/providers/inventory_notifier.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';

import 'package:vintage_1020/ui/manage_inventory_tab/widgets/manage_inventory_item_tile.dart';

class ManageInventoryTab extends HookConsumerWidget {
  const ManageInventoryTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // NEW PROVIDER
    final List<InventoryItemLocal> filteredInventory = ref.watch(inventoryProvider);

    final selectedFilter = useState<Set<InventoryFilter>>({InventoryFilter.all});

    void updateSelectedFilter(Set<InventoryFilter> newFilter) {
      Set<InventoryFilter> currentFilters = selectedFilter.value;
      currentFilters.addAll(newFilter);
      selectedFilter.value =  newFilter;

      // UPDATE PROVIDER WITH FILTER
      ref.read(inventoryProvider.notifier).setFilteredInventory(newFilter.first);
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
        Container(
          height: 30, 
          child: Text(
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), 
          'Number of items: ${filteredInventory.length}')),
        SegmentedButton<InventoryFilter>(
          style: ButtonStyle(elevation: WidgetStatePropertyAll(100)),
          multiSelectionEnabled: false,
          selected: selectedFilter.value,
          onSelectionChanged: (Set<InventoryFilter> filters) {
            updateSelectedFilter(filters);
          },
          segments: <ButtonSegment<InventoryFilter>>[
            ButtonSegment<InventoryFilter>(
              value: InventoryFilter.all,
              label: Text('All')
              ),
            ButtonSegment<InventoryFilter>(
              value: InventoryFilter.myBooth,
              label: Text('Booth')
              ),
            ButtonSegment<InventoryFilter>(
              value: InventoryFilter.backStock,
              label: Text(
                style: TextStyle(overflow: TextOverflow.ellipsis),
                'Backstock')
              ),
            ButtonSegment<InventoryFilter>(
              value: InventoryFilter.sold,
              label: Text('Sold')
              ),

          ],

        ),
  
        Expanded(
          child: ListView.builder(
            itemExtent: 200,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  print('Item index select on manage inventory: $index');
                  redirectToEditInventoryItem(filteredInventory[index]);
                },
                child: ManageInventoryItemTile(model: filteredInventory[index]),
              );
            },
            itemCount: filteredInventory.length,
          ),
        ),
      ],
    );
  }
}
