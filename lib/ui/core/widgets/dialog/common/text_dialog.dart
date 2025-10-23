import 'package:flutter/material.dart';

class TextDialog extends StatefulWidget {
  const TextDialog({super.key, required this.textController});

  final TextEditingController textController;

  @override
  State<TextDialog> createState() => _TextDialogState();
}

class _TextDialogState extends State<TextDialog> {
  @override
  void dispose() {
    widget.textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Create a booth'),
        TextField(controller: widget.textController),
        IconButton(
          icon: const Icon(Icons.check),
          style: ButtonStyle(
            elevation: WidgetStatePropertyAll<double>(8.0),
            backgroundColor: WidgetStatePropertyAll<Color>(Colors.green),
          ),
          onPressed: Navigator.of(context).pop,
        ),
      ],
    );
  }
}
