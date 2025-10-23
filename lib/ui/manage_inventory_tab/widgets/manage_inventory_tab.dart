import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/constants/enums.dart';
import 'package:vintage_1020/data/local_db/local_db.dart';

import 'package:vintage_1020/data/providers/inventory_notifier.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/ui/add_item_dialog/widgets/add_item_dialog.dart';
import 'package:vintage_1020/ui/edit_item_dialog/edit_inventory_item_dialog.dart';

import 'package:vintage_1020/ui/manage_inventory_tab/widgets/manage_inventory_item_tile.dart';

class ManageInventoryTab extends HookConsumerWidget {
  const ManageInventoryTab({super.key});

 
  // late Future<List<InventoryItemLocal>> inventoryFuture;

  // @override
  // void initState() {
  //   super.initState();
  //   print('Manage Inventory initState');
  //   inventoryFuture = ref
  //       .read(inventoryLocalProvider.notifier)
  //       .fetchInitialUserInventory();
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final future = useMemoized(
      () => LocalDb().fetchUserInventoryFromDb());
    final snapshot = useFuture(future);

    final inventory = ref.watch(inventoryLocalProvider);

    final filterController = useState<InventoryFilter>(InventoryFilter.all);

    final List<InventoryItemLocal> filteredInventory = ref.watch(
      inventoryProvider,
    );

    //   // UPDATE PROVIDER WITH FILTER
    //   ref.read(filterProvider.notifier).setCurrentFilter(newFilter.first);

    //   // UPDATE INVENTORY BY NEW FILTER VALUE
    //   ref
    //       .read(inventoryProvider.notifier)
    //       .getFilteredInventory(newFilter.first);
    // }

    void openEditInventoryDialog(InventoryItemLocal item) {
      showDialog(
        context: context,
        builder: (context) => EditInventoryItemDialog(itemEditing: item),
      );
    }

    void openAddInventoryDialog() {
      showDialog(
        context: context,
        builder: (context) => const AddInventoryFormDialog(),
      );
    }

    final String noInventoryMessage =
        'You do not have any ${filterController.value.name} items.';

    return Scaffold(
      body: FutureBuilder<List<InventoryItemLocal>>(
        future: future,
        builder: (context, asyncSnapshot) {
          // AFTER THE ASYNC CALL FINISHES, HANDLE THE RETURN
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (asyncSnapshot.hasError) {
            return Center(
              child: Text('Error loading data: ${asyncSnapshot.error}'),
            );
          } else if (asyncSnapshot.hasData) {
            return Column(
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
                  selected: {filterController.value},
                  onSelectionChanged: (Set<InventoryFilter> filters) {
                    filterController.value = filters.first;
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
                            filterController.value == InventoryFilter.all
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
                                openEditInventoryDialog(
                                  filteredInventory[index],
                                );
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
        // TODO
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(side: BorderSide(color: Colors.blue, width: 2.0)),
        onPressed: openAddInventoryDialog,
        backgroundColor: Colors.blue,
        child: Icon(size: 40.0, Icons.add),
      ),
    );
  }
}
