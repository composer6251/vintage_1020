import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_provider.g.dart';

@riverpod
bool hasSeenOnBoardingScreen(Ref _) {
  return false;
}