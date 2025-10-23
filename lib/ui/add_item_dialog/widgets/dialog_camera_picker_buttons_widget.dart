import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vintage_1020/util/photo_util.dart';


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
          tooltip: cameraLabel,
          style: ButtonStyle(
            elevation: WidgetStatePropertyAll<double>(8.0),
            backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
          ),
          onPressed: () async { await PhotoUtil.takeCameraPhoto();},
        ),
        IconButton(
          icon: const Icon(Icons.photo_library),
          tooltip: photosLabel,
          style: ButtonStyle(
            elevation: WidgetStatePropertyAll<double>(8.0),
            backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
          ),
          onPressed: () async { 
            await PhotoUtil.pickMultipleImagesFromGallery();
          },
        ),
      ],
    );
  }
}
