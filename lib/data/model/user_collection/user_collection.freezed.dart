// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_collection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserCollection {

// Optional ID for the item
 String get username; String get inventoryId; List<InventoryItem> get inventory;
/// Create a copy of UserCollection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCollectionCopyWith<UserCollection> get copyWith => _$UserCollectionCopyWithImpl<UserCollection>(this as UserCollection, _$identity);

  /// Serializes this UserCollection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserCollection&&(identical(other.username, username) || other.username == username)&&(identical(other.inventoryId, inventoryId) || other.inventoryId == inventoryId)&&const DeepCollectionEquality().equals(other.inventory, inventory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,inventoryId,const DeepCollectionEquality().hash(inventory));

@override
String toString() {
  return 'UserCollection(username: $username, inventoryId: $inventoryId, inventory: $inventory)';
}


}

/// @nodoc
abstract mixin class $UserCollectionCopyWith<$Res>  {
  factory $UserCollectionCopyWith(UserCollection value, $Res Function(UserCollection) _then) = _$UserCollectionCopyWithImpl;
@useResult
$Res call({
 String username, String inventoryId, List<InventoryItem> inventory
});




}
/// @nodoc
class _$UserCollectionCopyWithImpl<$Res>
    implements $UserCollectionCopyWith<$Res> {
  _$UserCollectionCopyWithImpl(this._self, this._then);

  final UserCollection _self;
  final $Res Function(UserCollection) _then;

/// Create a copy of UserCollection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = null,Object? inventoryId = null,Object? inventory = null,}) {
  return _then(_self.copyWith(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,inventoryId: null == inventoryId ? _self.inventoryId : inventoryId // ignore: cast_nullable_to_non_nullable
as String,inventory: null == inventory ? _self.inventory : inventory // ignore: cast_nullable_to_non_nullable
as List<InventoryItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserCollection].
extension UserCollectionPatterns on UserCollection {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserCollection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserCollection() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserCollection value)  $default,){
final _that = this;
switch (_that) {
case _UserCollection():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserCollection value)?  $default,){
final _that = this;
switch (_that) {
case _UserCollection() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String username,  String inventoryId,  List<InventoryItem> inventory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserCollection() when $default != null:
return $default(_that.username,_that.inventoryId,_that.inventory);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String username,  String inventoryId,  List<InventoryItem> inventory)  $default,) {final _that = this;
switch (_that) {
case _UserCollection():
return $default(_that.username,_that.inventoryId,_that.inventory);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String username,  String inventoryId,  List<InventoryItem> inventory)?  $default,) {final _that = this;
switch (_that) {
case _UserCollection() when $default != null:
return $default(_that.username,_that.inventoryId,_that.inventory);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserCollection implements UserCollection {
  const _UserCollection({required this.username, required this.inventoryId, required final  List<InventoryItem> inventory}): _inventory = inventory;
  factory _UserCollection.fromJson(Map<String, dynamic> json) => _$UserCollectionFromJson(json);

// Optional ID for the item
@override final  String username;
@override final  String inventoryId;
 final  List<InventoryItem> _inventory;
@override List<InventoryItem> get inventory {
  if (_inventory is EqualUnmodifiableListView) return _inventory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_inventory);
}


/// Create a copy of UserCollection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCollectionCopyWith<_UserCollection> get copyWith => __$UserCollectionCopyWithImpl<_UserCollection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserCollectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserCollection&&(identical(other.username, username) || other.username == username)&&(identical(other.inventoryId, inventoryId) || other.inventoryId == inventoryId)&&const DeepCollectionEquality().equals(other._inventory, _inventory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,inventoryId,const DeepCollectionEquality().hash(_inventory));

@override
String toString() {
  return 'UserCollection(username: $username, inventoryId: $inventoryId, inventory: $inventory)';
}


}

/// @nodoc
abstract mixin class _$UserCollectionCopyWith<$Res> implements $UserCollectionCopyWith<$Res> {
  factory _$UserCollectionCopyWith(_UserCollection value, $Res Function(_UserCollection) _then) = __$UserCollectionCopyWithImpl;
@override @useResult
$Res call({
 String username, String inventoryId, List<InventoryItem> inventory
});




}
/// @nodoc
class __$UserCollectionCopyWithImpl<$Res>
    implements _$UserCollectionCopyWith<$Res> {
  __$UserCollectionCopyWithImpl(this._self, this._then);

  final _UserCollection _self;
  final $Res Function(_UserCollection) _then;

/// Create a copy of UserCollection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = null,Object? inventoryId = null,Object? inventory = null,}) {
  return _then(_UserCollection(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,inventoryId: null == inventoryId ? _self.inventoryId : inventoryId // ignore: cast_nullable_to_non_nullable
as String,inventory: null == inventory ? _self._inventory : inventory // ignore: cast_nullable_to_non_nullable
as List<InventoryItem>,
  ));
}


}

// dart format on
