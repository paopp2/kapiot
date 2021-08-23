// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'kapiot_location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

KapiotLocation _$KapiotLocationFromJson(Map<String, dynamic> json) {
  return _KapiotLocation.fromJson(json);
}

/// @nodoc
class _$KapiotLocationTearOff {
  const _$KapiotLocationTearOff();

  _KapiotLocation call(
      {required double lat, required double lng, String? address}) {
    return _KapiotLocation(
      lat: lat,
      lng: lng,
      address: address,
    );
  }

  KapiotLocation fromJson(Map<String, Object> json) {
    return KapiotLocation.fromJson(json);
  }
}

/// @nodoc
const $KapiotLocation = _$KapiotLocationTearOff();

/// @nodoc
mixin _$KapiotLocation {
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KapiotLocationCopyWith<KapiotLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KapiotLocationCopyWith<$Res> {
  factory $KapiotLocationCopyWith(
          KapiotLocation value, $Res Function(KapiotLocation) then) =
      _$KapiotLocationCopyWithImpl<$Res>;
  $Res call({double lat, double lng, String? address});
}

/// @nodoc
class _$KapiotLocationCopyWithImpl<$Res>
    implements $KapiotLocationCopyWith<$Res> {
  _$KapiotLocationCopyWithImpl(this._value, this._then);

  final KapiotLocation _value;
  // ignore: unused_field
  final $Res Function(KapiotLocation) _then;

  @override
  $Res call({
    Object? lat = freezed,
    Object? lng = freezed,
    Object? address = freezed,
  }) {
    return _then(_value.copyWith(
      lat: lat == freezed
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: lng == freezed
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$KapiotLocationCopyWith<$Res>
    implements $KapiotLocationCopyWith<$Res> {
  factory _$KapiotLocationCopyWith(
          _KapiotLocation value, $Res Function(_KapiotLocation) then) =
      __$KapiotLocationCopyWithImpl<$Res>;
  @override
  $Res call({double lat, double lng, String? address});
}

/// @nodoc
class __$KapiotLocationCopyWithImpl<$Res>
    extends _$KapiotLocationCopyWithImpl<$Res>
    implements _$KapiotLocationCopyWith<$Res> {
  __$KapiotLocationCopyWithImpl(
      _KapiotLocation _value, $Res Function(_KapiotLocation) _then)
      : super(_value, (v) => _then(v as _KapiotLocation));

  @override
  _KapiotLocation get _value => super._value as _KapiotLocation;

  @override
  $Res call({
    Object? lat = freezed,
    Object? lng = freezed,
    Object? address = freezed,
  }) {
    return _then(_KapiotLocation(
      lat: lat == freezed
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: lng == freezed
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_KapiotLocation
    with DiagnosticableTreeMixin
    implements _KapiotLocation {
  const _$_KapiotLocation({required this.lat, required this.lng, this.address});

  factory _$_KapiotLocation.fromJson(Map<String, dynamic> json) =>
      _$$_KapiotLocationFromJson(json);

  @override
  final double lat;
  @override
  final double lng;
  @override
  final String? address;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'KapiotLocation(lat: $lat, lng: $lng, address: $address)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'KapiotLocation'))
      ..add(DiagnosticsProperty('lat', lat))
      ..add(DiagnosticsProperty('lng', lng))
      ..add(DiagnosticsProperty('address', address));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _KapiotLocation &&
            (identical(other.lat, lat) ||
                const DeepCollectionEquality().equals(other.lat, lat)) &&
            (identical(other.lng, lng) ||
                const DeepCollectionEquality().equals(other.lng, lng)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(other.address, address)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(lat) ^
      const DeepCollectionEquality().hash(lng) ^
      const DeepCollectionEquality().hash(address);

  @JsonKey(ignore: true)
  @override
  _$KapiotLocationCopyWith<_KapiotLocation> get copyWith =>
      __$KapiotLocationCopyWithImpl<_KapiotLocation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_KapiotLocationToJson(this);
  }
}

abstract class _KapiotLocation implements KapiotLocation {
  const factory _KapiotLocation(
      {required double lat,
      required double lng,
      String? address}) = _$_KapiotLocation;

  factory _KapiotLocation.fromJson(Map<String, dynamic> json) =
      _$_KapiotLocation.fromJson;

  @override
  double get lat => throw _privateConstructorUsedError;
  @override
  double get lng => throw _privateConstructorUsedError;
  @override
  String? get address => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$KapiotLocationCopyWith<_KapiotLocation> get copyWith =>
      throw _privateConstructorUsedError;
}
