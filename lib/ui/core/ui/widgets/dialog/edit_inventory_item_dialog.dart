import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/data/providers/current_inventory_item/current_inventory_item.dart';
import 'package:vintage_1020/data/providers/inventory_notifier.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart'
    hide userEmail;
import 'package:vintage_1020/data/local_db/local_db.dart';
import 'package:vintage_1020/ui/core/ui/widgets/dialog/common/item_dimensions_dial.dart';
import 'package:vintage_1020/ui/core/ui/widgets/dialog/common/item_dimensions_input_widget.dart';
import 'package:vintage_1020/utils/snack_bar.dart';

class EditInventoryItemDialog extends StatefulHookConsumerWidget {
  const EditInventoryItemDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditInventoryItemDialogState();
}

class _EditInventoryItemDialogState
    extends ConsumerState<EditInventoryItemDialog> {
  @override
  Widget build(BuildContext context) {
    // useMemoized to prevent new instances of formKey
    final formKey = useMemoized(() => GlobalKey<FormState>());

    final itemEditing = ref.watch(currentInventoryItemProvider);
    
    // TODO: Update state upon value change. Update state & DB upon submit
    // THAT WAY THE UI is updated
    
    // Form Field Controllers
    final itemPurchasePriceController = useTextEditingController(
      text: itemEditing.itemPurchasePrice?.toString(),
    );
    final itemListingPriceController = useTextEditingController(
      text: itemEditing.itemListingPrice?.toString(),
    );
    final itemSellingPriceController = useTextEditingController(
      text: itemEditing.itemSoldPrice?.toString(),
    );
    final itemHeightController = useTextEditingController(
      text: itemEditing.itemHeight?.toString(),
    );
    final itemWidthController = useTextEditingController(
      text: itemEditing.itemWidth?.toString(),
    );
    final itemDepthController = useTextEditingController(
      text: itemEditing.itemDepth?.toString(),
    );

    final initialDate = useState(DateTime.now());
    DateTime? purchaseDateTemp;
    final purchaseDate = useState(
      itemEditing.itemPurchaseDate ?? purchaseDateTemp,
    );
    DateTime? listingDateTemp;
    final listingDate = useState(
      itemEditing.itemListingDate ?? listingDateTemp,
    );
    DateTime? soldDateTemp;
    final soldDate = useState(itemEditing.itemSoldDate ?? soldDateTemp);
    final addToBooth = useState<bool>(
      itemEditing.isCurrentBoothItem == 0.0 ? false : true,
    );

    Future<void> selectDate(String type) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now().subtract(const Duration(days: 365)),
        lastDate: initialDate.value,
      );
      if (pickedDate == null) return; // User cancelled the date picker
      if (type == 'Listing') {
        listingDateTemp = pickedDate;
        listingDate.value = pickedDate;
        return;
      }
      if (type == 'Sold') {
        soldDateTemp = pickedDate;
        soldDate.value = pickedDate;
        return;
      }
      purchaseDate.value = pickedDate;
    }

    void closeDialog() {
      Navigator.of(context).pop();
    }

    void addItemToBooth(String itemId) {
      ref.read(inventoryProvider.notifier).addItemToBooth(itemId);

      showSnackBar('Item added to booth!', context);
    }

    void updateStateChange() {
      final InventoryItemLocal itemToDB = InventoryItemLocal.toLocalDb(
        uuid.v6(),
        userEmail,
        itemEditing.primaryImageUrl,
        '',
        itemEditing.itemImageUrls,
        '',
        double.tryParse(itemPurchasePriceController.text),
        double.tryParse(itemListingPriceController.text),
        double.tryParse(
          itemSellingPriceController.text,
        ), // Todo: Update selling date
        purchaseDate.value,
        listingDate.value,
        soldDate.value,
        double.tryParse(itemHeightController.text),
        double.tryParse(itemWidthController.text),
        double.tryParse(itemDepthController.text),
        null,
        addToBooth.value ? 1 : 0,
      );

      if (formKey.currentState?.validate() ?? false) {
        ref
            .watch(inventoryLocalProvider.notifier)
            .updateCurrentInventoryItemById(itemToDB);
      }
    }

    void submit() async {
      updateStateChange();

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
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Flexible(
                  flex: 5,
                  child: TextFormField(
                    controller: itemPurchasePriceController,
                    decoration: const InputDecoration(
                      prefixText: '\$',
                      fillColor: Colors.blue,
                      labelStyle: TextStyle(fontSize: 20),
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
                      purchaseDate.value == null
                          ? 'Select Date'
                          : '${purchaseDate.value?.toLocal().month}/${purchaseDate.value?.toLocal().day}/${purchaseDate.value?.toLocal().year}',
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
                    controller: itemListingPriceController,
                    decoration: const InputDecoration(
                      prefixText: '\$',
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      labelStyle: TextStyle(fontSize: 20),
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
                      itemEditing.itemListingDate == null
                          ? 'Select Date'
                          : '${listingDate.value?.toLocal().month}/${listingDate.value?.toLocal().day}/${listingDate.value?.toLocal().year}',
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
                    controller: itemSellingPriceController,
                    decoration: const InputDecoration(
                      prefixText: '\$',
                      labelStyle: TextStyle(fontSize: 20),
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
                      itemEditing.itemSoldDate == null
                          ? 'Select Date'
                          : '${soldDate.value?.toLocal().month}/${soldDate.value?.toLocal().day}/${soldDate.value?.toLocal().year}',
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            ItemDimensionsInputWidget(),
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
              iconSize: 30,
              padding: EdgeInsets.all(0),
              tooltip: 'Add to current booth',
              onPressed: () => addItemToBooth(itemEditing.id),
              icon: FaIcon(FontAwesomeIcons.tentArrowDownToLine),
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
