import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vintage_1020/data/model/inventory_item_local/inventory_item_local.dart';
import 'package:vintage_1020/domain/providers/inventory_local_provider/inventory_local_provider.dart';
import 'package:path_provider/path_provider.dart' as sys_path;
import 'package:path/path.dart' as path;

class HeroLayoutCard extends ConsumerWidget {
  HeroLayoutCard({
    super.key,
    required this.item,
    required this.height,
    required this.width,
  });

  final InventoryItemLocal item;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(inventoryLocalProvider.notifier);
    return item.primaryImageUrl == null
        ? Container()
        : Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: <Widget>[
              OverflowBox(
                maxHeight: height,
                maxWidth: width * 7 / 8,
                minWidth: width * 7 / 8,
                // child: Image.memory(item.getPrimaryImage.readAsBytesSync()),
                // child: Image.file(item.getPrimaryImage)
                child: Image.file(File(item.getPrimaryImage.path)),
              ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(18.0, 18, 18, 18),
              //   child: Flexible(
              //     fit: FlexFit.loose,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisSize: MainAxisSize.max,
              //       children: <Widget>[
              //         Text(
              //           '\$${item.itemListingPrice}',
              //           overflow: TextOverflow.clip,
              //           softWrap: true,
              //           textAlign: TextAlign.center,
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               color: Colors.white,
              //               fontSize: 24),
              //         ),
              //         const SizedBox(height: 10),
              //         Text(
              //           'Listed: ${item.itemListingDate != null ? DateFormat.yMMMEd().format(item.itemListingDate!) : 'Unknown'}',
              //           overflow: TextOverflow.clip,
              //           softWrap: true,
              //           // style: TextStyle(
              //           //     fontWeight: FontWeight.bold,
              //           //     color: Colors.white,
              //           //     fontSize: 24),
              //           style: Theme.of(
              //             context,
              //           ).textTheme.bodyMedium?.copyWith(color: Colors.white),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          );
  }
}
