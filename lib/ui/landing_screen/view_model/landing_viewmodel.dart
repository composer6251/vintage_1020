import 'package:flutter/material.dart';
import 'package:namer_app/data/repositories/user_repository.dart';
import '../../../utils/command.dart';

class LandingViewmodel extends ChangeNotifier {
  LandingViewmodel({
    required UserRepository userRepository,
  }) : _userRepository = userRepository {
    
    // Load required data when this screen is built.
    // load = Command0(_load)..execute();
  }

  final UserRepository _userRepository;

  late Command load;

  // User? _user;
  // User? get user => _user;

  // List<BookingSummary> _bookings = [];
  // List<BookingSummary> get bookings => _bookings;

  // TODO ADD TYPE FOR RESULT
  // Future<Result> _load() async {
  //   // ...
  // }
}
