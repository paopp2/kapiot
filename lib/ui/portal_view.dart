import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/data/helpers/realtime_db_helper.dart';

class PortalView extends HookConsumerWidget {
  const PortalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = PortalViewModel();
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Call any methods to run/test here
              Fluttertoast.showToast(msg: 'Error retrieving address');
            },
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: model.gotoLoginView,
                  child: const Text("LoginView"),
                ),
                ElevatedButton(
                  onPressed: model.gotoHomeView,
                  child: const Text("HomeView"),
                ),
                ElevatedButton(
                  onPressed: model.gotoRiderManagerView,
                  child: const Text("RiderManagerView"),
                ),
                ElevatedButton(
                  onPressed: model.gotoRequestDriversView,
                  child: const Text("RequestDriversView"),
                ),
                ElevatedButton(
                  onPressed: model.gotoRequestAcceptedView,
                  child: const Text("RequestAcceptedView"),
                ),
                ElevatedButton(
                  onPressed: model.gotoPlaceSuggestionsView,
                  child: const Text("PlaceSuggestionsView"),
                ),
                ElevatedButton(
                  onPressed: model.gotoPostTripSummaryView,
                  child: const Text("PostTripSummaryView"),
                ),
                ElevatedButton(
                  onPressed: model.gotoInitUserInfoView,
                  child: const Text("InitUserInfoView"),
                ),
                ElevatedButton(
                  onPressed: model.gotoPlaceManagerView,
                  child: const Text("PlaceManagerView"),
                ),
                ElevatedButton(
                  onPressed: model.gotoSavePlaceView,
                  child: const Text("SavePlaceView"),
                ),
                ElevatedButton(
                  onPressed: model.gotoSavePlacePicker,
                  child: const Text("SavePlacePicker"),
                ),
                StreamBuilder(
                  stream: RealtimeDbHelper.instance.documentStream(
                    path: "trial/path",
                    builder: (data) => data,
                  ),
                  builder: (context, snapshot) {
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PortalViewModel {
  final _router = AppRouter.instance;
  void gotoHomeView() => _router.navigateTo(Routes.homeView);
  void gotoLoginView() => _router.navigateTo(Routes.loginView);
  void gotoRiderManagerView() => _router.navigateTo(Routes.riderManagerView);
  void gotoRequestDriversView() =>
      _router.navigateTo(Routes.requestDriversView);
  void gotoRequestAcceptedView() =>
      _router.navigateTo(Routes.requestAcceptedView);
  void gotoPlaceSuggestionsView() =>
      _router.navigateTo(Routes.routePlacePicker);
  void gotoPostTripSummaryView() =>
      _router.navigateTo(Routes.postTripSummaryView);

  void gotoInitUserInfoView() => _router.navigateTo(Routes.initUserInfoView);
  void gotoPlaceManagerView() => _router.navigateTo(Routes.placeManagerView);
  void gotoSavePlaceView() => _router.navigateTo(Routes.savePlaceView);
  void gotoSavePlacePicker() => _router.navigateTo(Routes.savePlacePicker);
}
