import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'dist_matrix_element.freezed.dart';

@freezed
class DistMatrixElement with _$DistMatrixElement {
  const factory DistMatrixElement({
    String? distanceText,
    double? distanceValue,
    String? durationText,
    double? durationValue,
  }) = _DistMatrixElement;
}
