import 'dart:async';

import 'package:async/async.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/data/services/location_service.dart';

final hasLocService = StateProvider<bool>((ref) => true);
final hasNetService = StateProvider<bool>((ref) => true);
final hasLocPermission = StateProvider<bool>((ref) => true);

final serviceErrorHandlerProvider = Provider.autoDispose(
  (ref) {
    final locService = ref.watch(locationServiceProvider);
    final locServiceStatus = locService.serviceStatusController.stream;
    final locPermissionStatus = locService.permissionStatusController.stream;
    return ServiceErrorHandler(
      read: ref.read,
      locServiceStatus: locServiceStatus,
      locPermissionStatus: locPermissionStatus,
    );
  },
);

class ServiceErrorHandler {
  ServiceErrorHandler({
    required this.read,
    required this.locServiceStatus,
    required this.locPermissionStatus,
  });
  final Reader read;
  final Stream<ServiceStatus> locServiceStatus;
  final Stream<LocationPermission> locPermissionStatus;
  final Stream<ConnectivityResult> netServiceStatus =
      Connectivity().onConnectivityChanged;
  late final StreamSubscription _isServicesEnabledSub;
  late final StreamSubscription _locPermissionSub;
  final _appRouter = AppRouter.instance;

  void initialize() {
    bool atServiceErrorView = false;
    _isServicesEnabledSub = isRequiredServicesEnabled().listen((isEnabled) {
      if (!isEnabled && !atServiceErrorView) {
        _appRouter.navigateTo(Routes.serviceErrorView);
        atServiceErrorView = true;
      }
      if (isEnabled && atServiceErrorView) {
        _appRouter.popView();
        atServiceErrorView = false;
      }
    });

    _locPermissionSub = locPermissionStatus.listen((status) {
      final permissionDenied = (status == LocationPermission.denied ||
          status == LocationPermission.deniedForever);
      if (permissionDenied) {
        read(hasLocPermission).state = false;
        _appRouter.popAllThenNavigateTo(Routes.serviceErrorView);
      }
    });
  }

  void dispose() {
    _isServicesEnabledSub.cancel();
    _locPermissionSub.cancel();
  }

  Stream<bool> isRequiredServicesEnabled() async* {
    // Get initial status of services
    var currentNetStatus = await Connectivity().checkConnectivity();
    var currentLocStatus = await (Geolocator.isLocationServiceEnabled())
        ? ServiceStatus.enabled
        : ServiceStatus.disabled;
    final mergedServiceStream = StreamGroup.merge([
      locServiceStatus,
      netServiceStatus,
    ]);
    await for (final statusUpdate in mergedServiceStream) {
      bool? hasInternet, hasLocation;
      if (statusUpdate is ConnectivityResult) currentNetStatus = statusUpdate;
      if (statusUpdate is ServiceStatus) currentLocStatus = statusUpdate;
      hasInternet = (currentNetStatus != ConnectivityResult.none);
      hasLocation = (currentLocStatus == ServiceStatus.enabled);
      read(hasNetService).state = hasInternet;
      read(hasLocService).state = hasLocation;
      yield (hasInternet && hasLocation);
    }
  }
}
