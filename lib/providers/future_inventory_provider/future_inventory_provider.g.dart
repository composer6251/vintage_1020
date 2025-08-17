// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'future_inventory_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(FutureInventoryProvider)
const futureInventoryProviderProvider = FutureInventoryProviderProvider._();

final class FutureInventoryProviderProvider
    extends $NotifierProvider<FutureInventoryProvider, void> {
  const FutureInventoryProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'futureInventoryProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$futureInventoryProviderHash();

  @$internal
  @override
  FutureInventoryProvider create() => FutureInventoryProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$futureInventoryProviderHash() =>
    r'd048def88eb396e1c9af65ec08ce16b97f350d49';

abstract class _$FutureInventoryProvider extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
