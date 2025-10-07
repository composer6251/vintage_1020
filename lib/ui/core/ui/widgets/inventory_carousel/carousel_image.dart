

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
   
   return  SizedBox(
    child: Image.file(
      fit: BoxFit.fill,
      File(url)));
  }
}