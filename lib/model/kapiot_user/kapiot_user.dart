import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'kapiot_user.freezed.dart';
part 'kapiot_user.g.dart';

@freezed
class KapiotUser with _$KapiotUser {
  const factory KapiotUser({
    required String id,
    String? displayName,
    String? email,
    String? phoneNumber,
    String? photoUrl,
  }) = _KapiotUser;

  factory KapiotUser.fromJson(Map<String, dynamic> json) =>
      _$KapiotUserFromJson(json);
}
