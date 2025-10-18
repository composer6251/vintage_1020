import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/data/providers/current_inventory_item/current_inventory_item.dart';
import 'package:vintage_1020/data/providers/filter_notifier.dart';
import 'package:vintage_1020/data/providers/inventory_notifier.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/ui/core/ui/widgets/dialog/edit_inventory_item_dialog.dart';

import 'package:vintage_1020/ui/manage_inventory_tab/widgets/manage_inventory_item_tile.dart';

class ManageInventoryTab extends ConsumerStatefulWidget {
  const ManageInventoryTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ManageInventoryTabState();
}

class _ManageInventoryTabState extends ConsumerState<ManageInventoryTab> {
  late Future<List<InventoryItemLocal>> inventoryFuture;

  @override
  void initState() {
    super.initState();
    print('Manage Inventory initState');
    inventoryFuture = ref
        .read(inventoryLocalProvider.notifier)
        .fetchInitialUserInventory();
  }

  @override
  Widget build(BuildContext context) {
    // NEW PROVIDER
    final List<InventoryItemLocal> filteredInventory = ref.watch(
      inventoryProvider,
    );

    final selectedFilter = useState<InventoryFilter>(InventoryFilter.all);

    void updateSelectedFilter(Set<InventoryFilter> newFilter) {
      selectedFilter.value = newFilter.first;

      // UPDATE PROVIDER WITH FILTER
      ref.read(filterProvider.notifier).setCurrentFilter(newFilter.first);

      // UPDATE INVENTORY BY NEW FILTER VALUE
      ref
          .read(inventoryProvider.notifier)
          .getFilteredInventory(newFilter.first);
    }

    void openEditInventoryDialog(InventoryItemLocal item) {
      ref.read(currentInventoryItemProvider.notifier).updateCurrentInventoryItem(item);
      showDialog(
        context: context,
        builder: (context) => const EditInventoryItemDialog(),
      );
    }

    final String noInventoryMessage =
        'You do not have any ${selectedFilter.value.name} items.';

    return Scaffold(
      body: FutureBuilder<List<InventoryItemLocal>>(
        future: inventoryFuture,
        builder: (context, asyncSnapshot) {
          // AFTER THE ASYNC CALL FINISHES, HANDLE THE RETURN
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (asyncSnapshot.hasError) {
            return Center(
              child: Text('Error loading data: ${asyncSnapshot.error}'),
            );
          } else if (asyncSnapshot.hasData) {
            return
            // ADD FILTER BAR AND DISPLAY INVENTORY COUNT REGARDLESS OF WHETHER OR NOT THERE'S INVENTORY ITEMS
            Column(
              children: [
                SizedBox(
                  height: 30,
                  child: Text(
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    'Number of items: ${filteredInventory.length}',
                  ),
                ),
                SegmentedButton<InventoryFilter>(
                  style: ButtonStyle(elevation: WidgetStatePropertyAll(100)),
                  multiSelectionEnabled: false,
                  selected: {selectedFilter.value},
                  onSelectionChanged: (Set<InventoryFilter> filters) {
                    updateSelectedFilter(filters);
                  },
                  segments: <ButtonSegment<InventoryFilter>>[
                    ButtonSegment<InventoryFilter>(
                      value: InventoryFilter.all,
                      label: Text('All'),
                    ),
                    ButtonSegment<InventoryFilter>(
                      value: InventoryFilter.listed,
                      label: Text('Booth'),
                    ),
                    ButtonSegment<InventoryFilter>(
                      value: InventoryFilter.backStock,
                      label: Text(
                        style: TextStyle(overflow: TextOverflow.ellipsis),
                        'Backstock',
                      ),
                    ),
                    ButtonSegment<InventoryFilter>(
                      value: InventoryFilter.sold,
                      label: Text('Sold'),
                    ),
                  ],
                ),
                // DISPLAY NO INVENTORY MESSAGE IF INVENTORY IS EMPTY
                filteredInventory.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
                          child: Text(
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                            selectedFilter.value == InventoryFilter.all
                                ? 'You do not have any inventory items yet. Press the + to add an item!'
                                : noInventoryMessage,
                          ),
                        ),
                      )
                    // OTHERWISE DISPLAY INVENTORY TILES
                    : Expanded(
                        child: ListView.builder(
                          itemExtent: 200,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                openEditInventoryDialog(filteredInventory[index]);
                              },
                              child: ManageInventoryItemTile(
                                model: filteredInventory[index],
                              ),
                            );
                          },
                          itemCount: filteredInventory.length,
                        ),
                      ),
              ],
            );
          }
          return Center(
            child: Text('No inventory Items. Click the PLUS sign to add'),
          );
        },
      ),
    );
  }
}
