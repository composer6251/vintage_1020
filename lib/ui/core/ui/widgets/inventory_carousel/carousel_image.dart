

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
   
   return  SizedBox(
    height: height / .5,
    width: width / .5,
    child: Image.file(File(url)));
  }
}