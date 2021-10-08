import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/repositories/user_info_repository.dart';
import 'package:kapiot/logic/shared/view_model.dart';
import 'package:kapiot/model/car/car.dart';

import 'driver_register_state.dart';

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
    assert(read(carTypeProvider).state != null);
    if (licensePlateKey.currentState!.validate() &&
        carMakeKey.currentState!.validate() &&
        carModelKey.currentState!.validate()) {
      //TODO: Push Driver Info
      //* Read current state of userInfo
      //* copyWith driverInf
      //* Push updated userInfo
      tecLicensePlateField.clear();
      tecCarMakeField.clear();
      tecCarModelField.clear();
    }
  }

  void setCarType(CarType carType) {
    read(carTypeProvider).state = carType;
  }

  String? driverRegisterValidator(String? value) {
    if (value == '') {
      return "This field can't be empty";
    }
    return null;
  }

  @override
  void dispose() {
    tecLicensePlateField.dispose();
    tecLicensePlateField.dispose();
    tecCarMakeField.dispose();
  }
}
