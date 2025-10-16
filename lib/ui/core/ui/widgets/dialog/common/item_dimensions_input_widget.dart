import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/data/providers/current_inventory_item/current_inventory_item.dart';
import 'package:vintage_1020/data/providers/inventory_notifier.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';

class ItemDimensionsInputWidget extends StatefulHookConsumerWidget {

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ItemDimensionsInputWidget();
}

class _ItemDimensionsInputWidget extends ConsumerState<ItemDimensionsInputWidget> {

  @override
  Widget build(BuildContext context) {
    
    final items = ref.watch(inventoryProvider);
    final currentItem = items.first;

    final itemHeightController = TextEditingController(
      text: currentItem.itemHeight?.toString(),
    );
    final itemWidthController = TextEditingController(
      text: currentItem.itemWidth?.toString(),
    );
    final itemDepthController = TextEditingController(
      text: currentItem.itemDepth?.toString(),
    );

    return Flex(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      direction: Axis.horizontal,
      children: [
        SizedBox(
          width: 80,
          child: TextFormField(
            controller: itemHeightController,
            decoration: const InputDecoration(
              fillColor: Colors.blue,
              floatingLabelAlignment: FloatingLabelAlignment.start,
              labelText: 'Height',
              labelStyle: TextStyle(fontSize: 16)
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validator: (value) =>
                value?.isEmpty ?? true ? 'Purchase Price is required' : null,
          ),
        ),
        SizedBox(
          width: 80,
          child: TextFormField(
            controller: itemWidthController,
            decoration: const InputDecoration(
              fillColor: Colors.blue,
              labelText: 'Width',
              floatingLabelAlignment: FloatingLabelAlignment.start,
              labelStyle: TextStyle(fontSize: 16)
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
        ),
        SizedBox(
          width: 80,
          child: TextFormField(
            controller: itemDepthController,
            decoration: const InputDecoration(
              fillColor: Colors.blue,
              labelText: 'Depth',
              floatingLabelAlignment: FloatingLabelAlignment.start,
              labelStyle: TextStyle(fontSize: 16)
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
        ),
      ],
    );
  }
}
