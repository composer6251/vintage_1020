import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:vintage_1020/constants/inventory_categories.dart';
import 'package:vintage_1020/data/model/inventory_item.dart';
import 'package:vintage_1020/picture_names.dart';
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
    final itemPurchasePriceController = useTextEditingController();
    final itemImageUrlsController = useTextEditingController();
    final itemListingPriceController = useTextEditingController();
    final itemSoldPriceController = useTextEditingController();
    final defaultItemImageUrlController = useTextEditingController();
    final itemDescriptionController = useTextEditingController();

    // useState to hold inital dropdown value. Once changed it doesn't revert
    // back to original value on rebuild.
    final category = useState(InventoryCategory.furniture);

    final initialDate = useState(DateTime.now());

    final purchaseDate = useState(DateTime.now());
    final listingDate = useState(DateTime.now());
    final soldDate = useState(DateTime.now());

    Future<void> selectDate(String type) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate.value,
        firstDate: DateTime.now().subtract(const Duration(days: 365)),
        lastDate: initialDate.value,
      );
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

    List<String> addMockImages() {
      List<String> mockImages = [];
      mockImages.add(PictureNames.picListFurniture.elementAt(
                  Random().nextInt(PictureNames.picListFurniture.length)));
      mockImages.add(PictureNames.picListFurniture.elementAt(
                  Random().nextInt(PictureNames.picListFurniture.length)));
      mockImages.add(PictureNames.picListFurniture.elementAt(
                  Random().nextInt(PictureNames.picListFurniture.length)));


      return mockImages;
    }

    void submit() {
      if (formKey.currentState?.validate() ?? false) {
        ref
            .read(inventoryNotifierProvider.notifier)
            .addInventoryItem(
              InventoryItem(
                id: Uuid().v4(),
                itemCategory: InventoryCategory.furniture,
                itemImageUrls: addMockImages(),
                itemPurchaseDate: purchaseDate.value,
                itemPurchasePrice: double.tryParse(
                  itemPurchasePriceController.text,
                ),
                itemListingDate: listingDate.value,
                itemListingPrice: double.tryParse(itemListingPriceController.text),
                itemSoldDate: soldDate.value,
                itemSoldPrice: double.tryParse(itemSoldPriceController.text),
              ),
            );

            Navigator.of(context).pop(); // Close the dialog
      }
    }

    return AlertDialog(
      title: const Text('Add to Inventory'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
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
            TextFormField(
              controller: itemPurchasePriceController,
              decoration: const InputDecoration(fillColor: Colors.blue, labelText: 'Purchase Price'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Purchase Price is required' : null,
            ),
            OutlinedButton(
              style: ButtonStyle(
                elevation: WidgetStatePropertyAll<double>(8.0),
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Colors.blue,
                ),
              ),
              onPressed: () => selectDate('Purchase'),
              child: Text(purchaseDate.value == null
                  ? 'Select Purchase Date'
                  : 'Purchase Date: ${purchaseDate.value.toLocal().month}/${purchaseDate.value.toLocal().day}/${purchaseDate.value.toLocal().year}'),
            ),
            TextFormField(
              controller: itemListingPriceController,
              decoration: const InputDecoration(labelText: 'Listing Price'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            OutlinedButton(
              style: ButtonStyle(
                elevation: WidgetStatePropertyAll<double>(8.0),
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Colors.blue,
                ),
              ),
              onPressed: () => selectDate('Listing'),
              child: Text(listingDate.value == null
                  ? 'Select Listing Date'
                  : 'Listing Date: ${listingDate.value.toLocal().month}/${listingDate.value.toLocal().day}/${listingDate.value.toLocal().year}'),
            ),
            TextFormField(
              controller: itemSoldPriceController,
              decoration: const InputDecoration(labelText: 'Selling Price'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            OutlinedButton(
              style: ButtonStyle(
                elevation: WidgetStatePropertyAll<double>(8.0),
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Colors.blue,
                ),
              ),
              onPressed: () => selectDate('Sold'),
              child: Text(soldDate.value == null
                  ? 'Select Sold Date'
                  : 'Sold Date: ${soldDate.value.toLocal().month}/${soldDate.value.toLocal().day}/${soldDate.value.toLocal().year}'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            elevation: WidgetStatePropertyAll<double>(8.0),
            backgroundColor: WidgetStatePropertyAll<Color>(
              Colors.red,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          style: ButtonStyle(
            elevation: WidgetStatePropertyAll<double>(8.0),
            backgroundColor: WidgetStatePropertyAll<Color>(
              Colors.blue,
            ),
          ),
          onPressed: takePhoto,
          child: const Text('Take Photo'),
        ),
        TextButton(
          style: ButtonStyle(
            elevation: WidgetStatePropertyAll<double>(8.0),
            backgroundColor: WidgetStatePropertyAll<Color>(
              Colors.blue,
            ),
          ),
          onPressed: takePhoto,
          child: const Text('Select Photo'),
        ),
        TextButton(
          style: ButtonStyle(
            elevation: WidgetStatePropertyAll<double>(8.0),
            backgroundColor: WidgetStatePropertyAll<Color>(
              Colors.green,
            ),
          ),
          onPressed: submit,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
