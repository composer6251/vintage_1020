// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(UserNotifier)
const userNotifierProvider = UserNotifierProvider._();

final class UserNotifierProvider extends $NotifierProvider<UserNotifier, User> {
  const UserNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userNotifierProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userNotifierHash();

  @$internal
  @override
  UserNotifier create() => UserNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(User value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<User>(value),
    );
  }
}

String _$userNotifierHash() => r'd2cc8e532a2710263b1054e9d4f7ca1c8280ea97';

abstract class _$UserNotifier extends $Notifier<User> {
  User build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<User, User>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<User, User>,
              User,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
