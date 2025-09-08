// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'async_inventory_notifier_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(AsyncInventoryNotifierProvider)
const asyncInventoryNotifierProviderProvider =
    AsyncInventoryNotifierProviderProvider._();

final class AsyncInventoryNotifierProviderProvider
    extends
        $AsyncNotifierProvider<
          AsyncInventoryNotifierProvider,
          List<InventoryItem>
        > {
  const AsyncInventoryNotifierProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'asyncInventoryNotifierProviderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$asyncInventoryNotifierProviderHash();

  @$internal
  @override
  AsyncInventoryNotifierProvider create() => AsyncInventoryNotifierProvider();
}

String _$asyncInventoryNotifierProviderHash() =>
    r'f3999dbbc9b223ca3242e8e3fd0f1a14d6af11ec';

abstract class _$AsyncInventoryNotifierProvider
    extends $AsyncNotifier<List<InventoryItem>> {
  FutureOr<List<InventoryItem>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<InventoryItem>>, List<InventoryItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<InventoryItem>>, List<InventoryItem>>,
              AsyncValue<List<InventoryItem>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
