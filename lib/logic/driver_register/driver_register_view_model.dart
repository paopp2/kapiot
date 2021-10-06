import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/repositories/user_info_repository.dart';
import 'package:kapiot/logic/shared/view_model.dart';

final driverRegisterViewModel = Provider.autoDispose(
  (ref) => DriverRegisterViewModel(
    read: ref.read,
    userInfoRepo: ref.watch(userInfoRepositoryProvider),
  ),
);

class DriverRegisterViewModel extends ViewModel {
  DriverRegisterViewModel({
    required Reader read,
    required this.userInfoRepo,
  }) : super(read);
  final UserInfoRepository userInfoRepo;

  @override
  void initState() {}
  void dispose() {}
}
