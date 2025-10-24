import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:vintage_1020/constants/enums.dart';
import 'package:vintage_1020/constants/label_input_initial_values.dart';
import 'package:vintage_1020/data/providers/my_booth_provider/my_booths_notifier.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart'
    hide userEmail;
import 'package:vintage_1020/data/local_db/local_db.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';
import 'package:vintage_1020/ui/add_item_dialog/widgets/add_to_booth_checkbox_widget.dart';
import 'package:vintage_1020/util/photo_util.dart';
import 'package:vintage_1020/ui/add_item_dialog/widgets/add_item_select_booth.dart';
import 'package:vintage_1020/ui/add_item_dialog/widgets/item_dimension_widget.dart';
import 'package:vintage_1020/ui/add_item_dialog/widgets/price_date_input_widget.dart';

/// TODO:
/// 5. useEffect to initialze controllers
class AddItemDialog extends HookConsumerWidget {
  const AddItemDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // useMemoized to prevent new instances of formKey
    final formKey = useMemoized(() => GlobalKey<FormState>());

    List<MyBooth> userBooths = ref.watch(myBoothsProvider);
    // async call initiated.
    // widgets build
    // async call finishes
    // then ref.watch is notified of state update
    // widgets rebuild
    useEffect(() {
       ref.read(myBoothsProvider.notifier).fetchUserBooths();
    }, []);

    // Controllers for TextFields/TextFormFields states
    final itemPurchasePriceController = useTextEditingController(text: '');
    final itemListingPriceController = useTextEditingController(text: '');
    final itemHeightController = useTextEditingController(text: '');
    final itemWidthController = useTextEditingController(text: '');
    final itemDepthController = useTextEditingController(text: '');

    // UseStates for non text fields states
    final purchaseDate = useState<DateTime?>(null);
    final listingDate = useState<DateTime?>(null);

    final selectedXFiles = useState<List<XFile>>([]);
    final selectedImagesAsFiles = useState<List<File>>([]);
    final itemImageUrls = useState<List<String>>([]);
    final defaultItemImageUrl = useState<String>('');

    final isChecked = useState<bool>(false);
    final currentBooths = useState<List<MyBooth>>(userBooths);
    final boothNames = useState<List<String>>([]);
    final selectedBoothName = useState<String>('');

      
    // boothNames.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    /// AFTER USER SELECTS PHOTOS OR TAKES A PHOTO, UPDATE THE EPHEMERAL STATE
    void selectPhotos() async {

      List<XFile> photosToAdd = await PhotoUtil.selectPhotosFromGallery();
      
      if(photosToAdd.isEmpty) return;
      
      // Update state of selected photos
      List<XFile> updatedSelectedXFiles = [
        ...selectedXFiles.value,
        ...photosToAdd,
      ];

       selectedXFiles.value = updatedSelectedXFiles;
    }

    void takePhoto() async {

      XFile? photoTaken = await PhotoUtil.takeCameraPhoto();

      if(photoTaken == null) return;

      selectedXFiles.value = [...selectedXFiles.value, photoTaken];
    }

    void closeDialog() {
      Navigator.of(context).pop();
    }

    Future<List<String>> savePhotosAndGetUrls() async {
      // save files
      List<File> savedImages = await PhotoUtil.saveXFileListAndReturnSavedFiles(
        selectedXFiles.value,
      );
      // get savedImages paths
      List<String> savedImagesPaths = savedImages.map((i) => i.path).toList();
      // update itemImageUrls with savedImages paths
      List<String> updatedItemImageUrls = List.from(itemImageUrls.value)
        ..addAll(savedImagesPaths);

      itemImageUrls.value = updatedItemImageUrls;

      return updatedItemImageUrls;
    }

    void submit() async {
      // Save the photos taken/selected and update the state with the urls to save
      List<String> imageUrlsToSave = await savePhotosAndGetUrls();

      final InventoryItemLocal itemToDB = InventoryItemLocal.toLocalDb(
        Uuid().v6(),
        userEmail,
        imageUrlsToSave.first,
        '',
        imageUrlsToSave,
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
        isChecked.value ? 1.0 : 0.0,
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
            PriceDateInputWidget(
              price: itemPurchasePriceController.text,
              date: purchaseDate.value,
              onPriceChanged: (value) => itemPurchasePriceController.value,
              onDateChanged: (value) => purchaseDate.value = value,
              label: purchasePriceRequiredLabel,
            ),
            PriceDateInputWidget(
              price: itemListingPriceController.text,
              date: listingDate.value,
              onPriceChanged: (value) => itemListingPriceController.value,
              onDateChanged: (value) => listingDate.value = value,
              label: listingPriceLabel,
            ),
            Flex(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.horizontal,
              children: [
                ItemDimensionWidget(
                  label: ItemDimension.height.name,
                  value: itemHeightController.text,
                  onValueChanged: (value) => itemHeightController.value,
                ),
                ItemDimensionWidget(
                  label: ItemDimension.width.name,
                  value: itemWidthController.text,
                  onValueChanged: (value) => itemWidthController.value,
                ),
                ItemDimensionWidget(
                  label: ItemDimension.depth.name,
                  value: itemDepthController.text,
                  onValueChanged: (value) => itemHeightController.value,
                ),
              ],
            ),
            Row(
            children: [
              Text(
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
                addToBoothLabel,
              ),
              Checkbox(
                value: isChecked.value,
                onChanged: (value) => {
                  isChecked.value = (value == null || value == false) ? false : true,
                }),
              ],
            ),      // AddToBoothCheckboxWidget(
            //   value: isChecked.value,
            //   onValueChanged: (value) => isChecked.value,
            // ),
            Visibility(
              visible: isChecked.value,
              child: AddItemSelectBooth(
                userBooths: userBooths,
                onValueUpdated: (value) => selectedBoothName.value = value,
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
              onPressed: selectPhotos,
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
