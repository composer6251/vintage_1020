

// import 'dart:convert';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:http/http.dart' as http;
// import 'package:vintage_1020/extensions/http_extension.dart';

// @riverpod
// Future<String> getRequest(Ref ref, String domain, String path) async {
//   final client = await ref.getClient();
//   // Ensure the client is closed when the ref is disposed
//   ref.onDispose(client.close);

//   final response = await http.get(
//     Uri.https(domain, path),
//   );
//   final json = jsonDecode(response.body);
//   return json['activity']! as String;
// }

