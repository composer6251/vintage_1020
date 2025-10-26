import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vintage_1020/constants/enums.dart';
import 'package:vintage_1020/constants/welcome_tutorial_message.dart';
import 'package:vintage_1020/data/providers/filter_notifier.dart';

import 'package:vintage_1020/data/providers/inventory_notifier.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/data/providers/my_booth_provider/my_booths_notifier.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/ui/add_item_dialog/widgets/add_item_dialog.dart';
import 'package:vintage_1020/ui/edit_item_dialog/edit_inventory_item_dialog.dart';

import 'package:vintage_1020/ui/manage_inventory_screen/widgets/manage_inventory_item_tile.dart';
import 'package:vintage_1020/util/photo_util.dart';

class ManageInventoryScreen extends HookConsumerWidget {
  const ManageInventoryScreen({super.key});

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
    final result = useMemoized(
      () =>
          ref.read(inventoryLocalProvider.notifier).fetchInitialUserInventory(),
    );

    final snapshot = useFuture(result);
    // useEffect(() {
    //   ref.read(inventoryLocalProvider.notifier).fetchInitialUserInventory();
    //   ref.read(myBoothsProvider.notifier).fetchUserBooths();
    // }, []);

    final width = MediaQuery.sizeOf(context).width;

    // Widget rebuilds when notified of inventoryLocalProvider state change
    ref.watch(inventoryLocalProvider);

    final currentFilter = useState<InventoryFilter>(InventoryFilter.all);

    // Watch the inventory provider which filters the inventory based on current filter
    final List<InventoryItemLocal> filteredInventory = ref.watch(
      inventoryProvider,
    );

    void setNewInventoryFilter(InventoryFilter newFilter) {
      currentFilter.value = newFilter;
      ref.read(filterProvider.notifier).setCurrentFilter(newFilter);
    }

    void openEditInventoryDialog(InventoryItemLocal item) {
      showDialog(
        context: context,
        builder: (context) => EditInventoryItemDialog(itemEditing: item),
      );
    }

    if (snapshot.connectionState == ConnectionState.done) {
      return Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    'TOTAL ITEMS: ${filteredInventory.length}',
                  ),
                ],
              ),
            ],
          ),
          Divider(height: 32, indent: width * .10, endIndent: width * .10),
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
          filteredInventory.isEmpty &&
                  currentFilter.value == InventoryFilter.all
              ? WelcomeTutorialMessage()
              // OTHERWISE DISPLAY INVENTORY TILES
              : Expanded(
                  child: ListView.builder(
                    itemExtent: 125,
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
    } else if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    } else if (snapshot.connectionState == ConnectionState.none) {
      return Center(child: Text('Snapshot has no connection'));
    }
    return Center(child: Text('Default condition'));
  }
}
