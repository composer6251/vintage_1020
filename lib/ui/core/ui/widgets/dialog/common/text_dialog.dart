


    import 'package:flutter/material.dart';

void showTextDialog(String title, String message, BuildContext context) {
      showAdaptiveDialog(
        context: context,
        builder: (_) => Column(children: [
          Text('Create a booth'),
          TextField(onChanged: ,),
          IconButton(onPressed: onPressed, icon: icon)
        ],)

        ),
      );
    }
// import 'package:flutter/material.dart';

// class TextDialog extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() => _TextDialogState();






// }

// class _TextDialogState extends State<TextDialog> {


//   @override
//   Widget build(BuildContext context) {
    
//     return showAdaptiveDialog(context: context, builder: builder)
//   }


  
}