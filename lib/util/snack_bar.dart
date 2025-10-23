

  import 'package:flutter/material.dart';


void showSnackBar(String message, BuildContext context) {
    var sb = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(sb);
  }