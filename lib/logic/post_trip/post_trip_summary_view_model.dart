import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core/core_providers.dart';
import 'package:kapiot/data/repositories/rider_repository.dart';
import 'package:kapiot/logic/driver/rider_manager_view_model.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/logic/shared/view_model.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/model/route_config/route_config.dart';
import 'package:kapiot/model/transaction/transaction.dart';

final postTripSummaryViewModel = Provider.autoDispose(
  (ref) => PostTripSummaryViewModel(
    read: ref.read,
    riderRepo: ref.watch(riderRepositoryProvider),
    currentUser: ref.watch(currentUserProvider),
  ),
);

class PostTripSummaryViewModel extends ViewModel {
  PostTripSummaryViewModel({
    required Reader read,
    required this.riderRepo,
    required this.currentUser,
  }) : super(read);
  final RiderRepository riderRepo;
  final KapiotUser? currentUser;

  @override
  Future<void> initState() async {
    assert(read(acceptingDriverConfigProvider).state != null);
    assert(read(currentRouteConfigProvider).state != null);
    assert(currentUser != null);
    final acceptingDriver = read(acceptingDriverConfigProvider).state!;
    final currentUserId = currentUser!.id;
    final transaction = Transaction(currentUserId: currentUserId, driver: acceptingDriver, riders: riders, points: points, startTime: startTime, endTime: endTime, distance: distance)
  }
  Stream<List<RouteConfig>> getRiderRouteConfigs() {
    final acceptingDriverConfig = read(acceptingDriverConfigProvider).state!;
    final allRidersStream = riderRepo.getRiderConfigsStream(
      driver: acceptingDriverConfig.user,
    );
    return allRidersStream.map(
      (riderList) {
        return riderList
            .where((rider) => (rider.user.id != currentUser!.id))
            .toList();
      },
    );
  }
  @override
  void dispose() {}
}
