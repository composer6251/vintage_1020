import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vintage_1020/data/model/inventory_item.dart';

class InventoryCarousel extends StatefulWidget {
  const InventoryCarousel({
    super.key,
    required this.models,
    required this.width,
    required this.height,
    required this.flexWeights,
  });

  final List<InventoryItem> models;
  final double width;
  final double height;
  final List<int> flexWeights;

  @override
  State<InventoryCarousel> createState() => _InventoryCarouselState();
}

class _InventoryCarouselState extends State<InventoryCarousel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          ],
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: widget.height),
          child: CarouselView.weighted(
            // controller: controller,
            itemSnapping: true,
            flexWeights: widget.flexWeights,
            children: widget.models.map((model) {
              return HeroLayoutCard(model: model, height: widget.height, width: widget.width,);
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class HeroLayoutCard extends StatefulWidget {
  const HeroLayoutCard({super.key, required this.model, required this.height, required this.width});

  final InventoryItem model;
  final double height;
  final double width;

  @override
  State<HeroLayoutCard> createState() => _HeroLayoutCardState();
}

class _HeroLayoutCardState extends State<HeroLayoutCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        ClipRect(
          child: OverflowBox(
            maxHeight: widget.height,
            maxWidth: widget.width * 7 / 8,
            minWidth: widget.width * 7 / 8,
            child: Image(
              fit: BoxFit.cover,
              image: AssetImage(widget.model.itemImageUrls.isNotEmpty
                  ? widget.model.itemImageUrls.first
                  : 'resources/images-booth/booth-1.jpeg'),
              // image: FileImage('/private/var/mobile/Containers/Data/Application/45975B21-94B0-487A-BE26-E6D66B76111E/tmp/image_picker_E4D233DB-43C2-48BE-B1DF-2709A22E2E6D-71685-00001D8C32BE1DB7.jpg' as File),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
            if (widget.model.itemSoldPrice != null) 
              Text(
                widget.model.itemListingPrice != null
                    ? 'Sold: ${NumberFormat.currency(symbol: '\$').format(widget.model.itemSoldPrice)}'
                    : 'Not Sold',
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(color: Colors.black),
              ),
              Text(
                'Category: ${widget.model.itemCategory}',
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.black),
              ),
              Text(
                widget.model.itemDescription ?? 'No Description',
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(color: Colors.black),
              ),
              Flexible(
                  fit: FlexFit.loose,
                  child: Banner(
                    location: BannerLocation.topStart,
                    color: const Color.fromARGB(255, 13, 94, 16),
                    message: 'SOLD',
                  ),
                ),
              const SizedBox(height: 10),
              // Text(
              //   widget.model.itemSoldPrice != null
              //       ? 'Sold: ${NumberFormat.currency(symbol: '\$').format(widget.model.itemSoldPrice)}'
              //       : 'Not Sold',
              //   overflow: TextOverflow.clip,
              //   softWrap: false,
              //   style: Theme.of(
              //     context,
              //   ).textTheme.bodyMedium?.copyWith(color: Colors.black),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
