import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core/core_providers.dart';
import 'package:kapiot/main.dart';
import 'package:kapiot/ui/driver/components/stop_point_panel.dart';
import 'package:kapiot/ui/driver/rider_manager_view.dart';
import 'package:kapiot/ui/place/route_place_picker.dart';
import 'package:kapiot/ui/home/home_view.dart';
import 'cloud_functions_api.dart';

Future<void> main() async {
  testWidgets(
    "Driver Flow Test 1",
    (WidgetTester tester) async {
      // Driver[6] : Omni Man
      final user = MockUser(
        isAnonymous: false,
        uid: 's26b3o1rpuiw1lzebv88llz7zt2m',
        email: 'omni_man_420@gmail.com',
        displayName: "Omni Man",
      );
      await tester.pumpWidget(ProviderScope(
        overrides: [
          fireauthProvider.overrideWithValue(
            MockFirebaseAuth(signedIn: true, mockUser: user),
          ),
        ],
        child: const MyApp(),
      ));

      // Populate Firestore data
      CloudFunctionsApi.populateAll();
      // dropRider calls here make sure that there are no residual riders
      // accepted from previous tests
      CloudFunctionsApi.dropRider(riderIdx: 5, driverIdx: 6);
      CloudFunctionsApi.dropRider(riderIdx: 4, driverIdx: 6);
      CloudFunctionsApi.dropRider(riderIdx: 2, driverIdx: 6);

      // @HomeView
      // App initializes map showing a CircularProgressIndicator initially
      final loadingWidget = find.byType(CircularProgressIndicator);
      expect(loadingWidget, findsOneWidget);
      await tester.pumpAndSettle();

      // Tapping on the startLoc Text @HomeView opens the PlacePickerView
      final startLocFieldHome =
          find.widgetWithIcon(Row, CupertinoIcons.smallcircle_circle);
      await tester.tap(startLocFieldHome);
      await tester.pumpAndSettle();
      expect(find.byType(RoutePlacePicker), findsOneWidget);

      // StartLoc TextField should be highlighted when PlacePickerView is pumped.
      // Entering text shows place suggestions. Tapping on the correct ListTile
      // should set the address to the TextField
      final startLocTextFieldPlacePicker =
          find.widgetWithIcon(TextField, CupertinoIcons.smallcircle_circle);
      await tester.tap(startLocTextFieldPlacePicker);
      await tester.pumpAndSettle();
      tester.testTextInput.enterText("vito pepito compound ");
      await tester.pumpAndSettle();
      final correctStartSuggestion =
          find.widgetWithText(ListTile, "Vito Pepito Compound");
      while (findsNothing.matches(correctStartSuggestion, {})) {
        await tester.pumpAndSettle();
      }
      await tester.tap(correctStartSuggestion);
      final startLocAddress = find.text(
          "Vito Pepito Compound, Cebu North Road, Pitogo, Consolacion, Cebu, Philippines");
      while (findsNothing.matches(startLocAddress, {})) {
        await tester.pumpAndSettle();
      }
      expect(startLocAddress, findsOneWidget);

      // Tapping then typing on endLocTextField should show place suggestions.
      // Pressing on a suggestion should return the app to the HomeView as the
      // app should return once both locations are set
      final endLocTextFieldPlacePicker =
          find.widgetWithIcon(TextField, CupertinoIcons.location);
      await tester.tap(endLocTextFieldPlacePicker);
      await tester.pumpAndSettle();
      tester.testTextInput.enterText("pacific mall mandaue ");
      await tester.pumpAndSettle();
      final correctEndSuggestion =
          find.widgetWithText(ListTile, "Pacific Mall Mandaue");
      while (findsNothing.matches(correctEndSuggestion, {})) {
        await tester.pumpAndSettle();
      }
      await tester.tap(correctEndSuggestion.first);
      final endLocAddress = find.text(
          "Pacific Mall Mandaue, U.N. Avenue, Mandaue City, Cebu, Philippines");
      while (findsNothing.matches(find.byType(HomeView), {})) {
        await tester.pumpAndSettle();
      }
      expect(find.byType(HomeView), findsOneWidget);
      expect(startLocAddress, findsOneWidget);
      expect(endLocAddress, findsOneWidget);
      await tester.pumpAndSettle();

      // Tap Left-arrow icon to config as Driver then hit the Start Trip button
      // to navigate to the RiderManagerView
      final arrowLeftButton = find.widgetWithIcon(
        IconButton,
        Icons.arrow_back_ios,
      );
      await tester.tap(arrowLeftButton);
      await tester.pumpAndSettle();
      final startTripButton = find.widgetWithText(ElevatedButton, "Start Trip");
      await tester.tap(startTripButton);
      await tester.pumpAndSettle();
      expect(find.byType(RiderManagerView), findsOneWidget);

      // @RiderManagerView
      // When riders request a driver, they show up as a list on the screen.
      // There should be no stop points yet when the driver has not pressed on
      // any requesting driver
      CloudFunctionsApi.requestDriver(riderIdx: 5, driverIdx: 6);
      CloudFunctionsApi.requestDriver(riderIdx: 4, driverIdx: 6);
      CloudFunctionsApi.requestDriver(riderIdx: 2, driverIdx: 6);
      while (!(findsNWidgets(3).matches(find.byType(ListTile), {}))) {
        await tester.pump();
      }
      final paoRider = find.widgetWithText(ListTile, "Nicolas Paolo Pepito");
      final jimRider = find.widgetWithText(ListTile, "Jim Preston");
      final arthurRider = find.widgetWithText(ListTile, "Arthur");
      expect(paoRider, findsOneWidget);
      expect(jimRider, findsOneWidget);
      expect(arthurRider, findsOneWidget);
      expect(find.byType(StopPointPanel), findsNothing);

      // When riders are tapped. The StopPoint panel should now be visible and
      // requests panel should now be empty
      await tester.tap(paoRider);
      await tester.pump();
      await tester.tap(jimRider);
      await tester.pump();
      await tester.tap(arthurRider);
      await tester.pump();
      while (findsNothing.matches(find.byType(StopPointPanel), {})) {
        await tester.pump();
      }
      expect(find.byType(StopPointPanel), findsOneWidget);
      while (findsWidgets.matches(find.byType(ListTile), {})) {
        await tester.pump();
      }
      expect(find.byType(ListTile), findsNothing);

      // Stored StopPoints should be in correct order.
      final doneButton = find.widgetWithText(ElevatedButton, "Done");
      await tester.pump(const Duration(seconds: 2));
      final stopPointRidersList = [
        "Nicolas Paolo Pepito",
        "Arthur",
        "Nicolas Paolo Pepito",
        "Jim Preston",
        "Arthur",
        "Jim Preston"
      ];

      final stopPointActionList = [
        "Pick up",
        "Pick up",
        "Drop off",
        "Pick up",
        "Drop off",
        "Drop off",
      ];

      int i = 0;
      while (findsWidgets.matches(doneButton, {})) {
        final rider = find.textContaining(stopPointRidersList[i]);
        while (findsNothing.matches(rider, {})) {}
        expect(find.textContaining(stopPointRidersList[i]), findsOneWidget);
        expect(find.textContaining(stopPointActionList[i]), findsOneWidget);
        await tester.tap(doneButton);
        await tester.pump(const Duration(milliseconds: 500));
        i++;
      }
      while (findsWidgets.matches(find.byType(StopPointPanel), {})) {
        await tester.pump();
      }
      expect(find.byType(StopPointPanel), findsNothing);
    },
  );
}
