// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(hasSeenOnBoardingScreen)
const hasSeenOnBoardingScreenProvider = HasSeenOnBoardingScreenProvider._();

final class HasSeenOnBoardingScreenProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  const HasSeenOnBoardingScreenProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hasSeenOnBoardingScreenProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hasSeenOnBoardingScreenHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return hasSeenOnBoardingScreen(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$hasSeenOnBoardingScreenHash() =>
    r'3097ce6a40cb295c79eb153e3a09d0d98c88bde3';
