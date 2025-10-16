
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/data/providers/inventory_notifier.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart' hide userEmail;
import 'package:vintage_1020/data/local_db/local_db.dart';
import 'package:vintage_1020/ui/core/ui/widgets/dialog/common/item_dimensions_dial.dart';
import 'package:vintage_1020/ui/core/ui/widgets/dialog/common/item_dimensions_input_widget.dart';

/// **A HOOKCONSUMER WIDGET IS ESSENTIALLY A STATELESS WIDGET, BUT UTILIZES FLUTTER HOOKS TO MANAGE STATE ***
class EditInventoryItemDialog extends HookConsumerWidget {
  const EditInventoryItemDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // useMemoized to prevent new instances of formKey
    final formKey = useMemoized(() => GlobalKey<FormState>());

    final items = ref.watch(inventoryProvider);

    final itemEditing = items.first;

    // Form Field Controllers
    final itemPurchasePriceController = useTextEditingController(text: itemEditing.itemPurchasePrice.toString());
    final itemListingPriceController = useTextEditingController(text: itemEditing.itemListingPrice.toString());
    final itemHeightController = useTextEditingController(text: itemEditing.itemHeight == null ? '0' : itemEditing.itemHeight.toString());
    final itemWidthController = useTextEditingController(text: itemEditing.itemWidth == null ? '0' : itemEditing.itemWidth.toString());
    final itemDepthController = useTextEditingController(text: itemEditing.itemDepth == null ? '0' : itemEditing.itemDepth.toString());

    // Hooks for holding data
    final initialDate = useState(DateTime.now());
    final purchaseDate = useState(DateTime.now());
    // final listingDate = useState<DateTime>(DateTime.now());
    DateTime listingDate;
    // final soldDate = useState(DateTime.now());
    final addToBooth = useState<bool>(itemEditing.isCurrentBoothItem == 0.0 ? false : true);

    Future<void> selectDate(String type) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now().subtract(const Duration(days: 365)),
        lastDate: initialDate.value,
      );
      if (pickedDate == null) return; // User cancelled the date picker
      if (type == 'Listing') {
        listingDate = pickedDate;
        return;
      }
      purchaseDate.value = pickedDate;
    }

    void closeDialog(){
        Navigator.of(context).pop();
    }

    void submit() async {
      
      final InventoryItemLocal itemToDB = InventoryItemLocal.toLocalDb(
        uuid.v6(),
        userEmail,
        itemEditing.primaryImageUrl,
        '',
        itemEditing.itemImageUrls,
        '',
        double.tryParse(itemPurchasePriceController.text),
        double.tryParse(itemListingPriceController.text),
        null, // Todo: Update selling date
        purchaseDate.value,
        null,
        null,
        int.tryParse(itemHeightController.text),
        int.tryParse(itemWidthController.text),
        int.tryParse(itemDepthController.text),
        null,
        addToBooth.value ? 1 : 0,

      );
      // TODO: Need to validate Purchase price???
      if (formKey.currentState?.validate() ?? false) {
        ref
            .watch(inventoryLocalProvider.notifier)
            .addUserInventoryItemLocal(itemToDB);
        closeDialog();
      }
    }
    List<int> measurements = List<int>.generate(120, (index) => index + 1);

    return AlertDialog(
      title: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.tealAccent])),
        child: Center(
          child: const Text(
            selectionColor: Colors.blue,
            'Edit Item',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                      fillColor: Colors.blue,
                      labelStyle: TextStyle(fontSize: 20),
                      labelText: 'Purchase Price*',
                    ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Purchase Price is required' : null,
                  ),
                ),
                Spacer(),
                Flexible(
                  flex: 5,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      elevation: WidgetStatePropertyAll<double>(8.0),
                      backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
                    ),
                    onPressed: () => selectDate('Purchase'),
                    child: Text(
                      '${purchaseDate.value.toLocal().month}/${purchaseDate.value.toLocal().day}/${purchaseDate.value.toLocal().year}',
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
                      labelStyle: TextStyle(fontSize: 20),
                      fillColor: Colors.blue,
                      labelText: 'Listing Price',
                    ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                Spacer(),
                Flexible(
                  flex: 5,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      elevation: WidgetStatePropertyAll<double>(8.0),
                      backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
                    ),
                    onPressed: () => selectDate('Listing'),
                    child: Text(
                      'Listed Date'
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
                      labelStyle: TextStyle(fontSize: 20),
                      fillColor: Colors.blue,
                      labelText: 'Selling Price',
                    ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                Spacer(),
                Flexible(
                  flex: 5,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      elevation: WidgetStatePropertyAll<double>(8.0),
                      backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
                    ),
                    onPressed: () => selectDate('Sold'),
                    child: Text(
                      style: TextStyle(fontSize: 16),
                      'Sold Date'
                    ),
                  ),
                ),
              ],
            ),
            
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
                  // style: ButtonStyle(backgroundColor: Color(Colors.blue)),
                  onPressed: () => Navigator.pushNamed(context, '/edit-inventory-item'), 
                  child: Text('Edit Pics')),
              ),
            ),
            Flexible(
              flex: 3,
              child: Text(
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                'Add to booth'
              ),
            ),
            Flexible(
              flex: 4,
              child: Switch(
                activeThumbColor: Colors.blue,
                inactiveThumbColor: Colors.grey,
                value: false, onChanged: (value) => value = !value),
            ),
        ],),
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
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.green),
              ),
              onPressed: submit,
            ),
          ],
        ),
      ],
    );
  }
}
