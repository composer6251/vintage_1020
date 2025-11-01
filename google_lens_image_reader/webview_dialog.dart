// import 'package:flutter/material.dart';

// class WebviewDialog extends StatelessWidget {
  
  
//   @override
//   Future<dynamic> build(BuildContext context) {
//     return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('${httpRequest.host}: ${httpRequest.realm ?? '-'}'),
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 TextField(
//                   decoration: const InputDecoration(labelText: 'Username'),
//                   autofocus: true,
//                   controller: usernameTextController,
//                 ),
//                 TextField(
//                   decoration: const InputDecoration(labelText: 'Password'),
//                   controller: passwordTextController,
//                 ),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             // Explicitly cancel the request on iOS as the OS does not emit new
//             // requests when a previous request is pending.
//             TextButton(
//               onPressed: () {
//                 httpRequest.onCancel();
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 httpRequest.onProceed(
//                   WebViewCredential(
//                     user: usernameTextController.text,
//                     password: passwordTextController.text,
//                   ),
//                 );
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Authenticate'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
