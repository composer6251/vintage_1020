

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

@riverpod
Future<String> getRequest(Ref ref, String domain, String path) async {
  final response = await http.get(
    Uri.https(domain, path),
  );
  final json = jsonDecode(response.body);
  return json['activity']! as String;
}

