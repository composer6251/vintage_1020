import 'package:flutter/material.dart';
import 'package:vintage_1020/domain/models/model/inventory_item/inventory_item.dart';

class HeroLayoutCard extends StatelessWidget {
  HeroLayoutCard({super.key, required this.item, required this.height, required this.width});

  final InventoryItem item;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    // If no height/width are passed, size yourself according to defaults.
    // height ??= MediaQuery.sizeOf(context).height;
    // width ??= MediaQuery.sizeOf(context).height;
      
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        ClipRect(
          child: OverflowBox(
            maxWidth: width * 7 / 8,
            minWidth: width * 6 / 8,
            child: Image(
              fit: BoxFit.cover,
              image: AssetImage(
                item.itemImageUrls.first,
              ), // TODO: make the actual defaultImageUrl
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '\$${item.itemListingPrice}',
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(color: Colors.red),
              ),
              Text(
                'Category: ${item.itemCategory}',
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(color: Colors.red),
              ),
              Text(
                item.itemDescription ?? '',
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(color: Colors.red),
              ),
              const SizedBox(height: 10),
              Text(
                'Listed: ${item.itemListingDate.toString()}',
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.red),
              ),
            ],
          ),
        ),
      ],
    );
  }
}