import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// PROVIDER FOR THE SCAFFOLD MESSENGER STATE KEY

// HOLDS THE GLOBAL SCAFFOLD MESSENGER KEY PASSED TO THE [MaterialApp]
final scaffoldMessengerKeyPod = Provider((ref) {
  return GlobalKey<ScaffoldMessengerState>();
});

// RETURNS THE SCAFFOLD MESSENGER ASSOCIATED WITH THE [scaffoldMessengerKeyPod]
final scaffoldMessengerPod = Provider((ref) {
  return ref.watch(scaffoldMessengerKeyPod).currentState!;
});
