import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/data/providers/my_booth_filter/current_booth_provider.dart';
import 'package:vintage_1020/data/providers/my_booth_provider/my_booths_notifier.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';
import 'package:vintage_1020/ui/common/dialog/confirmation_dialog.dart';
import 'package:vintage_1020/util/photo_util.dart';

class QuickAddItemButtonWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void displayAddToBoothConfirmation(String photoUrl) async {

      InventoryItemLocal itemToSave = InventoryItemLocal.empty(Uuid().v6());
      itemToSave.userEmail = userEmail;
      itemToSave.itemImageUrls = [photoUrl];
      itemToSave.primaryImageUrl = photoUrl;

      OkCancelResult result = await showConfirmDialog(
        'Add item to booth?',
        context,
      );

      print('selected quick add yes/no: ${result.name}');

      await ref
          .read(inventoryLocalProvider.notifier)
          .addUserInventoryItemLocal(itemToSave);

      if (result.name == 'ok') {
        MyBooth boothToUpdate = ref.read(currentBoothProvider);

        boothToUpdate.boothInventoryIds.add(itemToSave.id);
        boothToUpdate.boothInventory?.add(itemToSave);

        print(
          'quick add item to booth with num items ${boothToUpdate.boothInventoryIds.length}',
        );

        await ref.read(myBoothsProvider.notifier).updateBooth(boothToUpdate);
      }
    }

    void quickAddItemWithPhoto() async {
      String photoTaken = await PhotoUtil.takePhotoAndReturnUrl();
      if (photoTaken == "") return;

      displayAddToBoothConfirmation(photoTaken);
    }

    return OutlinedButton(
      onPressed: quickAddItemWithPhoto,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(style: TextStyle(fontSize: 16, color: Colors.white), 'Quick'),
          FaIcon(color: Colors.white, FontAwesomeIcons.plus),
        ],
      ),
    );
  }
}
