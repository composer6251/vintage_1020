import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vintage_1020/data/providers/my_booth_provider/my_booth_notifier.dart';
import 'package:vintage_1020/domain/my_booth/my_booth.dart';
import 'package:vintage_1020/ui/core/ui/util/image_util.dart';

class CreateBoothWidget extends ConsumerStatefulWidget{
  @override
  ConsumerState<CreateBoothWidget> createState() => _CreateBoothWidgetState();
}

class _CreateBoothWidgetState extends ConsumerState<CreateBoothWidget> {

  String? stateBoothName;
  List<XFile> boothImagesTemp = [];

  @override
  Widget build(BuildContext context) {

    void saveBooth() async {

      List<File> savedFiles = await saveXFileListAndReturnSavedFiles(boothImagesTemp);
      List<String> savedFilesPaths = getPathsForSavedFiles(savedFiles);
      
      MyBooth.initial(stateBoothName, savedFilesPaths);

      ref.read(myBoothProvider.notifier).insertInitalUserBooth();
    }

    void addBooth() {
      saveBooth();

      Navigator.of(context).pop();
    }

    void takePhotoAndSetState() async {

      XFile? boothPic = await takeCameraPhoto();

      if(boothPic == null) return;

      setState(() {
        boothImagesTemp.add(boothPic);
      });
    }

    return Dialog(
      child: Container(
        decoration: BoxDecoration(border: BoxBorder.all(color: Colors.black, width: 4), borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
          height: MediaQuery.heightOf(context) / 1.85,
          width: MediaQuery.widthOf(context) / 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Text(style: TextStyle(fontSize: 20, fontFamily: 'Helvetica', fontWeight: FontWeight.bold), 
                  'You can create a booth name here, and also take pictures of it which will(should) appear after saving your new booth!!!'),
                  ),
                TextFormField(
                  onChanged: (value) => setState(() {
                    stateBoothName = value;
                  }),
                  decoration: const InputDecoration(
                    labelText: 'Booth Name',
                    floatingLabelAlignment: FloatingLabelAlignment.center
                  ),
                  keyboardType: TextInputType.text,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.photo_camera),
                      tooltip: 'Take Photo',
                      style: ButtonStyle(
                        elevation: WidgetStatePropertyAll<double>(8.0),
                        backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
                      ),
                      onPressed: ()  {
                        takePhotoAndSetState();
                      }
                    ),
                    IconButton(
                      icon: const Icon(Icons.check),
                      style: ButtonStyle(
                        elevation: WidgetStatePropertyAll<double>(8.0),
                        backgroundColor: WidgetStatePropertyAll<Color>(Colors.green),
                      ),
                      onPressed: addBooth,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}