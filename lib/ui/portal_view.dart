import 'package:flutter/material.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/data/helpers/realtime_db_helper.dart';

class PortalView extends StatelessWidget {
  const PortalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = PortalViewModel();
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Call any methods to run/test here
              RealtimeDbHelper.instance.setData(
                path: "trial/path",
                data: {"hello": UniqueKey().toString()},
              );
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
                  onPressed: model.gotoStopPointsView,
                  child: const Text("StopPointsView"),
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
  void gotoStopPointsView() => _router.navigateTo(Routes.stopPointsView);
  void gotoRequestDriversView() =>
      _router.navigateTo(Routes.requestDriversView);
  void gotoRequestAcceptedView() =>
      _router.navigateTo(Routes.requestAcceptedView);
  void gotoPlaceSuggestionsView() => _router.navigateTo(Routes.placePickerView);
}
