import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vintage_1020/domain/inventory_item_local/inventory_item_local.dart';

class BoothItem extends HookConsumerWidget {
  const BoothItem({super.key, required this.model});

  final InventoryItemLocal model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

  File? itemPrimaryImage = model.getPrimaryImage;

    return model == null
    ? Container()
    : Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: Colors.black),
        ),
        child: model.primaryImageUrl == null
        ? Text('No Primary Image set for Item')
        : Image.file(
          fit: BoxFit.fill,
          itemPrimaryImage
          ),
      );
  }
}
