

import 'dart:io';

import 'package:flutter/material.dart';

class ImageWidgetUtil {


  static Widget getItemImage(String? imageUrl) {

      String errorText = '';

      if(imageUrl == null) {
        return Text(
        style: TextStyle(fontSize: 20),
        'No primary image for item');
      }

      File file = File(imageUrl);

      if(!file.existsSync()) {
        return Text(
        style: TextStyle(fontSize: 20),
        'No file found at primary image path');
      }

      if(errorText.isNotEmpty) return Text(errorText);

      return Image.file(file);
    }
}