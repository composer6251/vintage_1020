import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:vintage_1020/data/model/inventory_item/inventory_item.dart';
import 'package:vintage_1020/domain/providers/firestore_provider/firestore_provider.dart';
import 'package:vintage_1020/ui/core/ui/util/image_util.dart';
import 'package:path_provider/path_provider.dart' as sys_path;
import 'package:path/path.dart' as path;

/// **A HookConsumerWidget IS ESSENTIALLY A STATELESS WIDGET, BUT UTILIZES FLUTTER HOOKS TO MANAGE STATE ***
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
    final _photo = useState<XFile?>(null);
    final _selectedPhotos = useState<List<XFile?>?>(null);
    final itemImageUrls = useState<List<String>>([]);
    final _defaultItemImageUrl = useState<String>('');

    void saveImageToAlbum(XFile image) async {
      if (image.path.isEmpty) return;
      // Get directory on local device for storing images.
      final appDir = await sys_path.getApplicationDocumentsDirectory();
      // Get filename of image
      String appDirPath = appDir.path;
      print('appDir Path: $appDirPath');
      // final String name = image.name;
      // print('fileName Path: $name');

      // // final fileName = path.basename(appDirPath);
      // final fileName = ('$appNameForImages/testOne');

      // final savedFilePath = '${appDir.path}/$fileName';
      // final p = await image.saveTo(savedFilePath);
      // print('fileName saved: $savedFilePath');

      // try {
      //   final savedFile = await file.copy(savedFilePath);
      //   final p = savedFile.path;
      //   print('Ppath: $p');
      // } catch (ex) {
      //   print('ex for savedFile: $ex');
      // }

      try {
        // Create album if it doesn't exist
        AssetPathEntity? pathEntity = await createInventoryPhotoAlbum(
          appNameForImages,
        );
        if (pathEntity == null) {
          print('Failed to create album: $appNameForImages');
          return;
        }

        AssetEntity savedImage = await saveImage(image.path, null);
        final assetEntityFile = await savedImage.file;
        // final copiedPath = await assetEntityFile?.copy(savedFilePath);
        // Adds image reference to the album created above
        await PhotoManager.plugin.copyAssetToGallery(savedImage, pathEntity);

        String? photoUrl = await PhotoManager.plugin.getFullFile(
          savedImage.id,
          isOrigin: false,
        );
        // print(
        //   // 'savedFilePath: $savedFilePath \n photoUrl: $photoUrl \n assetEnt: ${copiedPath!.path}',
        // );
        // Update state with selected image Urls
        itemImageUrls.value = List.from(itemImageUrls.value)
          ..addAll([photoUrl!]);
      } catch (ex) {
        print('Error saving image to album: $ex');
      }
    }

    Future<void> takePhoto() async {
      final picker = ImagePicker();
      XFile? image = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 90,
      );
      if (image != null) {
        // If we have no default image, set the first taken image as default
        // TODO: AFTER SAVING, THIS SHOULD BE BASED OFF OF WHAT THE PROVIDER HAS
        if (_defaultItemImageUrl.value.isEmpty) {
          _defaultItemImageUrl.value = image.path;
        }
        _photo.value = image;

        saveImageToAlbum(image);
        print('Image taken and saved to state ${_photo.value?.path}');
      }
      if (itemImageUrls.value.isEmpty) {
        itemImageUrls.value = [image!.path];
        print(
          'updating itemImageUrls is empty in takePhoto. Path: ${image.path}',
        );
      } else {
        print('No image selected');
      }
    }

    Future<void> pickMultipleImagesFromGallery() async {
      print('Picking multiple images from gallery...');
      final picker = ImagePicker();
      final List<XFile> pickedFiles = await picker.pickMultiImage();

      if (pickedFiles.isNotEmpty) {
        _selectedPhotos.value = pickedFiles;
        // SAVE FILES
        for (var pickedFile in pickedFiles) {
          // Save each picked file to the app documents directory
          saveImageToAlbum(pickedFile);
        }

        print('${pickedFiles.length} images picked.');
        // Images were successfully picked
      } else {
        // User canceled the picker or selected nothing
        print('No images selected.');
      }
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

    void submit() {
      final InventoryItem itemToSave = InventoryItem(
        itemCategory: 'Furniture',
        itemImageUrls: itemImageUrls.value,
        itemPurchaseDate: purchaseDate.value,
        itemPurchasePrice: double.tryParse(itemPurchasePriceController.text),
        itemListingDate: listingDate.value,
        itemListingPrice: double.tryParse(itemListingPriceController.text),
        itemSoldDate: soldDate.value,
        itemSoldPrice: double.tryParse(itemSoldPriceController.text),
      );

      if (formKey.currentState?.validate() ?? false) {
        ref
            .watch(firestoreProviderProvider.notifier)
            .addUserInventoryItem(itemToSave);

        Navigator.of(context).pop(); // Close the dialog

        // saveInventoryItem(itemToSave)
        //     .then((savedItem) {
        //       if (savedItem != null) {
        //         print('Inventory item saved successfully: ${savedItem.id}');
        //       } else {
        //         print('Failed to save inventory item');
        //       }
        //     })
        //     .catchError((error) {
        //       print('Error saving inventory item: $error');
        //     });
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
              onPressed: pickMultipleImagesFromGallery,
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
