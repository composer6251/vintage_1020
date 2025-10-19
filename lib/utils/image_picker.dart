import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelector extends StatefulWidget {
  const ImageSelector({super.key});

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  // Variable to hold the list of selected image files
  List<XFile> _selectedImages = [];
  List<XFile> _photo = [];

  // Function to pick multiple images from the gallery
  Future<void> _pickMultipleImagesFromGallery() async {
    print('Picking multiple images from gallery...');
    final picker = ImagePicker();
    final List<XFile> pickedFiles = await picker.pickMultiImage();

    if (pickedFiles.isNotEmpty) {
      setState(() {
        _selectedImages = pickedFiles;
        print('${pickedFiles.length} images picked.');
      });
    } else {
      print('No images selected.');
    }
  }

  Future<void> takePhoto() async {
    // Obtain a list of the available cameras on the device.
    final picker = ImagePicker();
    XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 90,
    );
    if (image != null) {
       _photo = [image];
        print('Image taken');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _pickMultipleImagesFromGallery,
                    child: const Text('From Photos'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: takePhoto,
                    child: const Text('Take Picture'),
                  ),
                ),
              ],
            ),
            // Display the selected images (e.g., in a GridView or ListView)
            Expanded(
              // Use Expanded if placing within a Column
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Adjust as needed
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: _selectedImages.length,
                itemBuilder: (BuildContext context, int index) {
                  // For web, XFile.path is a blob URL usable by Image.network
                  // For mobile, XFile.path is a file path, Image.file is better
                  // For simplicity here, using Image.network which often works with XFile paths cross-platform
                  return Image.network(
                    _selectedImages[index].path,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Container(child: _photo.isEmpty ? Text('No Photo Taken') : Image.network(_photo[0].path))
          ],
        ),
      ),
    );
  }
}
