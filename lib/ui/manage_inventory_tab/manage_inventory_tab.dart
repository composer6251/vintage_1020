import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/domain/models/mock/build_mock_models.dart';
import 'package:vintage_1020/domain/models/model/inventory_item/inventory_item.dart';
import 'package:vintage_1020/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/ui/manage_inventory_tab/manage_inventory_item_tile.dart';

class ManageInventoryTab extends ConsumerWidget {
  const ManageInventoryTab({super.key});
  // final TabController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Use Repository and replace mock data
    // final items = ref.watch(inventoryNotifierProvider);

    final items = BuildMockModels.buildMyBoothMockModels();

    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;

    void redirectToEditInventoryItem(InventoryItem item) {
      ref.read(inventoryNotifierProvider.notifier).makeCurrentInventoryItem(item.id!);
      // controller.index = 2; // Switch to EditItemTab
      Navigator.pushNamed(context, '/edit-inventory-item', arguments: item);
    }

    // TODO: implement build
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: ListView.separated(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  redirectToEditInventoryItem(items[index]);
                  // ref
                  //   .read(inventoryNotifierProvider.notifier)
                  //   .makeCurrentInventoryItem(items[index].id);
                    
                  // Navigator.pushNamed(
                  //   context,
                  //   '/edit-inventory-item',
                  //   arguments: items[index],
                  // );
                },
                child: ManageInventoryItemTile(
                  model: items[index],
                  width: width / 2,
                  height: height / 4.25,
                ),
              );
            },
            separatorBuilder: (_, _) => Divider(),
            itemCount: items.length,
          ),
        ),
      ],
    );
  }
}
