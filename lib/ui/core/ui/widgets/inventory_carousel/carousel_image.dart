

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarouselImage extends ConsumerWidget {
  const CarouselImage({
    super.key,
    required this.url
  });

  final String url;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
   
   return  OverflowBox(
                maxHeight: height,
                maxWidth: width * 7 / 8,
                minWidth: width * 7 / 8,
                // child: Image.memory(item.getPrimaryImage.readAsBytesSync()),
                // child: Image.file(item.getPrimaryImage)
                child: Image.file(File(url)),
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
          
              );
  }
}