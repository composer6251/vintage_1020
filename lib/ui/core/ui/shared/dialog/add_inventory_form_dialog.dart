import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:vintage_1020/constants/inventory_categories.dart';
import 'package:vintage_1020/data/model/inventory_item.dart';
import 'package:vintage_1020/providers/inventory_provider.dart';
import 'package:vintage_1020/utils/picture_util.dart';

/// **A HookConsumerWidget IS ESSENTIALLY A STATELESS WIDGET, BUT UTILIZES FLUTTER HOOKS TO MANAGE STATE ***
class AddInventoryFormDialog extends HookConsumerWidget {
  const AddInventoryFormDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // useMemoized to prevent new instances of formKey
    final formKey = useMemoized(() => GlobalKey<FormState>());

    final itemCategoryController = useTextEditingController();
    final itemPurchaseDateController = useTextEditingController();
    final itemPurchasePriceController = useTextEditingController();
    final itemImageUrlsController = useTextEditingController();

    final itemListingDateController = useTextEditingController();
    final itemListingPriceController = useTextEditingController();
    final itemSoldDateController = useTextEditingController();
    final itemSoldPriceController = useTextEditingController();
    final defaultItemImageUrlController = useTextEditingController();
    final itemDescriptionController = useTextEditingController();


    // useState to hold inital dropdown value. Once changed it doesn't revert
    // back to original value on rebuild.
    final category = useState(InventoryCategory.furniture);
    final purchaseDate = useState(itemPurchasePriceController.text);
    final listingDate = useState(itemPurchasePriceController.text);

    Future<void> _selectDate() async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime(2021, 7, 25),
        firstDate: DateTime(2021),
        lastDate: DateTime(2022),
      );
      // useSt
    }

    void submit() {
      if (formKey.currentState?.validate() ?? false) {
        ref
            .read(inventoryNotifierProvider.notifier)
            .addInventoryItem(
              InventoryItem(
                id: Uuid().v4(),
                itemCategory: InventoryCategory.furniture,
                itemImageUrls: [itemImageUrlsController.text],
                itemPurchaseDate: DateTime.parse(itemPurchaseDateController.text), 
                itemPurchasePrice: double.parse(itemPurchasePriceController.text),
                itemListingDate: DateTime.parse(itemListingDateController.text),
                itemListingPrice: double.parse(itemListingPriceController.text),
                // itemSoldDate: DateTime.parse(itemSoldDateController.text),
                itemSoldPrice: double.parse(itemSoldPriceController.text)
              
                ),
            );
            // Close the dialog box
            Navigator.of(context).pop();
      }
    }

    return AlertDialog(
      title: const Text('Add to Inventory'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<InventoryCategory>(
              value: category.value,
              onChanged: (value) {
                if (value != null) {}
              },
              items: const [
                DropdownMenuItem(
                  value: InventoryCategory.furniture,
                  child: Text('Furniture'),
                ),
                DropdownMenuItem(
                  value: InventoryCategory.lamps,
                  child: Text('Lamps'),
                ),
                DropdownMenuItem(
                  value: InventoryCategory.wallDecor,
                  child: Text('Wall Decor'),
                ),
                DropdownMenuItem(
                  value: InventoryCategory.paintings,
                  child: Text('Paintings'),
                ),
                DropdownMenuItem(
                  value: InventoryCategory.pictures,
                  child: Text('Pictures'),
                ),
                DropdownMenuItem(
                  value: InventoryCategory.miscellaneous,
                  child: Text('Miscellaneous'),
                ),
              ],
            ),
            ElevatedButton(
              child: Text('Purchase Date'),
              onPressed: () => _selectDate(),
            ),
            TextFormField(
              controller: itemPurchasePriceController,
              decoration: const InputDecoration(labelText: 'Purchase Price'),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter reps' : null,
            ),
            ElevatedButton(
              child: Text('Listing Date'),
              onPressed: () => _selectDate(),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: itemPurchasePriceController,
              decoration: const InputDecoration(labelText: 'Listing Price'),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter reps' : null,
            ),
            ElevatedButton(
              child: Text('Purchase Date'),
              onPressed: () => _selectDate(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(onPressed: submit, child: const Text('Add')),
        TextButton(onPressed: takePhoto, child: const Text('Add')),
      ],
    );
  }
}
