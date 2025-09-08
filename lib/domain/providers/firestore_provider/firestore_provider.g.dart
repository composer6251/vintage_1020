// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(FirestoreProvider)
const firestoreProviderProvider = FirestoreProviderProvider._();

final class FirestoreProviderProvider
    extends $NotifierProvider<FirestoreProvider, List<InventoryItem>> {
  const FirestoreProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firestoreProviderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firestoreProviderHash();

  @$internal
  @override
  FirestoreProvider create() => FirestoreProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<InventoryItem> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<InventoryItem>>(value),
    );
  }
}

String _$firestoreProviderHash() => r'8bee3e11cbd63dbe2b648e0a38721a44b28e9531';

abstract class _$FirestoreProvider extends $Notifier<List<InventoryItem>> {
  List<InventoryItem> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<InventoryItem>, List<InventoryItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<InventoryItem>, List<InventoryItem>>,
              List<InventoryItem>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
