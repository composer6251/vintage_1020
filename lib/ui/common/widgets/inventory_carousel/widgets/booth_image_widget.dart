import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/ui/image_widget_util/image_widget_util.dart';

class BoothImageWidget extends ConsumerWidget {
  const BoothImageWidget({
    super.key,
    required this.url
  });

  final String url;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
   final height = MediaQuery.sizeOf(context).height;
   return  SizedBox(
    height: height,
    child: ImageWidgetUtil.getItemImage(url),
   );
  }
}