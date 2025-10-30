import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vintage_1020/data/providers/my_booth_filter/current_booth_provider.dart';
import 'package:vintage_1020/ui/image_widget_util/image_widget_util.dart';

class BoothImageWidget extends ConsumerWidget {
  const BoothImageWidget({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Stack(
      children: [
        SizedBox(
          height: height,
          width: width,
          child: ImageWidgetUtil.getItemImage(url),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontStyle: FontStyle.italic,
              ),
              'Text',
            ),
          ),
        ),
      ],
    );
  }
}
