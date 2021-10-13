import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:kapiot/logic/utils/extensions.dart';

part 'kapiot_user.freezed.dart';
part 'kapiot_user.g.dart';

enum UserType {
  student,
  faculty,
  staff,
}

extension UserTypeDescription on UserType {
  String get description => describeEnum(this).capitalize();
}

@freezed
class KapiotUser with _$KapiotUser {
  const factory KapiotUser({
    required String id,
    String? displayName,
    String? email,
    String? phoneNumber,
    String? photoUrl,
    UserType? userType,
  }) = _KapiotUser;

  factory KapiotUser.fromJson(Map<String, dynamic> json) =>
      _$KapiotUserFromJson(json);
}
