// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'route_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RouteConfig _$RouteConfigFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType'] as String?) {
    case 'rider':
      return ForRider.fromJson(json);
    case 'driver':
      return ForDriver.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'RouteConfig',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
class _$RouteConfigTearOff {
  const _$RouteConfigTearOff();

  ForRider rider(
      {required KapiotUser user,
      required DateTime timeOfTrip,
      required int riderCount,
      required KapiotLocation startLocation,
      required KapiotLocation endLocation,
      KapiotUser? acceptingDriver}) {
    return ForRider(
      user: user,
      timeOfTrip: timeOfTrip,
      riderCount: riderCount,
      startLocation: startLocation,
      endLocation: endLocation,
      acceptingDriver: acceptingDriver,
    );
  }

  ForDriver driver(
      {required KapiotUser user,
      required DateTime timeOfTrip,
      required int riderCount,
      required String encodedRoute}) {
    return ForDriver(
      user: user,
      timeOfTrip: timeOfTrip,
      riderCount: riderCount,
      encodedRoute: encodedRoute,
    );
  }

  RouteConfig fromJson(Map<String, Object> json) {
    return RouteConfig.fromJson(json);
  }
}

/// @nodoc
const $RouteConfig = _$RouteConfigTearOff();

/// @nodoc
mixin _$RouteConfig {
  KapiotUser get user => throw _privateConstructorUsedError;
  DateTime get timeOfTrip => throw _privateConstructorUsedError;
  int get riderCount => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            KapiotUser user,
            DateTime timeOfTrip,
            int riderCount,
            KapiotLocation startLocation,
            KapiotLocation endLocation,
            KapiotUser? acceptingDriver)
        rider,
    required TResult Function(KapiotUser user, DateTime timeOfTrip,
            int riderCount, String encodedRoute)
        driver,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            KapiotUser user,
            DateTime timeOfTrip,
            int riderCount,
            KapiotLocation startLocation,
            KapiotLocation endLocation,
            KapiotUser? acceptingDriver)?
        rider,
    TResult Function(KapiotUser user, DateTime timeOfTrip, int riderCount,
            String encodedRoute)?
        driver,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            KapiotUser user,
            DateTime timeOfTrip,
            int riderCount,
            KapiotLocation startLocation,
            KapiotLocation endLocation,
            KapiotUser? acceptingDriver)?
        rider,
    TResult Function(KapiotUser user, DateTime timeOfTrip, int riderCount,
            String encodedRoute)?
        driver,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ForRider value) rider,
    required TResult Function(ForDriver value) driver,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ForRider value)? rider,
    TResult Function(ForDriver value)? driver,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ForRider value)? rider,
    TResult Function(ForDriver value)? driver,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RouteConfigCopyWith<RouteConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteConfigCopyWith<$Res> {
  factory $RouteConfigCopyWith(
          RouteConfig value, $Res Function(RouteConfig) then) =
      _$RouteConfigCopyWithImpl<$Res>;
  $Res call({KapiotUser user, DateTime timeOfTrip, int riderCount});

  $KapiotUserCopyWith<$Res> get user;
}

/// @nodoc
class _$RouteConfigCopyWithImpl<$Res> implements $RouteConfigCopyWith<$Res> {
  _$RouteConfigCopyWithImpl(this._value, this._then);

  final RouteConfig _value;
  // ignore: unused_field
  final $Res Function(RouteConfig) _then;

