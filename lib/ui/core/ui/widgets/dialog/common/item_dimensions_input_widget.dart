import 'package:flutter/material.dart';

class ItemDimensionsInputWidget extends StatefulWidget {
  const ItemDimensionsInputWidget({super.key, this.heightController, this.widthController, this.depthController});

  final TextEditingController? heightController;
  final TextEditingController? widthController;
  final TextEditingController? depthController;
  @override
  State<ItemDimensionsInputWidget> createState() =>
      _ItemDimensionsInputWidgetState();
}

class _ItemDimensionsInputWidgetState extends State<ItemDimensionsInputWidget> {

  TextEditingController? hController;
  TextEditingController? wController;
  TextEditingController? dController;

  @override 
  void initState() {
    super.initState();
    hController = widget.heightController;
    wController = widget.widthController;
    dController = widget.depthController;
  }

  @override  
  void dispose() {
    hController?.dispose();
    wController?.dispose();
    dController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Flex(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      direction: Axis.horizontal,
      children: [
        SizedBox(
          width: 80,
          child: TextFormField(
            controller: widget.heightController,
            decoration: const InputDecoration(
              fillColor: Colors.blue,
              floatingLabelAlignment: FloatingLabelAlignment.start,
              labelText: 'Height',
              labelStyle: TextStyle(fontSize: 12)
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
        ),
        SizedBox(
          width: 80,
          child: TextFormField(
            controller: widget.widthController,
            decoration: const InputDecoration(
              fillColor: Colors.blue,
              labelText: 'Width',
              floatingLabelAlignment: FloatingLabelAlignment.start,
              labelStyle: TextStyle(fontSize: 12)
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
        ),
        SizedBox(
          width: 80,
          child: TextFormField(
            controller: widget.depthController,
            decoration: const InputDecoration(
              fillColor: Colors.blue,
              labelText: 'Depth',
              floatingLabelAlignment: FloatingLabelAlignment.start,
              labelStyle: TextStyle(fontSize: 12)
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
        ),
      ],
    );
  }
}
