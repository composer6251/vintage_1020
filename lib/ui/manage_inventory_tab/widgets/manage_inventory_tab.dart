import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vintage_1020/constants/enums.dart';
import 'package:vintage_1020/constants/welcome_tutorial_message.dart';
import 'package:vintage_1020/data/local_db/local_db.dart';
import 'package:vintage_1020/data/providers/filter_notifier.dart';

import 'package:vintage_1020/data/providers/inventory_notifier.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/ui/add_item_dialog/widgets/add_item_dialog.dart';
import 'package:vintage_1020/ui/edit_item_dialog/edit_inventory_item_dialog.dart';

import 'package:vintage_1020/ui/manage_inventory_tab/widgets/manage_inventory_item_tile.dart';
import 'package:vintage_1020/util/photo_util.dart';

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
    // Initiate fetch for inventory
    useEffect(() {
      ref.read(inventoryLocalProvider.notifier).fetchInitialUserInventory();
    }, []);

    // Widget rebuilds when notified of inventoryLocalProvider state change
    ref.watch(inventoryLocalProvider);

    final currentFilter = useState<InventoryFilter>(InventoryFilter.all);
    final quickAddPhoto = useState<XFile?>(null);

    // Watch the inventory provider which filters the inventory based on current filter
    final List<InventoryItemLocal> filteredInventory = ref.watch(
      inventoryProvider,
    );

    void setNewInventoryFilter(InventoryFilter newFilter) {
      currentFilter.value = newFilter;
      ref.read(filterProvider.notifier).setCurrentFilter(newFilter);
    }

    void quickAddItemWithPhoto() async {
      XFile? photoTaken = await PhotoUtil.takeCameraPhoto();
      if (photoTaken == null) return;

      // Save xfile as file
      // Get file path
      // save file with provider
    }

    void openEditInventoryDialog(InventoryItemLocal item) {
      showDialog(
        context: context,
        builder: (context) => EditInventoryItemDialog(itemEditing: item),
      );
    }

    void openAddInventoryDialog() {
      showDialog(context: context, builder: (context) => const AddItemDialog());
    }

    final String noInventoryMessage =
        'You do not have any ${currentFilter.value.name} items.';

    return Scaffold(
      body: Column(
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
            selected: {currentFilter.value},
            onSelectionChanged: (Set<InventoryFilter> filters) {
              setNewInventoryFilter(filters.first);
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
              ? WelcomeTutorialMessage()
              // ? Center(
              //     child: Padding(
              //       padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
              //       child: Text(
              //         style: TextStyle(
              //           fontSize: 32,
              //           fontWeight: FontWeight.bold,
              //         ),
              //         currentFilter.value == InventoryFilter.all
              //             ? 'You do not have any inventory items yet. Press the + to add an item!'
              //             : noInventoryMessage,
              //       ),
              //     ),
              //   )
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
      ),

      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(side: BorderSide(color: Colors.blue, width: 2.0)),
        onPressed: openAddInventoryDialog,
        backgroundColor: Colors.blue,
        child: Icon(size: 40.0, Icons.add),
      ),

      // FutureBuilder<List<InventoryItemLocal>>(
      //   future: future,
      //   builder: (context, asyncSnapshot) {
      //     // AFTER THE ASYNC CALL FINISHES, HANDLE THE RETURN
      //     if (asyncSnapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: CircularProgressIndicator());
      //     } else if (asyncSnapshot.hasError) {
      //       return Center(
      //         child: Text('Error loading data: ${asyncSnapshot.error}'),
      //       );
      //     } else if (asyncSnapshot.hasData) {
      // return Column(
      //   children: [
      //     SizedBox(
      //       height: 30,
      //       child: Text(
      //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      //         'Number of items: ${filteredInventory.length}',
      //       ),
      //     ),
      //     SegmentedButton<InventoryFilter>(
      //       style: ButtonStyle(elevation: WidgetStatePropertyAll(100)),
      //       multiSelectionEnabled: false,
      //       selected: {filterController.value},
      //       onSelectionChanged: (Set<InventoryFilter> filters) {
      //         filterController.value = filters.first;
      //       },
      //       segments: <ButtonSegment<InventoryFilter>>[
      //         ButtonSegment<InventoryFilter>(
      //           value: InventoryFilter.all,
      //           label: Text('All'),
      //         ),
      //         ButtonSegment<InventoryFilter>(
      //           value: InventoryFilter.listed,
      //           label: Text('Booth'),
      //         ),
      //         ButtonSegment<InventoryFilter>(
      //           value: InventoryFilter.backStock,
      //           label: Text(
      //             style: TextStyle(overflow: TextOverflow.ellipsis),
      //             'Backstock',
      //           ),
      //         ),
      //         ButtonSegment<InventoryFilter>(
      //           value: InventoryFilter.sold,
      //           label: Text('Sold'),
      //         ),
      //       ],
      //     ),
      //     // DISPLAY NO INVENTORY MESSAGE IF INVENTORY IS EMPTY
      //     filteredInventory.isEmpty
      //         ? Center(
      //             child: Padding(
      //               padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
      //               child: Text(
      //                 style: TextStyle(
      //                   fontSize: 32,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //                 filterController.value == InventoryFilter.all
      //                     ? 'You do not have any inventory items yet. Press the + to add an item!'
      //                     : noInventoryMessage,
      //               ),
      //             ),
      //           )
      //         // OTHERWISE DISPLAY INVENTORY TILES
      //         : Expanded(
      //             child: ListView.builder(
      //               itemExtent: 200,
      //               itemBuilder: (context, index) {
      //                 return GestureDetector(
      //                   onTap: () {
      //                     openEditInventoryDialog(
      //                       filteredInventory[index],
      //                     );
      //                   },
      //                   child: ManageInventoryItemTile(
      //                     model: filteredInventory[index],
      //                   ),
      //                 );
      //               },
      //               itemCount: filteredInventory.length,
      //             ),
      //           ),
      //   ],
      // );
      //     }
      //     return Center(
      //       child: Text('No inventory Items. Click the PLUS sign to add'),
      //     );
      //   },
      //   // TODO
      // ),
      // floatingActionButton: FloatingActionButton(
      //   shape: CircleBorder(side: BorderSide(color: Colors.blue, width: 2.0)),
      //   onPressed: openAddInventoryDialog,
      //   backgroundColor: Colors.blue,
      //   child: Icon(size: 40.0, Icons.add),
      // ),
    );
  }
}
