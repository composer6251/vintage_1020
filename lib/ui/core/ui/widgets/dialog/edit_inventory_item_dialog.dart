import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/data/providers/current_inventory_item/current_inventory_item.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart'
    hide userEmail;
import 'package:vintage_1020/data/local_db/local_db.dart';
import 'package:vintage_1020/ui/core/ui/widgets/dialog/common/item_dimensions_input_widget.dart';
import 'package:vintage_1020/utils/date_util.dart';

class EditInventoryItemDialog extends ConsumerStatefulWidget {

  const EditInventoryItemDialog({super.key, required this.itemEditing});

  final InventoryItemLocal itemEditing;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditInventoryItemDialogState();
}

class _EditInventoryItemDialogState
    extends ConsumerState<EditInventoryItemDialog> {

  late InventoryItemLocal itemEditing = widget.itemEditing;
  // VARIABLES TO HOLD DATE STATES
  DateTime? purchaseDate;
  DateTime? listingDate;
  DateTime? soldDate;

  // VARIABLES TO HOLD PRICE STATES
  double? purchasePrice;
  double? listingPrice;
  double? soldPrice;

  // VARIABLES TO HOLD DIMENSIONS STATES
  double? height;
  double? width;
  double? depth;

  // VARIABLE TO HOLD BOOTH STATE
  bool isBoothItem = false;

  @override
  void initState() {
    super.initState();
    purchaseDate = itemEditing.itemPurchaseDate;
    listingDate = itemEditing.itemListingDate;
    soldDate = itemEditing.itemSoldDate;
    purchasePrice = itemEditing.itemPurchasePrice;
    listingPrice = itemEditing.itemListingPrice;
    soldPrice = itemEditing.itemSoldPrice;
    height = itemEditing.itemHeight;
    width = itemEditing.itemWidth;
    depth = itemEditing.itemDepth;
    isBoothItem = itemEditing.isCurrentBoothItem == 1.0;
  }

  @override
  Widget build(BuildContext context) {

    final DateTime initialDate = DateTime.now();

    Future<void> selectDate(String type) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now().subtract(const Duration(days: 365)),
        lastDate: initialDate,
      );
      if (pickedDate == null) return; // User cancelled the date picker
      if (type == 'Listing') {
        setState(() {
          listingDate = pickedDate;
        });
        return;
      }
      if (type == 'Sold') {
        setState(() {
          soldDate = pickedDate;
        });
        return;
      }
      setState(() {
        soldDate = pickedDate;
      });
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
        purchasePrice,
        listingPrice,
        soldPrice,
        soldDate,
        listingDate,
        soldDate,
        height,
        width,
        depth,
        null,
        isBoothItem = (soldPrice != null || soldDate != null) ? false : isBoothItem,
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
                    initialValue: purchasePrice?.toString(),
                    onChanged: (value) => setState(() {
                      purchasePrice = double.tryParse(value);
                    }),
                    decoration: const InputDecoration(
                      prefixText: '\$',
                      fillColor: Colors.blue,
                      labelStyle: TextStyle(fontSize: 12),
                      labelText: 'Purchase Price*',
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
                    onPressed: () => selectDate('Purchase'),
                    child: Text(
                      getMonthDayYearStringFromDateTime(purchaseDate),
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
                    initialValue: listingPrice?.toString(),
                    onChanged: (value) => setState(() {
                      listingPrice = double.tryParse(value);
                    }),
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
                    onPressed: () => selectDate('Listing'),
                    child: Text(
                      getMonthDayYearStringFromDateTime(listingDate),
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
                    initialValue: soldPrice?.toString(),
                    onChanged: (value) => setState(() {
                      soldPrice = double.tryParse(value);
                    }),
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
                    onPressed: () => selectDate('Sold'),
                    child: Text(
                      getMonthDayYearStringFromDateTime(soldDate),
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
                SizedBox(
                  width: 80,
                  child: TextFormField(
                    initialValue: height?.toString(),
                    decoration: const InputDecoration(
                      fillColor: Colors.blue,
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      labelText: 'Height',
                      labelStyle: TextStyle(fontSize: 12)
                    ),
                    onChanged: (value) => setState(() {
                      height = double.tryParse(value);
                    }),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: TextFormField(
                    initialValue: width?.toString(),
                    decoration: const InputDecoration(
                      fillColor: Colors.blue,
                      labelText: 'Width',
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      labelStyle: TextStyle(fontSize: 12)
                    ),
                    onChanged: (value) => setState(() {
                      width = double.tryParse(value);
                    }),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: TextFormField(
                    initialValue: depth?.toString(),
                    decoration: const InputDecoration(
                      fillColor: Colors.blue,
                      labelText: 'Depth',
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      labelStyle: TextStyle(fontSize: 12)
                    ),
                    onChanged: (value) => setState(() {
                      depth = double.tryParse(value);
                    }),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
              ],
            ),
            // ItemDimensionsInputWidget(heightController: itemHeightController, widthController: itemWidthController, depthController: itemDepthController),
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
