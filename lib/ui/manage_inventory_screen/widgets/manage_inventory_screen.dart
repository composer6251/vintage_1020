import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vintage_1020/constants/enums.dart';
import 'package:vintage_1020/constants/welcome_tutorial_message.dart';
import 'package:vintage_1020/data/providers/filter_notifier.dart';
import 'package:vintage_1020/data/providers/inventory_counts_notifier/inventory_counts_notifier.dart';

import 'package:vintage_1020/data/providers/inventory_notifier.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/data/providers/my_booth_provider/my_booths_notifier.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/ui/add_item_dialog/widgets/add_item_dialog.dart';
import 'package:vintage_1020/ui/add_item_dialog/widgets/quick_add_item_button_widget.dart';
import 'package:vintage_1020/ui/common/filter_segmented_button.dart';
import 'package:vintage_1020/ui/common/widgets/app_bar/custom_app_bar.dart';
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

    final width = MediaQuery.sizeOf(context).width;

    // Widget rebuilds when notified of inventoryLocalProvider state change
    ref.watch(inventoryLocalProvider);

    final currentFilter = useState<InventoryFilter>(InventoryFilter.all);

    // Watch the inventory provider which filters the inventory based on current filter
    final List<InventoryItemLocal> filteredInventory = ref.watch(
      inventoryProvider,
    );

    void openEditInventoryDialog(InventoryItemLocal item) {
      showDialog(
        context: context,
        builder: (context) => EditInventoryItemDialog(itemEditing: item),
      );
    }

    void openAddItemDialog() {
      showDialog(context: context, builder: (context) => const AddItemDialog());
    }

    Widget buildBody() {
      if (snapshot.connectionState == ConnectionState.done) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: MediaQuery.heightOf(context) * .1,
              child: FilterSegmentedButton(key: key)),
            // DISPLAY NO INVENTORY MESSAGE IF INVENTORY IS EMPTY
            filteredInventory.isEmpty &&
                    currentFilter.value == InventoryFilter.all
              ? 
              WelcomeTutorialMessage()
              // OTHERWISE DISPLAY INVENTORY TILES
              : 
              Expanded(
                flex: 4,
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

    return Scaffold(
      body: buildBody(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.primary,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 1,
              child: IconButton(
                iconSize: 36,
                onPressed: () =>
                  Navigator.pushNamed(context, '/my-booths'),
                icon: FaIcon(FontAwesomeIcons.tent),
              ),
            ),
            Flexible(
              flex: 1,
              child: IconButton(
                iconSize: 36,
                onPressed: () =>
                  Navigator.pushNamed(context, '/inventory-analytics'),
                icon: FaIcon(FontAwesomeIcons.chartBar),
              ),
            ),
            Flexible(
              flex: 2,
              child: OutlinedButton(
                onPressed: openAddItemDialog,
                child: Text(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  'Add Item',
                ),
              ),
            ),
            Flexible(flex: 2, child: QuickAddItemButtonWidget()),
          ],
        ),
      ),
    );
  }
}
