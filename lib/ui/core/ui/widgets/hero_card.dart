import 'package:flutter/material.dart';
import 'package:vintage_1020/domain/models/model/inventory_item/inventory_item.dart';

class HeroLayoutCard extends StatelessWidget {
  const HeroLayoutCard({super.key, required this.image});

  final InventoryItem image;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
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
                image.itemImageUrls.first,
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
                '\$${image.itemListingPrice}',
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(color: Colors.red),
              ),
              Text(
                'Category: ${image.itemCategory}',
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(color: Colors.red),
              ),
              Text(
                image.itemDescription ?? '',
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(color: Colors.red),
              ),
              const SizedBox(height: 10),
              Text(
                'Listed: ${image.itemListingDate.toString()}',
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