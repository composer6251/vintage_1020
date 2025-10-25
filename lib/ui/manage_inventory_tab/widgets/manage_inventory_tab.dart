import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      String photoTaken = await PhotoUtil.takePhotoAndReturnUrl();
      if (photoTaken == "") return;

      // Save xfile as file
      // Get file path
      // save file with provider

      ref.read(inventoryLocalProvider.notifier).quickAddInventoryItem(photoTaken);
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
          SizedBox(
            width: MediaQuery.widthOf(context) * .90,
            child: Card.filled(
              surfaceTintColor: Colors.red,
              // elevation: 20,
              child: OutlinedButton(
                style: ButtonStyle(
                  // backgroundColor: WidgetStatePropertyAll<Color>(Color.fromARGB(6, 6, 94, 63)),
                ),
                onPressed: openAddInventoryDialog, 
                child: Center(
                  child: 
                  Text(style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    ), 
                    'Add New Item')
                  )
                ),
            ),
          ),
          // DISPLAY NO INVENTORY MESSAGE IF INVENTORY IS EMPTY
          filteredInventory.isEmpty && currentFilter.value == InventoryFilter.all
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
      ),
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton.extended(
        extendedIconLabelSpacing: 10,
        label: Text('Quick'),
        icon: FaIcon(FontAwesomeIcons.plus),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(16))
            ),
        onPressed: quickAddItemWithPhoto,
        backgroundColor: Colors.blue,
      ),
    );
  }
}
