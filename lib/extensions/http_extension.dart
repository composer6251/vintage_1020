import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

extension DebounceAndCancelExtension on Ref {
  Future<http.Client> getClient() async {
    final client = http.Client();
    var disposed = false;

    onDispose(() {
      if (!disposed) {
        disposed = true;
        client.close();
      }
    });
    if (disposed) {
      throw Exception('Client has already been disposed');
    }
    await Future.delayed(const Duration(seconds: 1));

    // Ensure the client is ready
    return client;
  }
}
