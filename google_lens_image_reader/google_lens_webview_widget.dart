// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';

// class GoogleLensWebViewWidget extends HookConsumerWidget {
//   final String url;

//   const GoogleLensWebViewWidget({
//     required super.key,
//     required this.url,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // simple local state to show a loading indicator while initialization happens
//     final isLoading = useState<bool>(true);

//     useEffect(() {
//       // perform any initial side-effects here (e.g., prepare controller)
//       // this is just a placeholder to simulate async init
//       final future = Future.delayed(const Duration(milliseconds: 200), () {
//         isLoading.value = false;
//       });

//       return () {
//         // cleanup if needed
//       };
//     }, [url]);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Google Lens WebView'),
//       ),
//       body: Stack(
//         children: [
//           // Replace this placeholder with your preferred WebView implementation,
//           // for example using webview_flutter:
          
//           WebView(
//             initialUrl: url,
//             javascriptMode: JavascriptMode.unrestricted,
//             onPageFinished: (_) => isLoading.value = false,
//           )
//           Center(
//             child: Text(
//               'WebView placeholder\n$url',
//               textAlign: TextAlign.center,
//             ),
//           ),
//           if (isLoading.value)
//             const Center(child: CircularProgressIndicator()),
//         ],
//       ),
    
//     );
//   }
// }