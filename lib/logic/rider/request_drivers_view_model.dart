import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/data/repositories/rider_repository.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/logic/shared/view_model.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/model/route_config/route_config.dart';

final requestDriversViewModel = Provider.autoDispose(
  (ref) => RequestDriversViewModel(
    read: ref.read,
    riderRepo: ref.watch(riderRepositoryProvider),
  ),
);

class RequestDriversViewModel extends ViewModel {
  RequestDriversViewModel({
    required Reader read,
    required this.riderRepo,
  }) : super(read);
  final RiderRepository riderRepo;
  late final Stream<KapiotUser?> _acceptingDriver;
  late final RouteConfig _routeConfig;

  @override
  void initState() {
    assert(read(currentRouteConfigProvider).state != null);
    _routeConfig = read(currentRouteConfigProvider).state!;
    _acceptingDriver = riderRepo.getAcceptingDriverAsStream(
      _routeConfig.user.id,
    );
    respondWhenDriverAccepts(_acceptingDriver);
  }

  void requestDriver(String driverId) {
    final currentRouteConfig = read(currentRouteConfigProvider).state;
    assert(currentRouteConfig != null);
    riderRepo.requestDriver(
      driverId,
      currentRouteConfig!,
    );
  }

  Stream<List<KapiotUser>> getCompatibleDrivers() =>
      riderRepo.getCompatibleDrivers();

  Future<void> respondWhenDriverAccepts(
    Stream<KapiotUser?> acceptingDriver,
  ) async {
    acceptingDriver.listen((driver) {
      if (driver != null) {
        read(acceptingDriverProvider).state = driver;
        AppRouter.instance.navigateTo(Routes.requestAcceptedView);
      }
    });
  }
}
