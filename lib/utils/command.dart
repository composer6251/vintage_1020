import 'package:flutter/material.dart';

abstract class Command<T> extends ChangeNotifier {
  Command();
  bool running = false;
  // Result<T>? _result;

  /// true if action completed with error
  // bool get error => _result is Error;

  /// true if action completed successfully
  // bool get completed => _result is Ok;

  /// Internal execute implementation
  Future<void> _execute(action) async {
    // if (_running) return;

    // // Emit running state - e.g. button shows loading state
    // _running = true;
    // _result = null;
    // notifyListeners();

    // try {
    //   _result = await action();
    // } finally {
    //   _running = false;
    //   notifyListeners();
    // }
  }
}