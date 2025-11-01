import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart'
    hide userEmail;
import 'package:vintage_1020/ui/add_item_dialog/widgets/item_dimension_widget.dart';
import 'package:vintage_1020/util/date_picker_util.dart';
import 'package:vintage_1020/utils/date_util.dart';

class EditInventoryItemDialog extends HookConsumerWidget {

  EditInventoryItemDialog({super.key, required this.itemEditing});

  final InventoryItemLocal itemEditing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

      // VARIABLES TO HOLD DATE STATES
    final purchaseDate = useState<DateTime?>(null);
    final listingDate = useState<DateTime?>(null);
    final soldDate = useState<DateTime?>(null);
    final purchasePrice = useState<double?>(0.0);
    final listingPrice = useState<double?>(0.0);
    final soldPrice = useState<double?>(0.0);
    final height = useState<double?>(0.0);
    final width = useState<double?>(0.0);
    final depth = useState<double?>(0.0);
    final boothName = useState<String?>('');

    final DateTime initialDate = DateTime.now();

    Future<void> selectDateForItem(String type) async {

      DateTime? pickedDate = await selectDate(context);
      if (pickedDate == null) return; // User cancelled the date picker
      if (type == 'Listing') {
          listingDate.value = pickedDate;
        return;
      }
      if (type == 'Sold') {

          soldDate.value = pickedDate;
        return;
      }
      purchaseDate.value = pickedDate;
    }

    void closeDialog() {
      Navigator.of(context).pop();
    }

    InventoryItemLocal buildItemFromCurrentState() {
      final InventoryItemLocal currentItemState = InventoryItemLocal(
        itemEditing.id,
        itemEditing.primaryImageUrl,
        '',
        itemEditing.itemImageUrls,
        '',
        purchasePrice.value,
        listingPrice.value,
        soldPrice.value,
        soldDate.value,
        listingDate.value,
        soldDate.value,
        height.value,
        width.value,
        depth.value,
        null,
        boothName.value,
        null,
      );
      return currentItemState;
    }

    void submit() async {
      final itemToSave = buildItemFromCurrentState();
      ref
        .watch(inventoryLocalProvider.notifier)
        .updateCurrentInventoryItemById(itemToSave, itemEditing);

      closeDialog();
    }

    return AlertDialog(
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [Colors.white, const Color.fromARGB(255, 4, 46, 109)],
          ),
        ),
        child: Center(
          child: const Text(
            selectionColor: Colors.blue,
            'Edit Item',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      content: Form(
        // key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Flexible(
                  flex: 5,
                  child: TextFormField(
                    initialValue: purchasePrice.value?.toString(),
                    onChanged: (value) => 
                      purchasePrice.value = double.tryParse(value),
                                        
                    decoration: const InputDecoration(
                      prefixText: '\$',
                      fillColor: Colors.blue,
                      labelStyle: TextStyle(fontSize: 12),
                      labelText: 'Purchase Price',
                    ),
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Purchase Price is required'
                        : null,
                  ),
                ),
                Spacer(),
                Flexible(
                  flex: 5,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      elevation: WidgetStatePropertyAll<double>(8.0),
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Colors.white,
                      ),
                    ),
                    onPressed: () => selectDate,
                    child: Text(
                      getMonthDayYearStringFromDateTime(purchaseDate.value),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  flex: 5,
                  child: TextFormField(
                    initialValue: listingPrice.value?.toString(),
                    onChanged: (value) => 
                      listingPrice.value = double.tryParse(value),
                    decoration: const InputDecoration(
                      prefixText: '\$',
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      labelStyle: TextStyle(fontSize: 12),
                      fillColor: Colors.blue,
                      labelText: 'Listing Price',
                    ),
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                ),
                Spacer(),
                Flexible(
                  flex: 5,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      elevation: WidgetStatePropertyAll<double>(8.0),
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Colors.white,
                      ),
                    ),
                    onPressed: () => selectDate,
                    child: Text(
                      getMonthDayYearStringFromDateTime(listingDate.value),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  flex: 5,
                  child: TextFormField(
                    initialValue: soldPrice.value?.toString(),
                    onChanged: (value) => 
                      soldPrice.value = double.tryParse(value),
                    decoration: const InputDecoration(
                      prefixText: '\$',
                      labelStyle: TextStyle(fontSize: 12),
                      fillColor: Colors.blue,
                      labelText: 'Selling Price',
                    ),
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                ),
                Spacer(),
                Flexible(
                  flex: 5,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      elevation: WidgetStatePropertyAll<double>(8.0),
                    ),
                    onPressed: () => selectDate,
                    child: Text(
                      getMonthDayYearStringFromDateTime(soldDate.value),
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            Flex(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.horizontal,
              children: [
                ItemDimensionWidget(value: itemEditing.itemHeight.toString(), onValueChanged: (value) => height.value = value, label: 'Height'),
                ItemDimensionWidget(value: itemEditing.itemWidth.toString(), onValueChanged: (value) => width.value = value, label: 'Width'),
                ItemDimensionWidget(value: itemEditing.itemDepth.toString(), onValueChanged: (value) => depth.value = value, label: 'Depth'),
              ],
            ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            Flexible(
              flex: 6,
              child: Align(
                alignment: AlignmentGeometry.bottomLeft,
                child: FilledButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/edit-inventory-item'),
                  child: Text('Edit Pics'),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.cancel),
              tooltip: 'Cancel',
              style: ButtonStyle(
                elevation: WidgetStatePropertyAll<double>(8.0),
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.red),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            IconButton(
              icon: const Icon(Icons.check),
              style: ButtonStyle(
                elevation: WidgetStatePropertyAll<double>(8.0),
                backgroundColor: WidgetStatePropertyAll<Color>(
                  const Color.fromARGB(255, 21, 106, 27),
                ),
              ),
              onPressed: submit,
            ),
          ],
        ),
      ],
    );
  }
}
