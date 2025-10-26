import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:vintage_1020/data/providers/inventory_provider/inventory_provider.dart';
import 'package:vintage_1020/ui/add_item_dialog/widgets/add_item_dialog.dart';
import 'package:vintage_1020/ui/manage_inventory_screen/widgets/manage_inventory_screen.dart';
import 'package:vintage_1020/util/photo_util.dart';

class UiContainer extends ConsumerStatefulWidget {
  UiContainer({super.key});

  final logger = Logger(printer: PrettyPrinter());

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<UiContainer> {
  void showSnackBar(String message) {
    var sb = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(sb);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(inventoryLocalProvider);

        void quickAddItemWithPhoto() async {
      String photoTaken = await PhotoUtil.takePhotoAndReturnUrl();
      if (photoTaken == "") return;

      ref
          .read(inventoryLocalProvider.notifier)
          .quickAddInventoryItem(photoTaken);
    }

    void openAddInventoryDialog() {
      showDialog(context: context, builder: (context) => const AddItemDialog());
    }

    return Scaffold(
      body: ManageInventoryScreen(),
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton.extended(
        extendedIconLabelSpacing: 10,
        label: Text('Quick'),
        icon: FaIcon(FontAwesomeIcons.plus),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
        ),
        onPressed: quickAddItemWithPhoto,
        backgroundColor: Colors.blue,
      ),
    );
  }
}
