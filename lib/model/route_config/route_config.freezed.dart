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
      required KapiotLocation startLocation,
      required KapiotLocation endLocation,
      required int riderCount,
      RouteConfig? acceptingDriverConfig}) {
    return ForRider(
      user: user,
      timeOfTrip: timeOfTrip,
      startLocation: startLocation,
      endLocation: endLocation,
      riderCount: riderCount,
      acceptingDriverConfig: acceptingDriverConfig,
    );
  }

  ForDriver driver(
      {required KapiotUser user,
      required DateTime timeOfTrip,
      required KapiotLocation startLocation,
      required KapiotLocation endLocation,
      required String encodedRoute,
      int currentRiderCount = 0,
      required int maxRiderCount,
      required Car car}) {
    return ForDriver(
      user: user,
      timeOfTrip: timeOfTrip,
      startLocation: startLocation,
      endLocation: endLocation,
      encodedRoute: encodedRoute,
      currentRiderCount: currentRiderCount,
      maxRiderCount: maxRiderCount,
      car: car,
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
  KapiotLocation get startLocation => throw _privateConstructorUsedError;
  KapiotLocation get endLocation => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            KapiotUser user,
            DateTime timeOfTrip,
            KapiotLocation startLocation,
            KapiotLocation endLocation,
            int riderCount,
            RouteConfig? acceptingDriverConfig)
        rider,
    required TResult Function(
            KapiotUser user,
            DateTime timeOfTrip,
            KapiotLocation startLocation,
            KapiotLocation endLocation,
            String encodedRoute,
            int currentRiderCount,
            int maxRiderCount,
            Car car)
        driver,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            KapiotUser user,
            DateTime timeOfTrip,
            KapiotLocation startLocation,
            KapiotLocation endLocation,
            int riderCount,
            RouteConfig? acceptingDriverConfig)?
        rider,
    TResult Function(
            KapiotUser user,
            DateTime timeOfTrip,
            KapiotLocation startLocation,
            KapiotLocation endLocation,
            String encodedRoute,
            int currentRiderCount,
            int maxRiderCount,
            Car car)?
        driver,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            KapiotUser user,
            DateTime timeOfTrip,
            KapiotLocation startLocation,
            KapiotLocation endLocation,
            int riderCount,
            RouteConfig? acceptingDriverConfig)?
        rider,
    TResult Function(
            KapiotUser user,
            DateTime timeOfTrip,
            KapiotLocation startLocation,
            KapiotLocation endLocation,
            String encodedRoute,
            int currentRiderCount,
            int maxRiderCount,
            Car car)?
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
  $Res call(
      {KapiotUser user,
      DateTime timeOfTrip,
      KapiotLocation startLocation,
      KapiotLocation endLocation});

  $KapiotUserCopyWith<$Res> get user;
  $KapiotLocationCopyWith<$Res> get startLocation;
  $KapiotLocationCopyWith<$Res> get endLocation;
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
    Object? startLocation = freezed,
    Object? endLocation = freezed,
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
      startLocation: startLocation == freezed
          ? _value.startLocation
          : startLocation // ignore: cast_nullable_to_non_nullable
              as KapiotLocation,
      endLocation: endLocation == freezed
          ? _value.endLocation
          : endLocation // ignore: cast_nullable_to_non_nullable
              as KapiotLocation,
    ));
  }

  @override
  $KapiotUserCopyWith<$Res> get user {
    return $KapiotUserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
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
}

/// @nodoc
abstract class $ForRiderCopyWith<$Res> implements $RouteConfigCopyWith<$Res> {
  factory $ForRiderCopyWith(ForRider value, $Res Function(ForRider) then) =
      _$ForRiderCopyWithImpl<$Res>;
  @override
  $Res call(
      {KapiotUser user,
      DateTime timeOfTrip,
      KapiotLocation startLocation,
      KapiotLocation endLocation,
      int riderCount,
      RouteConfig? acceptingDriverConfig});

