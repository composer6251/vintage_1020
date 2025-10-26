import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/util/photo_util.dart';

class CustomFab extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    void quickAddItemWithPhoto() async {
      String photoTaken = await PhotoUtil.takePhotoAndReturnUrl();
      if (photoTaken == "") return;

      ref.read(inventoryLocalProvider.notifier).quickAddInventoryItem(photoTaken);
    }

    return FloatingActionButton.extended(
      extendedIconLabelSpacing: 10,
      label: Text('Quick'),
      icon: FaIcon(FontAwesomeIcons.plus),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
      ),
      onPressed: quickAddItemWithPhoto,
      backgroundColor: Colors.blue,
    );
  }
}
