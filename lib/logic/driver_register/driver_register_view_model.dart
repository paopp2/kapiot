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
  final licensePlateKey = GlobalKey<FormState>();
  final carMakeKey = GlobalKey<FormState>();
  final carModelKey = GlobalKey<FormState>();
  final tecLicensePlateField = TextEditingController();
  final tecCarMakeField = TextEditingController();
  final tecCarModelField = TextEditingController();

  @override
  void initState() {}

  Future<void> pushDriverInfo() async {
    assert(licensePlateKey.currentState != null);
    assert(carMakeKey.currentState != null);
    assert(carModelKey.currentState != null);
    if (licensePlateKey.currentState!.validate() &&
        carMakeKey.currentState!.validate() &&
        carModelKey.currentState!.validate()) {
      //TODO: Push Driver Info
      tecLicensePlateField.clear();
      tecCarMakeField.clear();
      tecCarModelField.clear();
    }
  }

  String? driverRegisterValidator(String? value) {
    if (value == '') {
      return "This field can't be empty";
    }
    return null;
  }

  void dispose() {}
}
