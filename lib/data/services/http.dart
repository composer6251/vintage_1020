

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

@riverpod
Future<String> boredSuggestion(Ref ref) async {
  final response = await http.get(
    Uri.https('boredapi.com', '/api/activity'),
  );
  final json = jsonDecode(response.body);
  return json['activity']! as String;
}