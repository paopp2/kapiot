import 'package:flutter/material.dart';
import 'package:kapiot/app_router.dart';

class PortalView extends StatelessWidget {
  const PortalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = PortalViewModel();
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
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
}
