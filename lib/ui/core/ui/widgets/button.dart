import 'package:flutter/material.dart';

class Button {
  @override
  Widget build(BuildContext context, String buttonText) {
    return MaterialButton(
      child: Text(buttonText),
      onPressed: () => {AlertDialog(content: Text('Button Pressed!!'),)},
    );
  }
}

