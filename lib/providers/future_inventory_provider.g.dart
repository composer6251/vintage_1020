// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'future_inventory_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(FutureInventoryProvider)
const futureInventoryProviderProvider = FutureInventoryProviderProvider._();

final class FutureInventoryProviderProvider
    extends
        $AsyncNotifierProvider<
          FutureInventoryProvider,
          List<FutureInventoryProvider>
        > {
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
}

String _$futureInventoryProviderHash() =>
    r'8c9824fdf977ad493a61772eadbd46c0242959f4';

abstract class _$FutureInventoryProvider
    extends $AsyncNotifier<List<FutureInventoryProvider>> {
  FutureOr<List<FutureInventoryProvider>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<FutureInventoryProvider>>,
              List<FutureInventoryProvider>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<FutureInventoryProvider>>,
                List<FutureInventoryProvider>
              >,
              AsyncValue<List<FutureInventoryProvider>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
