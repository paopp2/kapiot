// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'car.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Car _$CarFromJson(Map<String, dynamic> json) {
  return _Car.fromJson(json);
}

/// @nodoc
class _$CarTearOff {
  const _$CarTearOff();

  _Car call(
      {required String licensePlateNum,
      required String make,
      required String model,
      required CarType type}) {
    return _Car(
      licensePlateNum: licensePlateNum,
      make: make,
      model: model,
      type: type,
    );
  }

  Car fromJson(Map<String, Object> json) {
    return Car.fromJson(json);
  }
}

/// @nodoc
const $Car = _$CarTearOff();

/// @nodoc
mixin _$Car {
  String get licensePlateNum => throw _privateConstructorUsedError;
  String get make => throw _privateConstructorUsedError;
  String get model => throw _privateConstructorUsedError;
  CarType get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CarCopyWith<Car> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CarCopyWith<$Res> {
  factory $CarCopyWith(Car value, $Res Function(Car) then) =
      _$CarCopyWithImpl<$Res>;
  $Res call({String licensePlateNum, String make, String model, CarType type});
}

/// @nodoc
class _$CarCopyWithImpl<$Res> implements $CarCopyWith<$Res> {
  _$CarCopyWithImpl(this._value, this._then);

  final Car _value;
  // ignore: unused_field
  final $Res Function(Car) _then;

  @override
  $Res call({
    Object? licensePlateNum = freezed,
    Object? make = freezed,
    Object? model = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      licensePlateNum: licensePlateNum == freezed
          ? _value.licensePlateNum
          : licensePlateNum // ignore: cast_nullable_to_non_nullable
              as String,
      make: make == freezed
          ? _value.make
          : make // ignore: cast_nullable_to_non_nullable
              as String,
      model: model == freezed
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CarType,
    ));
  }
}

/// @nodoc
abstract class _$CarCopyWith<$Res> implements $CarCopyWith<$Res> {
  factory _$CarCopyWith(_Car value, $Res Function(_Car) then) =
      __$CarCopyWithImpl<$Res>;
  @override
  $Res call({String licensePlateNum, String make, String model, CarType type});
}

/// @nodoc
class __$CarCopyWithImpl<$Res> extends _$CarCopyWithImpl<$Res>
    implements _$CarCopyWith<$Res> {
  __$CarCopyWithImpl(_Car _value, $Res Function(_Car) _then)
      : super(_value, (v) => _then(v as _Car));

  @override
  _Car get _value => super._value as _Car;

  @override
  $Res call({
    Object? licensePlateNum = freezed,
    Object? make = freezed,
    Object? model = freezed,
    Object? type = freezed,
  }) {
    return _then(_Car(
      licensePlateNum: licensePlateNum == freezed
          ? _value.licensePlateNum
          : licensePlateNum // ignore: cast_nullable_to_non_nullable
              as String,
      make: make == freezed
          ? _value.make
          : make // ignore: cast_nullable_to_non_nullable
              as String,
      model: model == freezed
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CarType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Car extends _Car with DiagnosticableTreeMixin {
  const _$_Car(
      {required this.licensePlateNum,
      required this.make,
      required this.model,
      required this.type})
      : super._();

  factory _$_Car.fromJson(Map<String, dynamic> json) => _$$_CarFromJson(json);

  @override
  final String licensePlateNum;
  @override
  final String make;
  @override
  final String model;
  @override
  final CarType type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Car(licensePlateNum: $licensePlateNum, make: $make, model: $model, type: $type)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Car'))
      ..add(DiagnosticsProperty('licensePlateNum', licensePlateNum))
      ..add(DiagnosticsProperty('make', make))
      ..add(DiagnosticsProperty('model', model))
      ..add(DiagnosticsProperty('type', type));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Car &&
            (identical(other.licensePlateNum, licensePlateNum) ||
                const DeepCollectionEquality()
                    .equals(other.licensePlateNum, licensePlateNum)) &&
            (identical(other.make, make) ||
                const DeepCollectionEquality().equals(other.make, make)) &&
            (identical(other.model, model) ||
                const DeepCollectionEquality().equals(other.model, model)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(licensePlateNum) ^
      const DeepCollectionEquality().hash(make) ^
      const DeepCollectionEquality().hash(model) ^
      const DeepCollectionEquality().hash(type);

  @JsonKey(ignore: true)
  @override
  _$CarCopyWith<_Car> get copyWith =>
      __$CarCopyWithImpl<_Car>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CarToJson(this);
  }
}

abstract class _Car extends Car {
  const factory _Car(
      {required String licensePlateNum,
      required String make,
      required String model,
      required CarType type}) = _$_Car;
  const _Car._() : super._();

  factory _Car.fromJson(Map<String, dynamic> json) = _$_Car.fromJson;

  @override
  String get licensePlateNum => throw _privateConstructorUsedError;
  @override
  String get make => throw _privateConstructorUsedError;
  @override
  String get model => throw _privateConstructorUsedError;
  @override
  CarType get type => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CarCopyWith<_Car> get copyWith => throw _privateConstructorUsedError;
}
