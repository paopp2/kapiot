// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'stop_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$StopPointTearOff {
  const _$StopPointTearOff();

  _StopPoint call(
      {required RouteConfig riderConfig,
      required KapiotLocation stopLocation,
      required bool isPickUp}) {
    return _StopPoint(
      riderConfig: riderConfig,
      stopLocation: stopLocation,
      isPickUp: isPickUp,
    );
  }
}

/// @nodoc
const $StopPoint = _$StopPointTearOff();

/// @nodoc
mixin _$StopPoint {
  RouteConfig get riderConfig => throw _privateConstructorUsedError;
  KapiotLocation get stopLocation => throw _privateConstructorUsedError;
  bool get isPickUp => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StopPointCopyWith<StopPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StopPointCopyWith<$Res> {
  factory $StopPointCopyWith(StopPoint value, $Res Function(StopPoint) then) =
      _$StopPointCopyWithImpl<$Res>;
  $Res call(
      {RouteConfig riderConfig, KapiotLocation stopLocation, bool isPickUp});

  $RouteConfigCopyWith<$Res> get riderConfig;
  $KapiotLocationCopyWith<$Res> get stopLocation;
}

/// @nodoc
class _$StopPointCopyWithImpl<$Res> implements $StopPointCopyWith<$Res> {
  _$StopPointCopyWithImpl(this._value, this._then);

  final StopPoint _value;
  // ignore: unused_field
  final $Res Function(StopPoint) _then;

  @override
  $Res call({
    Object? riderConfig = freezed,
    Object? stopLocation = freezed,
    Object? isPickUp = freezed,
  }) {
    return _then(_value.copyWith(
      riderConfig: riderConfig == freezed
          ? _value.riderConfig
          : riderConfig // ignore: cast_nullable_to_non_nullable
              as RouteConfig,
      stopLocation: stopLocation == freezed
          ? _value.stopLocation
          : stopLocation // ignore: cast_nullable_to_non_nullable
              as KapiotLocation,
      isPickUp: isPickUp == freezed
          ? _value.isPickUp
          : isPickUp // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $RouteConfigCopyWith<$Res> get riderConfig {
    return $RouteConfigCopyWith<$Res>(_value.riderConfig, (value) {
      return _then(_value.copyWith(riderConfig: value));
    });
  }

  @override
  $KapiotLocationCopyWith<$Res> get stopLocation {
    return $KapiotLocationCopyWith<$Res>(_value.stopLocation, (value) {
      return _then(_value.copyWith(stopLocation: value));
    });
  }
}

/// @nodoc
abstract class _$StopPointCopyWith<$Res> implements $StopPointCopyWith<$Res> {
  factory _$StopPointCopyWith(
          _StopPoint value, $Res Function(_StopPoint) then) =
      __$StopPointCopyWithImpl<$Res>;
  @override
  $Res call(
      {RouteConfig riderConfig, KapiotLocation stopLocation, bool isPickUp});

  @override
  $RouteConfigCopyWith<$Res> get riderConfig;
  @override
  $KapiotLocationCopyWith<$Res> get stopLocation;
}

/// @nodoc
class __$StopPointCopyWithImpl<$Res> extends _$StopPointCopyWithImpl<$Res>
    implements _$StopPointCopyWith<$Res> {
  __$StopPointCopyWithImpl(_StopPoint _value, $Res Function(_StopPoint) _then)
      : super(_value, (v) => _then(v as _StopPoint));

  @override
  _StopPoint get _value => super._value as _StopPoint;

  @override
  $Res call({
    Object? riderConfig = freezed,
    Object? stopLocation = freezed,
    Object? isPickUp = freezed,
  }) {
    return _then(_StopPoint(
      riderConfig: riderConfig == freezed
          ? _value.riderConfig
          : riderConfig // ignore: cast_nullable_to_non_nullable
              as RouteConfig,
      stopLocation: stopLocation == freezed
          ? _value.stopLocation
          : stopLocation // ignore: cast_nullable_to_non_nullable
              as KapiotLocation,
      isPickUp: isPickUp == freezed
          ? _value.isPickUp
          : isPickUp // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_StopPoint with DiagnosticableTreeMixin implements _StopPoint {
  const _$_StopPoint(
      {required this.riderConfig,
      required this.stopLocation,
      required this.isPickUp});

  @override
  final RouteConfig riderConfig;
  @override
  final KapiotLocation stopLocation;
  @override
  final bool isPickUp;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'StopPoint(riderConfig: $riderConfig, stopLocation: $stopLocation, isPickUp: $isPickUp)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'StopPoint'))
      ..add(DiagnosticsProperty('riderConfig', riderConfig))
      ..add(DiagnosticsProperty('stopLocation', stopLocation))
      ..add(DiagnosticsProperty('isPickUp', isPickUp));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _StopPoint &&
            (identical(other.riderConfig, riderConfig) ||
                const DeepCollectionEquality()
                    .equals(other.riderConfig, riderConfig)) &&
            (identical(other.stopLocation, stopLocation) ||
                const DeepCollectionEquality()
                    .equals(other.stopLocation, stopLocation)) &&
            (identical(other.isPickUp, isPickUp) ||
                const DeepCollectionEquality()
                    .equals(other.isPickUp, isPickUp)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(riderConfig) ^
      const DeepCollectionEquality().hash(stopLocation) ^
      const DeepCollectionEquality().hash(isPickUp);

  @JsonKey(ignore: true)
  @override
  _$StopPointCopyWith<_StopPoint> get copyWith =>
      __$StopPointCopyWithImpl<_StopPoint>(this, _$identity);
}

abstract class _StopPoint implements StopPoint {
  const factory _StopPoint(
      {required RouteConfig riderConfig,
      required KapiotLocation stopLocation,
      required bool isPickUp}) = _$_StopPoint;

  @override
  RouteConfig get riderConfig => throw _privateConstructorUsedError;
  @override
  KapiotLocation get stopLocation => throw _privateConstructorUsedError;
  @override
  bool get isPickUp => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$StopPointCopyWith<_StopPoint> get copyWith =>
      throw _privateConstructorUsedError;
}
