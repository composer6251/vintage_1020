import 'package:flutter/material.dart';
import 'package:vintage_1020/ui/add_item_dialog/view_model/add_item_dialog_view_model';
import 'package:vintage_1020/utils/picture_util.dart' as photo_util;

class DialogCameraPickerButtonsWidget extends StatelessWidget {
  const DialogCameraPickerButtonsWidget({
    super.key,
    required this.cameraLabel,
    required this.photosLabel,
    required this.value,
    required this.onValueChanged,
  });

  final String cameraLabel;
  final String photosLabel;
  final List<String> value;
  final Function onValueChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.photo_camera),
          tooltip: ,
          style: ButtonStyle(
            elevation: WidgetStatePropertyAll<double>(8.0),
            backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
          ),
          onPressed: photo_util.takePhoto,
        ),
        IconButton(
          icon: const Icon(Icons.photo_library),
          tooltip: photosLabel,
          style: ButtonStyle(
            elevation: WidgetStatePropertyAll<double>(8.0),
            backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
          ),
          onPressed: selectImages,
        ),
      ],
    );
  }
}