  @override
  $KapiotUserCopyWith<$Res> get user;
  @override
  $KapiotLocationCopyWith<$Res> get startLocation;
  @override
  $KapiotLocationCopyWith<$Res> get endLocation;
  $RouteConfigCopyWith<$Res>? get acceptingDriverConfig;
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
    Object? startLocation = freezed,
    Object? endLocation = freezed,
    Object? riderCount = freezed,
    Object? acceptingDriverConfig = freezed,
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
      startLocation: startLocation == freezed
          ? _value.startLocation
          : startLocation // ignore: cast_nullable_to_non_nullable
              as KapiotLocation,
      endLocation: endLocation == freezed
          ? _value.endLocation
          : endLocation // ignore: cast_nullable_to_non_nullable
              as KapiotLocation,
      riderCount: riderCount == freezed
          ? _value.riderCount
          : riderCount // ignore: cast_nullable_to_non_nullable
              as int,
      acceptingDriverConfig: acceptingDriverConfig == freezed
          ? _value.acceptingDriverConfig
          : acceptingDriverConfig // ignore: cast_nullable_to_non_nullable
              as RouteConfig?,
    ));
  }

  @override
  $RouteConfigCopyWith<$Res>? get acceptingDriverConfig {
    if (_value.acceptingDriverConfig == null) {
      return null;
    }

    return $RouteConfigCopyWith<$Res>(_value.acceptingDriverConfig!, (value) {
      return _then(_value.copyWith(acceptingDriverConfig: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ForRider with DiagnosticableTreeMixin implements ForRider {
  const _$ForRider(
      {required this.user,
      required this.timeOfTrip,
      required this.startLocation,
      required this.endLocation,
      required this.riderCount,
      this.acceptingDriverConfig});

  factory _$ForRider.fromJson(Map<String, dynamic> json) =>
      _$$ForRiderFromJson(json);

  @override
  final KapiotUser user;
  @override
  final DateTime timeOfTrip;
  @override
  final KapiotLocation startLocation;
  @override
  final KapiotLocation endLocation;
  @override
  final int riderCount;
  @override
  final RouteConfig? acceptingDriverConfig;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RouteConfig.rider(user: $user, timeOfTrip: $timeOfTrip, startLocation: $startLocation, endLocation: $endLocation, riderCount: $riderCount, acceptingDriverConfig: $acceptingDriverConfig)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RouteConfig.rider'))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('timeOfTrip', timeOfTrip))
      ..add(DiagnosticsProperty('startLocation', startLocation))
      ..add(DiagnosticsProperty('endLocation', endLocation))
      ..add(DiagnosticsProperty('riderCount', riderCount))
      ..add(
          DiagnosticsProperty('acceptingDriverConfig', acceptingDriverConfig));
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
            (identical(other.startLocation, startLocation) ||
                const DeepCollectionEquality()
                    .equals(other.startLocation, startLocation)) &&
            (identical(other.endLocation, endLocation) ||
                const DeepCollectionEquality()
                    .equals(other.endLocation, endLocation)) &&
            (identical(other.riderCount, riderCount) ||
                const DeepCollectionEquality()
                    .equals(other.riderCount, riderCount)) &&
            (identical(other.acceptingDriverConfig, acceptingDriverConfig) ||
                const DeepCollectionEquality().equals(
                    other.acceptingDriverConfig, acceptingDriverConfig)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(timeOfTrip) ^
      const DeepCollectionEquality().hash(startLocation) ^
      const DeepCollectionEquality().hash(endLocation) ^
      const DeepCollectionEquality().hash(riderCount) ^
      const DeepCollectionEquality().hash(acceptingDriverConfig);

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
            KapiotLocation startLocation,
            KapiotLocation endLocation,
            int riderCount,
            RouteConfig? acceptingDriverConfig)
        rider,
    required TResult Function(
            KapiotUser user,
            DateTime timeOfTrip,
            KapiotLocation startLocation,
            KapiotLocation endLocation,
            String encodedRoute,
            int currentRiderCount,
            int maxRiderCount,
            Car car)
        driver,
  }) {
    return rider(user, timeOfTrip, startLocation, endLocation, riderCount,
        acceptingDriverConfig);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            KapiotUser user,
            DateTime timeOfTrip,
            KapiotLocation startLocation,
            KapiotLocation endLocation,
            int riderCount,
            RouteConfig? acceptingDriverConfig)?
        rider,
    TResult Function(
            KapiotUser user,
            DateTime timeOfTrip,
            KapiotLocation startLocation,
            KapiotLocation endLocation,
            String encodedRoute,
            int currentRiderCount,
            int maxRiderCount,
            Car car)?
        driver,
  }) {
    return rider?.call(user, timeOfTrip, startLocation, endLocation, riderCount,
        acceptingDriverConfig);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            KapiotUser user,
            DateTime timeOfTrip,
            KapiotLocation startLocation,
            KapiotLocation endLocation,
            int riderCount,
            RouteConfig? acceptingDriverConfig)?
        rider,
    TResult Function(
            KapiotUser user,
            DateTime timeOfTrip,
            KapiotLocation startLocation,
            KapiotLocation endLocation,
            String encodedRoute,
            int currentRiderCount,
            int maxRiderCount,
            Car car)?
        driver,
    required TResult orElse(),
  }) {
    if (rider != null) {
      return rider(user, timeOfTrip, startLocation, endLocation, riderCount,
          acceptingDriverConfig);
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
      required KapiotLocation startLocation,
      required KapiotLocation endLocation,
      required int riderCount,
      RouteConfig? acceptingDriverConfig}) = _$ForRider;

  factory ForRider.fromJson(Map<String, dynamic> json) = _$ForRider.fromJson;

  @override
  KapiotUser get user => throw _privateConstructorUsedError;
  @override
  DateTime get timeOfTrip => throw _privateConstructorUsedError;
  @override
  KapiotLocation get startLocation => throw _privateConstructorUsedError;
  @override
  KapiotLocation get endLocation => throw _privateConstructorUsedError;
  int get riderCount => throw _privateConstructorUsedError;
  RouteConfig? get acceptingDriverConfig => throw _privateConstructorUsedError;
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
      KapiotLocation startLocation,
      KapiotLocation endLocation,
      String encodedRoute,
      int currentRiderCount,
      int maxRiderCount,
      Car car});

  @override
  $KapiotUserCopyWith<$Res> get user;
  @override
  $KapiotLocationCopyWith<$Res> get startLocation;
  @override
  $KapiotLocationCopyWith<$Res> get endLocation;
  $CarCopyWith<$Res> get car;
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
    Object? startLocation = freezed,
    Object? endLocation = freezed,
    Object? encodedRoute = freezed,
    Object? currentRiderCount = freezed,
    Object? maxRiderCount = freezed,
    Object? car = freezed,
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
      startLocation: startLocation == freezed
          ? _value.startLocation
          : startLocation // ignore: cast_nullable_to_non_nullable
              as KapiotLocation,
      endLocation: endLocation == freezed
          ? _value.endLocation
          : endLocation // ignore: cast_nullable_to_non_nullable
              as KapiotLocation,
      encodedRoute: encodedRoute == freezed
          ? _value.encodedRoute
          : encodedRoute // ignore: cast_nullable_to_non_nullable
              as String,
      currentRiderCount: currentRiderCount == freezed
          ? _value.currentRiderCount
          : currentRiderCount // ignore: cast_nullable_to_non_nullable
              as int,
      maxRiderCount: maxRiderCount == freezed
          ? _value.maxRiderCount
          : maxRiderCount // ignore: cast_nullable_to_non_nullable
              as int,
      car: car == freezed
          ? _value.car
          : car // ignore: cast_nullable_to_non_nullable
              as Car,
    ));
  }

  @override
  $CarCopyWith<$Res> get car {
    return $CarCopyWith<$Res>(_value.car, (value) {
      return _then(_value.copyWith(car: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ForDriver with DiagnosticableTreeMixin implements ForDriver {
  const _$ForDriver(
      {required this.user,
      required this.timeOfTrip,
      required this.startLocation,
      required this.endLocation,
      required this.encodedRoute,
      this.currentRiderCount = 0,
      required this.maxRiderCount,
      required this.car});

  factory _$ForDriver.fromJson(Map<String, dynamic> json) =>
      _$$ForDriverFromJson(json);

  @override
  final KapiotUser user;
  @override
  final DateTime timeOfTrip;
  @override
  final KapiotLocation startLocation;
  @override
  final KapiotLocation endLocation;
  @override
  final String encodedRoute;
  @JsonKey(defaultValue: 0)
  @override
  final int currentRiderCount;
  @override
  final int maxRiderCount;
  @override
  final Car car;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RouteConfig.driver(user: $user, timeOfTrip: $timeOfTrip, startLocation: $startLocation, endLocation: $endLocation, encodedRoute: $encodedRoute, currentRiderCount: $currentRiderCount, maxRiderCount: $maxRiderCount, car: $car)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RouteConfig.driver'))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('timeOfTrip', timeOfTrip))
      ..add(DiagnosticsProperty('startLocation', startLocation))
      ..add(DiagnosticsProperty('endLocation', endLocation))
      ..add(DiagnosticsProperty('encodedRoute', encodedRoute))
      ..add(DiagnosticsProperty('currentRiderCount', currentRiderCount))
      ..add(DiagnosticsProperty('maxRiderCount', maxRiderCount))
      ..add(DiagnosticsProperty('car', car));
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
            (identical(other.startLocation, startLocation) ||
                const DeepCollectionEquality()
                    .equals(other.startLocation, startLocation)) &&
            (identical(other.endLocation, endLocation) ||
                const DeepCollectionEquality()
                    .equals(other.endLocation, endLocation)) &&
            (identical(other.encodedRoute, encodedRoute) ||
                const DeepCollectionEquality()
                    .equals(other.encodedRoute, encodedRoute)) &&
            (identical(other.currentRiderCount, currentRiderCount) ||
                const DeepCollectionEquality()
                    .equals(other.currentRiderCount, currentRiderCount)) &&
            (identical(other.maxRiderCount, maxRiderCount) ||
                const DeepCollectionEquality()
                    .equals(other.maxRiderCount, maxRiderCount)) &&
            (identical(other.car, car) ||
                const DeepCollectionEquality().equals(other.car, car)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(timeOfTrip) ^
      const DeepCollectionEquality().hash(startLocation) ^
      const DeepCollectionEquality().hash(endLocation) ^
      const DeepCollectionEquality().hash(encodedRoute) ^
      const DeepCollectionEquality().hash(currentRiderCount) ^
      const DeepCollectionEquality().hash(maxRiderCount) ^
      const DeepCollectionEquality().hash(car);

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
            KapiotLocation startLocation,
            KapiotLocation endLocation,
            int riderCount,
            RouteConfig? acceptingDriverConfig)
        rider,
    required TResult Function(
            KapiotUser user,
            DateTime timeOfTrip,
            KapiotLocation startLocation,
            KapiotLocation endLocation,
            String encodedRoute,
            int currentRiderCount,
            int maxRiderCount,
            Car car)
        driver,
  }) {
    return driver(user, timeOfTrip, startLocation, endLocation, encodedRoute,
        currentRiderCount, maxRiderCount, car);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            KapiotUser user,
            DateTime timeOfTrip,
            KapiotLocation startLocation,
            KapiotLocation endLocation,
            int riderCount,
            RouteConfig? acceptingDriverConfig)?
        rider,
    TResult Function(
            KapiotUser user,
            DateTime timeOfTrip,
            KapiotLocation startLocation,
            KapiotLocation endLocation,
            String encodedRoute,
            int currentRiderCount,
            int maxRiderCount,
            Car car)?
        driver,
  }) {
    return driver?.call(user, timeOfTrip, startLocation, endLocation,
        encodedRoute, currentRiderCount, maxRiderCount, car);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            KapiotUser user,
            DateTime timeOfTrip,
            KapiotLocation startLocation,
            KapiotLocation endLocation,
            int riderCount,
            RouteConfig? acceptingDriverConfig)?
        rider,
    TResult Function(
            KapiotUser user,
            DateTime timeOfTrip,
            KapiotLocation startLocation,
            KapiotLocation endLocation,
            String encodedRoute,
            int currentRiderCount,
            int maxRiderCount,
            Car car)?
        driver,
    required TResult orElse(),
  }) {
    if (driver != null) {
      return driver(user, timeOfTrip, startLocation, endLocation, encodedRoute,
          currentRiderCount, maxRiderCount, car);
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
      required KapiotLocation startLocation,
      required KapiotLocation endLocation,
      required String encodedRoute,
      int currentRiderCount,
      required int maxRiderCount,
      required Car car}) = _$ForDriver;

  factory ForDriver.fromJson(Map<String, dynamic> json) = _$ForDriver.fromJson;

  @override
  KapiotUser get user => throw _privateConstructorUsedError;
  @override
  DateTime get timeOfTrip => throw _privateConstructorUsedError;
  @override
  KapiotLocation get startLocation => throw _privateConstructorUsedError;
  @override
  KapiotLocation get endLocation => throw _privateConstructorUsedError;
  String get encodedRoute => throw _privateConstructorUsedError;
  int get currentRiderCount => throw _privateConstructorUsedError;
  int get maxRiderCount => throw _privateConstructorUsedError;
  Car get car => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $ForDriverCopyWith<ForDriver> get copyWith =>
      throw _privateConstructorUsedError;
}
