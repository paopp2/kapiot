import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/data/core/core_providers.dart';
import 'package:kapiot/data/repositories/user_info_repository.dart';
import 'package:kapiot/logic/shared/view_model.dart';
import 'package:kapiot/model/car/car.dart';
import 'package:kapiot/model/driver_info/driver_info.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/model/kapiot_user_info/kapiot_user_info.dart';

import 'driver_register_state.dart';

final driverRegisterViewModel = Provider.autoDispose(
  (ref) => DriverRegisterViewModel(
    read: ref.read,
    currentUser: ref.watch(currentUserProvider),
    currentUserInfo: ref.watch(currentUserInfoProvider).data?.value,
    userInfoRepo: ref.watch(userInfoRepositoryProvider),
  ),
);

class DriverRegisterViewModel extends ViewModel {
  DriverRegisterViewModel({
    required Reader read,
    required this.currentUser,
    required this.currentUserInfo,
    required this.userInfoRepo,
  }) : super(read);
  final UserInfoRepository userInfoRepo;
  final KapiotUser? currentUser;
  final KapiotUserInfo? currentUserInfo;
  final licensePlateKey = GlobalKey<FormState>();
  final carMakeKey = GlobalKey<FormState>();
  final carModelKey = GlobalKey<FormState>();
  final tecLicensePlateField = TextEditingController();
  final tecCarMakeField = TextEditingController();
  final tecCarModelField = TextEditingController();

  @override
  void dispose() {
    tecLicensePlateField.dispose();
    tecLicensePlateField.dispose();
    tecCarMakeField.dispose();
  }

  Future<void> registerCar() async {
    assert(currentUserInfo != null);
    assert(licensePlateKey.currentState != null);
    assert(carMakeKey.currentState != null);
    assert(carModelKey.currentState != null);
    if (licensePlateKey.currentState!.validate() &&
        carMakeKey.currentState!.validate() &&
        carModelKey.currentState!.validate()) {
      final userId = currentUser!.id;
      final carType = read(carTypeProvider).state;
      final carToAdd = Car(
        licensePlateNum: tecLicensePlateField.text,
        make: tecCarMakeField.text,
        model: tecCarModelField.text,
        type: carType,
      );
      final currentDriverInfo = currentUserInfo?.driverInfo;
      KapiotUserInfo? updatedUserInfo;
      if (currentDriverInfo != null) {
        final registeredCars = currentDriverInfo.registeredCars;
        updatedUserInfo = currentUserInfo!.copyWith.driverInfo!(
          registeredCars: registeredCars..add(carToAdd),
        );
      } else {
        final driverInfo = DriverInfo(registeredCars: [carToAdd]);
        updatedUserInfo = currentUserInfo!.copyWith(driverInfo: driverInfo);
      }
      userInfoRepo.pushUserInfo(userId: userId, userInfo: updatedUserInfo);
      AppRouter.instance.popView();
    }
  }

  void setCarType(CarType carType) {
    read(carTypeProvider).state = carType;
  }

  String? driverRegisterValidator(String? value) {
    return (value == '') ? "This field can't be empty" : null;
  }
}
