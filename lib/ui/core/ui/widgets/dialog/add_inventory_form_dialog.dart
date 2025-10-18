import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart' hide userEmail;
import 'package:vintage_1020/data/local_db/local_db.dart';
import 'package:vintage_1020/ui/core/ui/util/image_util.dart';
import 'package:vintage_1020/ui/core/ui/widgets/dialog/common/item_dimensions_input_widget.dart';

/// **A HOOKCONSUMER WIDGET IS ESSENTIALLY A STATELESS WIDGET, BUT UTILIZES FLUTTER HOOKS TO MANAGE STATE ***
class AddInventoryFormDialog extends HookConsumerWidget {
  const AddInventoryFormDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // useMemoized to prevent new instances of formKey
    final formKey = useMemoized(() => GlobalKey<FormState>());

    final itemPurchasePriceController = useTextEditingController();
    final itemListingPriceController = useTextEditingController();
    final itemHeightController = useTextEditingController();
    final itemWidthController = useTextEditingController();
    final itemDepthController = useTextEditingController();

    final initialDate = useState(DateTime.now());

    final purchaseDate = useState<DateTime>(DateTime.now());
    DateTime? listingDateTemp;
    final listingDate = useState(listingDateTemp);
    final selectedImages = useState<List<XFile>>([]);
    final selectedImagesAsFiles = useState<List<File>>([]);
    final itemImageUrls = useState<List<String>>([]);
    final defaultItemImageUrl = useState<String>('');
    final addToBooth = useState<bool>(false);

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
        // initialDate: initialDate.value,
        firstDate: DateTime.now().subtract(const Duration(days: 365)),
        lastDate: initialDate.value,
      );
      if (pickedDate == null) return; // User cancelled the date picker
      if (type == 'Listing') {
        listingDate.value = pickedDate;
        return;
      }
      purchaseDate.value = pickedDate;
    }

    void closeDialog(){
        Navigator.of(context).pop();
    }

    void submit() async {
      // save files
      List<File> savedImages = await saveXFileListAndReturnSavedPaths(
        selectedImages.value,
      );
      // get savedImages paths
      List<String> savedImagesPaths = savedImages.map((i) => i.path).toList();

      // update itemImageUrls with savedImages paths
      List<String> updatedItemImageUrls = List.from(itemImageUrls.value)
        ..addAll(savedImagesPaths);
      itemImageUrls.value = updatedItemImageUrls;
      // If there's only one image, make it the default image
      if (itemImageUrls.value.length == 1) {
        defaultItemImageUrl.value = itemImageUrls.value.first;
      }
      // If user selected add to booth but did NOT select a listing date, default listing date to DateTime.now
      if(listingDate.value == null && addToBooth.value) {
        listingDate.value = DateTime.now();
      }
      final InventoryItemLocal itemToDB = InventoryItemLocal.toLocalDb(
        uuid.v6(),
        userEmail,
        defaultItemImageUrl.value,
        '',
        itemImageUrls.value,
        '',
        double.tryParse(itemPurchasePriceController.text),
        double.tryParse(itemListingPriceController.text),
        null,
        purchaseDate.value,
        listingDate.value,
        null,
        double.tryParse(itemHeightController.text),
        double.tryParse(itemWidthController.text),
        double.tryParse(itemDepthController.text),
        null,
        addToBooth.value ? 1.0 : 0.0,

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
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: itemPurchasePriceController,
              decoration: const InputDecoration(
                prefixText: '\$',
                fillColor: Colors.blue,
                labelText: 'Purchase Price(required)',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Purchase Price is required' : null,
            ),
            OutlinedButton(
              style: ButtonStyle(
                elevation: WidgetStatePropertyAll<double>(8.0),
              ),
              onPressed: () => selectDate('Purchase'),
              child: Text(
                    '${purchaseDate.value.toLocal().month}/${purchaseDate.value.toLocal().day}/${purchaseDate.value.toLocal().year}',
              ),
            ),
            TextFormField(
              controller: itemListingPriceController,
              decoration: const InputDecoration(
                prefixText: '\$',
                labelText: 'Listing Price'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            OutlinedButton(
              style: ButtonStyle(
                elevation: WidgetStatePropertyAll<double>(8.0),
              ),
              onPressed: () => selectDate('Listing'),
              child: Text(
              listingDate.value == null 
              ?
              'Select Listing Date'
              :
              '${listingDate.value?.toLocal().month}/${listingDate.value?.toLocal().day}/${listingDate.value?.toLocal().year}',
              ),
            ),
      Flex(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        direction: Axis.horizontal,
        children: [
          SizedBox(
            width: 60,
            child: TextFormField(
              controller: itemHeightController,
              decoration: const InputDecoration(
                fillColor: Colors.blue,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                labelText: 'Height',
                labelStyle: TextStyle(fontSize: 12)
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ),
          SizedBox(
            width: 60,
            child: TextFormField(
              controller: itemWidthController,
              decoration: const InputDecoration(
                fillColor: Colors.blue,
                labelText: 'Width',
                floatingLabelAlignment: FloatingLabelAlignment.start,
                labelStyle: TextStyle(fontSize: 12)
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ),
          SizedBox(
            width: 60,
            child: TextFormField(
              controller: itemDepthController,
              decoration: const InputDecoration(
                fillColor: Colors.blue,
                labelText: 'Depth',
                floatingLabelAlignment: FloatingLabelAlignment.start,
                labelStyle: TextStyle(fontSize: 12)
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            ],
            ),
            Row(
              children: [
                Text(
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                  'Add to booth?'
                  ),
                Checkbox(value: addToBooth.value, onChanged: (value) => addToBooth.value = value ?? false),
              ],
            )
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
