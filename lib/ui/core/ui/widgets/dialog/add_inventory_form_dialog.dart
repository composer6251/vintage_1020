import 'dart:io';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:uuid/uuid.dart';
import 'package:vintage_1020/data/model/inventory_item/inventory_item.dart';
import 'package:vintage_1020/data/model/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/domain/providers/firestore_provider/firestore_provider.dart' hide userEmail;
import 'package:vintage_1020/domain/providers/inventory_local_provider/inventory_local_provider.dart' hide userEmail;
import 'package:vintage_1020/domain/providers/inventory_provider/inventory_provider.dart' hide userEmail;
import 'package:vintage_1020/domain/sqflite/local_db.dart';
import 'package:vintage_1020/ui/core/ui/util/image_util.dart';
import 'package:path_provider/path_provider.dart' as sys_path;

/// **A HOOKCONSUMER WIDGET IS ESSENTIALLY A STATELESS WIDGET, BUT UTILIZES FLUTTER HOOKS TO MANAGE STATE ***
class AddInventoryFormDialog extends HookConsumerWidget {
  const AddInventoryFormDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // useMemoized to prevent new instances of formKey
    final formKey = useMemoized(() => GlobalKey<FormState>());

    final itemPurchasePriceController = useTextEditingController();
    final itemListingPriceController = useTextEditingController();
    final itemSoldPriceController = useTextEditingController();

    final initialDate = useState(DateTime.now());

    final purchaseDate = useState(DateTime.now());
    final listingDate = useState(DateTime.now());
    final soldDate = useState(DateTime.now());
    final selectedImages = useState<List<XFile>>([]);
    final selectedImagesAsFiles = useState<List<File>>([]);
    final itemImageUrls = useState<List<String>>([]);
    final defaultItemImageUrl = useState<String>('');

    /// AFTER USER SELECTS PHOTOS OR TAKES A PHOTO, UPDATE THE EPHEMERAL STATE
    void updateSelectedImagesState(List<XFile> imagesToAdd) {
      final List<XFile> newImagesState = List.from(selectedImagesAsFiles.value)
        ..addAll(imagesToAdd);
      selectedImages.value = newImagesState;
    }

    /// TAKE PHOTO ON PHOTO AND USE FOR ITEM
    Future<void> takePhoto() async {
      final XFile? photoTaken = await takeCameraPhoto();
      
      if(photoTaken == null) return;

      // UPDATE STATE. PASS IN IMAGES AS LIST
      updateSelectedImagesState([photoTaken]);
    }

    Future<void> selectImages() async {
      List<XFile> selectedImagesFromGallery =
          await pickMultipleImagesFromGallery();
      
      if(selectedImagesFromGallery.isEmpty) return;

      updateSelectedImagesState(selectedImagesFromGallery);
    }

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


    void closeDialog(){
        Navigator.of(context).pop(); // Close the dialog
    }

    void submit() async {
      // 1. save files(image_util.)
      List<File> savedImages = await saveXFileListAndReturnSavedPaths(
        selectedImages.value,
      );
      // 2. get savedImages paths
      List<String> savedImagesPaths = savedImages.map((i) => i.path).toList();

      // 3. update itemImageUrls with savedImages paths
      List<String> updatedItemImageUrls = List.from(itemImageUrls.value)
        ..addAll(savedImagesPaths);
      itemImageUrls.value = updatedItemImageUrls;
      // 4. If there's only one image, make it the default image
      if (itemImageUrls.value.length == 1) {
        defaultItemImageUrl.value = itemImageUrls.value.first;
      }
      // 5. save inventoryItem through provider
      // 6. save inventoryItem to localDB
      final InventoryItemLocal itemToDB = InventoryItemLocal.toLocalDb(
        uuid.v6(),
        userEmail,
        defaultItemImageUrl.value,
        '',
        itemImageUrls.value,
        'DEFAULT CATEGORY',
        double.tryParse(itemPurchasePriceController.text),
        double.tryParse(itemListingPriceController.text),
        double.tryParse(itemPurchasePriceController.text),
        purchaseDate.value,
        listingDate.value,
        soldDate.value,
        null,
      );

      if (formKey.currentState?.validate() ?? false) {
        ref
            .watch(inventoryLocalProvider.notifier)
            .addUserInventoryItemLocal(itemToDB);
        closeDialog();
      }
    }

