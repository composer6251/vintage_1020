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
              image: AssetImage(widget.model.itemImageUrls.first),
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(16.0),
          // child: Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisSize: MainAxisSize.min,
          //   children: <Widget>[
          //     Text(
          //       widget.model.itemListingPrice.toString(),
          //       overflow: TextOverflow.clip,
          //       softWrap: false,
          //       style: Theme.of(
          //         context,
          //       ).textTheme.headlineLarge?.copyWith(color: Colors.black),
          //     ),
          //     Text(
          //       'Category: ${widget.model.itemCategory}',
          //       overflow: TextOverflow.clip,
          //       softWrap: false,
          //       style: Theme.of(
          //         context,
          //       ).textTheme.bodyMedium?.copyWith(color: Colors.black),
          //     ),
          //     Text(
          //       widget.model.itemDescription,
          //       overflow: TextOverflow.clip,
          //       softWrap: false,
          //       style: Theme.of(
          //         context,
          //       ).textTheme.headlineLarge?.copyWith(color: Colors.black),
          //     ),
          //     Text(
          //       widget.model.itemCategory ?? 'No Category',
          //       overflow: TextOverflow.clip,
          //       softWrap: false,
          //       style: Theme.of(
          //         context,
          //       ).textTheme.headlineLarge?.copyWith(color: Colors.black),
          //     ),
          //     const SizedBox(height: 10),
          //     Text(
          //       'Listed: ${DateFormat.yMEd().add_jms().format(widget.model.itemListingDate)}',
          //       overflow: TextOverflow.clip,
          //       softWrap: false,
          //       style: Theme.of(
          //         context,
          //       ).textTheme.bodyMedium?.copyWith(color: Colors.black),
          //     ),
          //   ],
          // ),
        // ),
      ],
    );
  }
}
