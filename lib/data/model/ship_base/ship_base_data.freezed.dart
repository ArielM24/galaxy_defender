// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ship_base_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShipBaseData {


/// Create a copy of ShipBaseData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShipBaseDataCopyWith<ShipBaseData> get copyWith => _$ShipBaseDataCopyWithImpl<ShipBaseData>(this as ShipBaseData, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ShipBaseData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShipBaseData&&(identical(other.maxLife, _this.maxLife) || other.maxLife == _this.maxLife)&&(identical(other.currentLife, _this.currentLife) || other.currentLife == _this.currentLife)&&(identical(other.type, _this.type) || other.type == _this.type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ShipBaseData;
  return Object.hash(runtimeType,_this.maxLife,_this.currentLife,_this.type);
}

@override
String toString() {
  final _this = this as ShipBaseData;
  return 'ShipBaseData(maxLife: ${_this.maxLife}, currentLife: ${_this.currentLife}, type: ${_this.type})';
}


}

/// @nodoc
abstract mixin class $ShipBaseDataCopyWith<$Res>  {
  factory $ShipBaseDataCopyWith(ShipBaseData value, $Res Function(ShipBaseData) _then) = _$ShipBaseDataCopyWithImpl;
@useResult
$Res call({
 double maxLife, double currentLife, ShipType type
});




}
/// @nodoc
class _$ShipBaseDataCopyWithImpl<$Res>
    implements $ShipBaseDataCopyWith<$Res> {
  _$ShipBaseDataCopyWithImpl(this._self, this._then);

  final ShipBaseData _self;
  final $Res Function(ShipBaseData) _then;

/// Create a copy of ShipBaseData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxLife = null,Object? currentLife = null,Object? type = null,}) {
  return _then(ShipBaseData(
maxLife: null == maxLife ? _self.maxLife : maxLife // ignore: cast_nullable_to_non_nullable
as double,currentLife: null == currentLife ? _self.currentLife : currentLife // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ShipType,
  ));
}

}


/// Adds pattern-matching-related methods to [ShipBaseData].
extension ShipBaseDataPatterns on ShipBaseData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
