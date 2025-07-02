import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/providers/inventory_provider.dart';
import 'package:vintage_1020/ui/manage_inventory_tab/manage_inventory_screen.dart';

class ManageInventoryTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(inventoryNotifierProvider);

    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;

    // TODO: implement build
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: ListView.separated(
            // shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  ref
                    .read(inventoryNotifierProvider.notifier)
                    .makeCurrentInventoryItem(items[index].id);
                  Navigator.pushNamed(
                    context,
                    '/edit-inventory-item',
                    arguments: items[index],
                  );
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
