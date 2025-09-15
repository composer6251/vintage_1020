import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vintage_1020/data/model/inventory_item/inventory_item.dart';

class HeroLayoutCard extends StatelessWidget {
  HeroLayoutCard({
    super.key,
    required this.item,
    required this.height,
    required this.width,
  });

  final InventoryItem item;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        OverflowBox(
          maxHeight: height,
          maxWidth: width * 7 / 8,
          minWidth: width * 7 / 8,
          child: Image(
            fit: BoxFit.fitWidth,
            image: AssetImage(
              item.itemImageUrls.first
            ), // TODO: make the actual defaultImageUrl
          ),
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
