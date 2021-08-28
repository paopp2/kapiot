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
      {required KapiotUser rider,
      required KapiotLocation startLoc,
      required KapiotLocation endLoc,
      required StopPointAction action}) {
    return _StopPoint(
      rider: rider,
      startLoc: startLoc,
      endLoc: endLoc,
      action: action,
    );
  }
}

/// @nodoc
const $StopPoint = _$StopPointTearOff();

/// @nodoc
mixin _$StopPoint {
  KapiotUser get rider => throw _privateConstructorUsedError;
  KapiotLocation get startLoc => throw _privateConstructorUsedError;
  KapiotLocation get endLoc => throw _privateConstructorUsedError;
  StopPointAction get action => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StopPointCopyWith<StopPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StopPointCopyWith<$Res> {
  factory $StopPointCopyWith(StopPoint value, $Res Function(StopPoint) then) =
      _$StopPointCopyWithImpl<$Res>;
  $Res call(
      {KapiotUser rider,
      KapiotLocation startLoc,
      KapiotLocation endLoc,
      StopPointAction action});

  $KapiotUserCopyWith<$Res> get rider;
  $KapiotLocationCopyWith<$Res> get startLoc;
  $KapiotLocationCopyWith<$Res> get endLoc;
}

/// @nodoc
class _$StopPointCopyWithImpl<$Res> implements $StopPointCopyWith<$Res> {
  _$StopPointCopyWithImpl(this._value, this._then);

  final StopPoint _value;
  // ignore: unused_field
  final $Res Function(StopPoint) _then;

  @override
  $Res call({
    Object? rider = freezed,
    Object? startLoc = freezed,
    Object? endLoc = freezed,
    Object? action = freezed,
  }) {
    return _then(_value.copyWith(
      rider: rider == freezed
          ? _value.rider
          : rider // ignore: cast_nullable_to_non_nullable
              as KapiotUser,
      startLoc: startLoc == freezed
          ? _value.startLoc
          : startLoc // ignore: cast_nullable_to_non_nullable
              as KapiotLocation,
      endLoc: endLoc == freezed
          ? _value.endLoc
          : endLoc // ignore: cast_nullable_to_non_nullable
              as KapiotLocation,
      action: action == freezed
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as StopPointAction,
    ));
  }

  @override
  $KapiotUserCopyWith<$Res> get rider {
    return $KapiotUserCopyWith<$Res>(_value.rider, (value) {
      return _then(_value.copyWith(rider: value));
    });
  }

  @override
  $KapiotLocationCopyWith<$Res> get startLoc {
    return $KapiotLocationCopyWith<$Res>(_value.startLoc, (value) {
      return _then(_value.copyWith(startLoc: value));
    });
  }

  @override
  $KapiotLocationCopyWith<$Res> get endLoc {
    return $KapiotLocationCopyWith<$Res>(_value.endLoc, (value) {
      return _then(_value.copyWith(endLoc: value));
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
      {KapiotUser rider,
      KapiotLocation startLoc,
      KapiotLocation endLoc,
      StopPointAction action});

  @override
  $KapiotUserCopyWith<$Res> get rider;
  @override
  $KapiotLocationCopyWith<$Res> get startLoc;
  @override
  $KapiotLocationCopyWith<$Res> get endLoc;
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
    Object? rider = freezed,
    Object? startLoc = freezed,
    Object? endLoc = freezed,
    Object? action = freezed,
  }) {
    return _then(_StopPoint(
      rider: rider == freezed
          ? _value.rider
          : rider // ignore: cast_nullable_to_non_nullable
              as KapiotUser,
      startLoc: startLoc == freezed
          ? _value.startLoc
          : startLoc // ignore: cast_nullable_to_non_nullable
              as KapiotLocation,
      endLoc: endLoc == freezed
          ? _value.endLoc
          : endLoc // ignore: cast_nullable_to_non_nullable
              as KapiotLocation,
      action: action == freezed
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as StopPointAction,
    ));
  }
}

/// @nodoc

class _$_StopPoint with DiagnosticableTreeMixin implements _StopPoint {
  const _$_StopPoint(
      {required this.rider,
      required this.startLoc,
      required this.endLoc,
      required this.action});

  @override
  final KapiotUser rider;
  @override
  final KapiotLocation startLoc;
  @override
  final KapiotLocation endLoc;
  @override
  final StopPointAction action;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'StopPoint(rider: $rider, startLoc: $startLoc, endLoc: $endLoc, action: $action)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'StopPoint'))
      ..add(DiagnosticsProperty('rider', rider))
      ..add(DiagnosticsProperty('startLoc', startLoc))
      ..add(DiagnosticsProperty('endLoc', endLoc))
      ..add(DiagnosticsProperty('action', action));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _StopPoint &&
            (identical(other.rider, rider) ||
                const DeepCollectionEquality().equals(other.rider, rider)) &&
            (identical(other.startLoc, startLoc) ||
                const DeepCollectionEquality()
                    .equals(other.startLoc, startLoc)) &&
            (identical(other.endLoc, endLoc) ||
                const DeepCollectionEquality().equals(other.endLoc, endLoc)) &&
            (identical(other.action, action) ||
                const DeepCollectionEquality().equals(other.action, action)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(rider) ^
      const DeepCollectionEquality().hash(startLoc) ^
      const DeepCollectionEquality().hash(endLoc) ^
      const DeepCollectionEquality().hash(action);

  @JsonKey(ignore: true)
  @override
  _$StopPointCopyWith<_StopPoint> get copyWith =>
      __$StopPointCopyWithImpl<_StopPoint>(this, _$identity);
}

abstract class _StopPoint implements StopPoint {
  const factory _StopPoint(
      {required KapiotUser rider,
      required KapiotLocation startLoc,
      required KapiotLocation endLoc,
      required StopPointAction action}) = _$_StopPoint;

  @override
  KapiotUser get rider => throw _privateConstructorUsedError;
  @override
  KapiotLocation get startLoc => throw _privateConstructorUsedError;
  @override
  KapiotLocation get endLoc => throw _privateConstructorUsedError;
  @override
  StopPointAction get action => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$StopPointCopyWith<_StopPoint> get copyWith =>
      throw _privateConstructorUsedError;
}