  @override
  $Res call({
    Object? user = freezed,
    Object? timeOfTrip = freezed,
    Object? riderCount = freezed,
  }) {
    return _then(_value.copyWith(
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as KapiotUser,
      timeOfTrip: timeOfTrip == freezed
          ? _value.timeOfTrip
          : timeOfTrip // ignore: cast_nullable_to_non_nullable
              as DateTime,
      riderCount: riderCount == freezed
          ? _value.riderCount
          : riderCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  $KapiotUserCopyWith<$Res> get user {
    return $KapiotUserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc
abstract class $ForRiderCopyWith<$Res> implements $RouteConfigCopyWith<$Res> {
  factory $ForRiderCopyWith(ForRider value, $Res Function(ForRider) then) =
      _$ForRiderCopyWithImpl<$Res>;
  @override
  $Res call(
      {KapiotUser user,
      DateTime timeOfTrip,
      int riderCount,
      KapiotLocation startLocation,
      KapiotLocation endLocation,
      KapiotUser? acceptingDriver});

  @override
  $KapiotUserCopyWith<$Res> get user;
  $KapiotLocationCopyWith<$Res> get startLocation;
  $KapiotLocationCopyWith<$Res> get endLocation;
  $KapiotUserCopyWith<$Res>? get acceptingDriver;
}

/// @nodoc
class _$ForRiderCopyWithImpl<$Res> extends _$RouteConfigCopyWithImpl<$Res>
    implements $ForRiderCopyWith<$Res> {
  _$ForRiderCopyWithImpl(ForRider _value, $Res Function(ForRider) _then)
      : super(_value, (v) => _then(v as ForRider));

  @override
  ForRider get _value => super._value as ForRider;

  @override
  $Res call({
    Object? user = freezed,
    Object? timeOfTrip = freezed,
    Object? riderCount = freezed,
    Object? startLocation = freezed,
    Object? endLocation = freezed,
    Object? acceptingDriver = freezed,
  }) {
    return _then(ForRider(
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as KapiotUser,
      timeOfTrip: timeOfTrip == freezed
          ? _value.timeOfTrip
          : timeOfTrip // ignore: cast_nullable_to_non_nullable
              as DateTime,
      riderCount: riderCount == freezed
          ? _value.riderCount
          : riderCount // ignore: cast_nullable_to_non_nullable
              as int,
      startLocation: startLocation == freezed
          ? _value.startLocation
          : startLocation // ignore: cast_nullable_to_non_nullable
              as KapiotLocation,
      endLocation: endLocation == freezed
          ? _value.endLocation
          : endLocation // ignore: cast_nullable_to_non_nullable
              as KapiotLocation,
      acceptingDriver: acceptingDriver == freezed
          ? _value.acceptingDriver
          : acceptingDriver // ignore: cast_nullable_to_non_nullable
              as KapiotUser?,
    ));
  }

  @override
  $KapiotLocationCopyWith<$Res> get startLocation {
    return $KapiotLocationCopyWith<$Res>(_value.startLocation, (value) {
      return _then(_value.copyWith(startLocation: value));
    });
  }

  @override
  $KapiotLocationCopyWith<$Res> get endLocation {
    return $KapiotLocationCopyWith<$Res>(_value.endLocation, (value) {
      return _then(_value.copyWith(endLocation: value));
    });
  }

  @override
  $KapiotUserCopyWith<$Res>? get acceptingDriver {
    if (_value.acceptingDriver == null) {
      return null;
    }

    return $KapiotUserCopyWith<$Res>(_value.acceptingDriver!, (value) {
      return _then(_value.copyWith(acceptingDriver: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ForRider with DiagnosticableTreeMixin implements ForRider {
  const _$ForRider(
      {required this.user,
      required this.timeOfTrip,
      required this.riderCount,
      required this.startLocation,
      required this.endLocation,
      this.acceptingDriver});

  factory _$ForRider.fromJson(Map<String, dynamic> json) =>
      _$$ForRiderFromJson(json);

  @override
  final KapiotUser user;
  @override
  final DateTime timeOfTrip;
  @override
  final int riderCount;
  @override
  final KapiotLocation startLocation;
  @override
  final KapiotLocation endLocation;
  @override
  final KapiotUser? acceptingDriver;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RouteConfig.rider(user: $user, timeOfTrip: $timeOfTrip, riderCount: $riderCount, startLocation: $startLocation, endLocation: $endLocation, acceptingDriver: $acceptingDriver)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RouteConfig.rider'))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('timeOfTrip', timeOfTrip))
      ..add(DiagnosticsProperty('riderCount', riderCount))
      ..add(DiagnosticsProperty('startLocation', startLocation))
      ..add(DiagnosticsProperty('endLocation', endLocation))
      ..add(DiagnosticsProperty('acceptingDriver', acceptingDriver));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ForRider &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.timeOfTrip, timeOfTrip) ||
                const DeepCollectionEquality()
                    .equals(other.timeOfTrip, timeOfTrip)) &&
            (identical(other.riderCount, riderCount) ||
                const DeepCollectionEquality()
                    .equals(other.riderCount, riderCount)) &&
            (identical(other.startLocation, startLocation) ||
                const DeepCollectionEquality()
                    .equals(other.startLocation, startLocation)) &&
            (identical(other.endLocation, endLocation) ||
                const DeepCollectionEquality()
                    .equals(other.endLocation, endLocation)) &&
            (identical(other.acceptingDriver, acceptingDriver) ||
                const DeepCollectionEquality()
                    .equals(other.acceptingDriver, acceptingDriver)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(timeOfTrip) ^
      const DeepCollectionEquality().hash(riderCount) ^
      const DeepCollectionEquality().hash(startLocation) ^
      const DeepCollectionEquality().hash(endLocation) ^
      const DeepCollectionEquality().hash(acceptingDriver);

  @JsonKey(ignore: true)
  @override
  $ForRiderCopyWith<ForRider> get copyWith =>
      _$ForRiderCopyWithImpl<ForRider>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            KapiotUser user,
            DateTime timeOfTrip,
            int riderCount,
            KapiotLocation startLocation,
            KapiotLocation endLocation,
            KapiotUser? acceptingDriver)
        rider,
    required TResult Function(KapiotUser user, DateTime timeOfTrip,
            int riderCount, String encodedRoute)
        driver,
  }) {
    return rider(user, timeOfTrip, riderCount, startLocation, endLocation,
        acceptingDriver);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            KapiotUser user,
            DateTime timeOfTrip,
            int riderCount,
            KapiotLocation startLocation,
            KapiotLocation endLocation,
            KapiotUser? acceptingDriver)?
        rider,
    TResult Function(KapiotUser user, DateTime timeOfTrip, int riderCount,
            String encodedRoute)?
        driver,
  }) {
    return rider?.call(user, timeOfTrip, riderCount, startLocation, endLocation,
        acceptingDriver);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            KapiotUser user,
            DateTime timeOfTrip,
            int riderCount,
            KapiotLocation startLocation,
            KapiotLocation endLocation,
            KapiotUser? acceptingDriver)?
        rider,
    TResult Function(KapiotUser user, DateTime timeOfTrip, int riderCount,
            String encodedRoute)?
        driver,
    required TResult orElse(),
  }) {
    if (rider != null) {
      return rider(user, timeOfTrip, riderCount, startLocation, endLocation,
          acceptingDriver);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ForRider value) rider,
    required TResult Function(ForDriver value) driver,
  }) {
    return rider(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ForRider value)? rider,
    TResult Function(ForDriver value)? driver,
  }) {
    return rider?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ForRider value)? rider,
    TResult Function(ForDriver value)? driver,
    required TResult orElse(),
  }) {
    if (rider != null) {
      return rider(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ForRiderToJson(this)..['runtimeType'] = 'rider';
  }
}

abstract class ForRider implements RouteConfig {
  const factory ForRider(
      {required KapiotUser user,
      required DateTime timeOfTrip,
      required int riderCount,
      required KapiotLocation startLocation,
      required KapiotLocation endLocation,
      KapiotUser? acceptingDriver}) = _$ForRider;

  factory ForRider.fromJson(Map<String, dynamic> json) = _$ForRider.fromJson;

  @override
  KapiotUser get user => throw _privateConstructorUsedError;
  @override
  DateTime get timeOfTrip => throw _privateConstructorUsedError;
  @override
  int get riderCount => throw _privateConstructorUsedError;
  KapiotLocation get startLocation => throw _privateConstructorUsedError;
  KapiotLocation get endLocation => throw _privateConstructorUsedError;
  KapiotUser? get acceptingDriver => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $ForRiderCopyWith<ForRider> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForDriverCopyWith<$Res> implements $RouteConfigCopyWith<$Res> {
  factory $ForDriverCopyWith(ForDriver value, $Res Function(ForDriver) then) =
      _$ForDriverCopyWithImpl<$Res>;
  @override
  $Res call(
      {KapiotUser user,
      DateTime timeOfTrip,
      int riderCount,
      String encodedRoute});

  @override
  $KapiotUserCopyWith<$Res> get user;
}

/// @nodoc
class _$ForDriverCopyWithImpl<$Res> extends _$RouteConfigCopyWithImpl<$Res>
    implements $ForDriverCopyWith<$Res> {
  _$ForDriverCopyWithImpl(ForDriver _value, $Res Function(ForDriver) _then)
      : super(_value, (v) => _then(v as ForDriver));

  @override
  ForDriver get _value => super._value as ForDriver;

  @override
  $Res call({
    Object? user = freezed,
    Object? timeOfTrip = freezed,
    Object? riderCount = freezed,
    Object? encodedRoute = freezed,
  }) {
    return _then(ForDriver(
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as KapiotUser,
      timeOfTrip: timeOfTrip == freezed
          ? _value.timeOfTrip
          : timeOfTrip // ignore: cast_nullable_to_non_nullable
              as DateTime,
      riderCount: riderCount == freezed
          ? _value.riderCount
          : riderCount // ignore: cast_nullable_to_non_nullable
              as int,
      encodedRoute: encodedRoute == freezed
          ? _value.encodedRoute
          : encodedRoute // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ForDriver with DiagnosticableTreeMixin implements ForDriver {
  const _$ForDriver(
      {required this.user,
      required this.timeOfTrip,
      required this.riderCount,
      required this.encodedRoute});

  factory _$ForDriver.fromJson(Map<String, dynamic> json) =>
      _$$ForDriverFromJson(json);

  @override
  final KapiotUser user;
  @override
  final DateTime timeOfTrip;
  @override
  final int riderCount;
  @override
  final String encodedRoute;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RouteConfig.driver(user: $user, timeOfTrip: $timeOfTrip, riderCount: $riderCount, encodedRoute: $encodedRoute)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RouteConfig.driver'))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('timeOfTrip', timeOfTrip))
      ..add(DiagnosticsProperty('riderCount', riderCount))
      ..add(DiagnosticsProperty('encodedRoute', encodedRoute));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ForDriver &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.timeOfTrip, timeOfTrip) ||
                const DeepCollectionEquality()
                    .equals(other.timeOfTrip, timeOfTrip)) &&
            (identical(other.riderCount, riderCount) ||
                const DeepCollectionEquality()
                    .equals(other.riderCount, riderCount)) &&
            (identical(other.encodedRoute, encodedRoute) ||
                const DeepCollectionEquality()
                    .equals(other.encodedRoute, encodedRoute)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(timeOfTrip) ^
      const DeepCollectionEquality().hash(riderCount) ^
      const DeepCollectionEquality().hash(encodedRoute);

  @JsonKey(ignore: true)
  @override
  $ForDriverCopyWith<ForDriver> get copyWith =>
      _$ForDriverCopyWithImpl<ForDriver>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            KapiotUser user,
            DateTime timeOfTrip,
            int riderCount,
            KapiotLocation startLocation,
            KapiotLocation endLocation,
            KapiotUser? acceptingDriver)
        rider,
    required TResult Function(KapiotUser user, DateTime timeOfTrip,
            int riderCount, String encodedRoute)
        driver,
  }) {
    return driver(user, timeOfTrip, riderCount, encodedRoute);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            KapiotUser user,
            DateTime timeOfTrip,
            int riderCount,
            KapiotLocation startLocation,
            KapiotLocation endLocation,
            KapiotUser? acceptingDriver)?
        rider,
    TResult Function(KapiotUser user, DateTime timeOfTrip, int riderCount,
            String encodedRoute)?
        driver,
  }) {
    return driver?.call(user, timeOfTrip, riderCount, encodedRoute);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            KapiotUser user,
            DateTime timeOfTrip,
            int riderCount,
            KapiotLocation startLocation,
            KapiotLocation endLocation,
            KapiotUser? acceptingDriver)?
        rider,
    TResult Function(KapiotUser user, DateTime timeOfTrip, int riderCount,
            String encodedRoute)?
        driver,
    required TResult orElse(),
  }) {
    if (driver != null) {
      return driver(user, timeOfTrip, riderCount, encodedRoute);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ForRider value) rider,
    required TResult Function(ForDriver value) driver,
  }) {
    return driver(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ForRider value)? rider,
    TResult Function(ForDriver value)? driver,
  }) {
    return driver?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ForRider value)? rider,
    TResult Function(ForDriver value)? driver,
    required TResult orElse(),
  }) {
    if (driver != null) {
      return driver(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ForDriverToJson(this)..['runtimeType'] = 'driver';
  }
}

abstract class ForDriver implements RouteConfig {
  const factory ForDriver(
      {required KapiotUser user,
      required DateTime timeOfTrip,
      required int riderCount,
      required String encodedRoute}) = _$ForDriver;

  factory ForDriver.fromJson(Map<String, dynamic> json) = _$ForDriver.fromJson;

  @override
  KapiotUser get user => throw _privateConstructorUsedError;
  @override
  DateTime get timeOfTrip => throw _privateConstructorUsedError;
  @override
  int get riderCount => throw _privateConstructorUsedError;
  String get encodedRoute => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $ForDriverCopyWith<ForDriver> get copyWith =>
      throw _privateConstructorUsedError;
}