    return AlertDialog(
      title: Center(
        child: const Text(
          'Add to Inventory',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            // DropdownButtonFormField<String>(
            //   value: 'Test',
            //   onChanged: (value) {
            //     if (value != null) {}
            //   },
            //   items: const [
            //     DropdownMenuItem(
            //       value: 'furn',
            //       child: Text('Furniture'),
            //     ),
            //     DropdownMenuItem(
            //       value: 'lam',
            //       child: Text('Lamps'),
            //     ),
            //     // DropdownMenuItem(
            //     //   value: 'Wall Decor',
            //     //   child: Text('Wall Decor'),
            //     // ),
            //     // DropdownMenuItem(
            //     //   value: 'Painting',
            //     //   child: Text('Paintings'),
            //     // ),
            //     // DropdownMenuItem(
            //     //   value: 'Picture',
            //     //   child: Text('Pictures'),
            //     // ),
            //     // DropdownMenuItem(
            //     //   value: 'Miscellaneous',
            //     //   child: Text('Miscellaneous'),
            //     // ),
            //   ],
            // ),
            TextFormField(
              controller: itemPurchasePriceController,
              decoration: const InputDecoration(
                fillColor: Colors.blue,
                labelText: 'Purchase Price',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Purchase Price is required' : null,
            ),
            OutlinedButton(
              style: ButtonStyle(
                elevation: WidgetStatePropertyAll<double>(8.0),
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
              ),
              onPressed: () => selectDate('Purchase'),
              child: Text(
                purchaseDate.value == null
                    ? 'Select Purchase Date'
                    : 'Purchase Date: ${purchaseDate.value.toLocal().month}/${purchaseDate.value.toLocal().day}/${purchaseDate.value.toLocal().year}',
              ),
            ),
            TextFormField(
              controller: itemListingPriceController,
              decoration: const InputDecoration(labelText: 'Listing Price'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            OutlinedButton(
              style: ButtonStyle(
                elevation: WidgetStatePropertyAll<double>(8.0),
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
              ),
              onPressed: () => selectDate('Listing'),
              child: Text(
                listingDate.value == null
                    ? 'Select Listing Date'
                    : 'Listing Date: ${listingDate.value.toLocal().month}/${listingDate.value.toLocal().day}/${listingDate.value.toLocal().year}',
              ),
            ),
            TextFormField(
              controller: itemSoldPriceController,
              decoration: const InputDecoration(labelText: 'Selling Price'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            OutlinedButton(
              style: ButtonStyle(
                elevation: WidgetStatePropertyAll<double>(8.0),
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
              ),
              onPressed: () => selectDate('Sold'),
              child: Text(
                soldDate.value == null
                    ? 'Select Sold Date'
                    : 'Sold Date: ${soldDate.value.toLocal().month}/${soldDate.value.toLocal().day}/${soldDate.value.toLocal().year}',
              ),
            ),
          ],
        ),
      ),
      actions: [
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
              icon: const Icon(Icons.photo_camera),
              tooltip: 'Take Photo',
              style: ButtonStyle(
                elevation: WidgetStatePropertyAll<double>(8.0),
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
              ),
              onPressed: takePhoto,
            ),
            IconButton(
              icon: const Icon(Icons.photo_library),
              tooltip: 'Pick Images from Gallery',
              style: ButtonStyle(
                elevation: WidgetStatePropertyAll<double>(8.0),
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
              ),
              onPressed: selectImages,
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
