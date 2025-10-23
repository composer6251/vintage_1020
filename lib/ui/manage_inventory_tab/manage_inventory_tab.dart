import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/data/local_db/local_db.dart';

import 'package:vintage_1020/data/providers/filter_notifier.dart';
import 'package:vintage_1020/data/providers/inventory_notifier.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/ui/core/ui/widgets/dialog/add_inventory_form_dialog.dart';
import 'package:vintage_1020/ui/core/ui/widgets/dialog/edit_inventory_item_dialog.dart';

import 'package:vintage_1020/ui/manage_inventory_tab/widgets/manage_inventory_item_tile.dart';

class ManageInventoryTab extends StatefulHookConsumerWidget {
  const ManageInventoryTab({super.key});

  @override
  ConsumerState<ManageInventoryTab> createState() => _ManageInventoryTabState();
}

class _ManageInventoryTabState extends ConsumerState<ManageInventoryTab> {
  // late Future<List<InventoryItemLocal>> inventoryFuture;

  // @override
  // void initState() {
  //   super.initState();
  //   print('Manage Inventory initState');
  //   inventoryFuture = ref
  //       .read(inventoryLocalProvider.notifier)
  //       .fetchInitialUserInventory();
  // }

  InventoryFilter selectedFilter = InventoryFilter.all;

  @override
  Widget build(BuildContext context) {
    final future = useMemoized(
      () => LocalDb().fetchUserInventoryFromDb());
    final snapshot = useFuture(future);
    // useEffect(() {
    //   ref.read(inventoryLocalProvider.notifier).fetchInitialUserInventory();
    //   null;
    // }, []);

    // final inventory = ref.watch(inventoryLocalProvider);

    // Create db for initial inventory fetch
    // final db = useMemoized(() => LocalDb());

    // useEffect(() {
    //   LocalDb().fetchUserInventoryFromDb();
    //   null;
    // }, []);

    final List<InventoryItemLocal> filteredInventory = ref.watch(
      inventoryProvider,
    );
    void updateSelectedFilter(Set<InventoryFilter> newFilter) {
      setState(() {
        selectedFilter = newFilter.first;
      });

      // UPDATE PROVIDER WITH FILTER
      ref.read(filterProvider.notifier).setCurrentFilter(newFilter.first);

      // UPDATE INVENTORY BY NEW FILTER VALUE
      ref
          .read(inventoryProvider.notifier)
          .getFilteredInventory(newFilter.first);
    }

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

      // setUserBooths();
    }

    final String noInventoryMessage =
        'You do not have any ${selectedFilter.name} items.';

    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) async { 
          return switch (snapshot) {
            // If "value" is non-null, it means that we have some data.
            case AsyncValue(:final value?):
              return Text(value);
            // If "error" is non-null, it means that the operation failed.
            case AsyncValue(error: != null):
              return Text('Error: ${asyncValue.error}');
            // If we're neither in data state nor in error state, then we're in loading state.
            case AsyncValue():
              return const CircularProgressIndicator();
          
          },),
      // body: FutureBuilder<List<InventoryItemLocal>>(
      //   future: snapshot,
      //   builder: (context, asyncSnapshot) {
      //     // AFTER THE ASYNC CALL FINISHES, HANDLE THE RETURN
      //     if (asyncSnapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: CircularProgressIndicator());
      //     } else if (asyncSnapshot.hasError) {
      //       return Center(
      //         child: Text('Error loading data: ${asyncSnapshot.error}'),
      //       );
      //     } else if (asyncSnapshot.hasData) {
      //       return Column(
      //         children: [
      //           SizedBox(
      //             height: 30,
      //             child: Text(
      //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      //               'Number of items: ${filteredInventory.length}',
      //             ),
      //           ),
      //           SegmentedButton<InventoryFilter>(
      //             style: ButtonStyle(elevation: WidgetStatePropertyAll(100)),
      //             multiSelectionEnabled: false,
      //             selected: {selectedFilter},
      //             onSelectionChanged: (Set<InventoryFilter> filters) {
      //               updateSelectedFilter(filters);
      //             },
      //             segments: <ButtonSegment<InventoryFilter>>[
      //               ButtonSegment<InventoryFilter>(
      //                 value: InventoryFilter.all,
      //                 label: Text('All'),
      //               ),
      //               ButtonSegment<InventoryFilter>(
      //                 value: InventoryFilter.listed,
      //                 label: Text('Booth'),
      //               ),
      //               ButtonSegment<InventoryFilter>(
      //                 value: InventoryFilter.backStock,
      //                 label: Text(
      //                   style: TextStyle(overflow: TextOverflow.ellipsis),
      //                   'Backstock',
      //                 ),
      //               ),
      //               ButtonSegment<InventoryFilter>(
      //                 value: InventoryFilter.sold,
      //                 label: Text('Sold'),
      //               ),
      //             ],
      //           ),
      //           // DISPLAY NO INVENTORY MESSAGE IF INVENTORY IS EMPTY
      //           filteredInventory.isEmpty
      //               ? Center(
      //                   child: Padding(
      //                     padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
      //                     child: Text(
      //                       style: TextStyle(
      //                         fontSize: 32,
      //                         fontWeight: FontWeight.bold,
      //                       ),
      //                       selectedFilter == InventoryFilter.all
      //                           ? 'You do not have any inventory items yet. Press the + to add an item!'
      //                           : noInventoryMessage,
      //                     ),
      //                   ),
      //                 )
      //               // OTHERWISE DISPLAY INVENTORY TILES
      //               : Expanded(
      //                   child: ListView.builder(
      //                     itemExtent: 200,
      //                     itemBuilder: (context, index) {
      //                       return GestureDetector(
      //                         onTap: () {
      //                           openEditInventoryDialog(
      //                             filteredInventory[index],
      //                           );
      //                         },
      //                         child: ManageInventoryItemTile(
      //                           model: filteredInventory[index],
      //                         ),
      //                       );
      //                     },
      //                     itemCount: filteredInventory.length,
      //                   ),
      //                 ),
      //         ],
      //       );
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
