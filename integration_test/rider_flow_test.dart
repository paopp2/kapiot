import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core_providers/firebase_providers.dart';
import 'package:kapiot/main.dart';
import 'package:kapiot/ui/home/components/place_picker_view.dart';
import 'package:kapiot/ui/home/home_view.dart';
import 'package:kapiot/ui/rider/request_accepted/request_accepted_view.dart';
import 'package:kapiot/ui/rider/request_drivers/components/driver_card.dart';
import 'package:kapiot/ui/rider/request_drivers/request_drivers_view.dart';
import 'cloud_functions_api.dart';

Future<void> main() async {
  testWidgets(
    "Rider Flow Test 1",
    (WidgetTester tester) async {
      final user = MockUser(
        isAnonymous: false,
        uid: 'b1z36iHozN6agFZEdEzoTHuyjCCX',
        email: 'mothersmilk@usc.edu.ph',
        displayName: "Mother's Milk",
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

      // @HomeView
      // App initializes map showing a CircularProgressIndicator initially
      final loadingWidget = find.byType(CircularProgressIndicator);
      expect(loadingWidget, findsOneWidget);
      await tester.pumpAndSettle();

      // Tapping on the startLoc TextField @HomeView opens the PlacePickerView
      final startLocTextFieldHome =
          find.widgetWithText(TextField, "Start location");
      await tester.tap(startLocTextFieldHome);
      await tester.pumpAndSettle();
      expect(find.byType(PlacePickerView), findsOneWidget);

      // StartLoc TextField should be highlighted when PlacePickerView is pumped.
      // Entering text shows place suggestions. Tapping on the correct ListTile
      // should set the address to the TextField
      final startLocTextFieldPlacePicker =
          find.widgetWithIcon(TextField, CupertinoIcons.smallcircle_circle);
      await tester.tap(startLocTextFieldPlacePicker);
      await tester.pumpAndSettle();
      tester.testTextInput.enterText("7/11 lamac ");
      await tester.pumpAndSettle();
      final correctStartSuggestion =
          find.widgetWithText(ListTile, "7/11 Lamac");
      while (findsNothing.matches(correctStartSuggestion, {})) {
        await tester.pumpAndSettle();
      }
      await tester.tap(correctStartSuggestion);
      final startLocAddress =
          find.text("7/11 Lamac, Consolacion, Consolacion, Cebu, Philippines");
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
      tester.testTextInput.enterText("basak elementary school mandaue ");
      await tester.pumpAndSettle();
      final correctEndSuggestion =
          find.widgetWithText(ListTile, "Basak Elementary School");
      while (findsNothing.matches(correctEndSuggestion, {})) {
        await tester.pumpAndSettle();
      }
      await tester.tap(correctEndSuggestion.first);
      final endLocAddress =
          find.text("Basak Elementary School, Mandaue City, Cebu, Philippines");
      while (findsNothing.matches(endLocAddress, {})) {
        await tester.pumpAndSettle();
      }
      expect(find.byType(HomeView), findsOneWidget);
      expect(startLocAddress, findsOneWidget);
      expect(endLocAddress, findsOneWidget);

      // Rider ChoiceChip should already be selected by default therefore
      // pressing on next should navigate the app to the RequestDriversView
      final nextButton = find.widgetWithText(ElevatedButton, "Next");
      await tester.tap(nextButton);
      await tester.pumpAndSettle();
      expect(find.byType(RequestDriversView), findsOneWidget);

      // @RequestDriversView
      // At RequestDriversView, two DriverCards should be available
      await tester.pumpAndSettle();
      expect(find.byType(DriverCard), findsNWidgets(2));

      // Tapping on a DriverCard should animate their route on the map
      final domDriverCard = find.widgetWithText(
        DriverCard,
        "Dominic Toretto",
      );
      final billyDriverCard = find.widgetWithText(
        DriverCard,
        "Billy Butcher",
      );
      await tester.tap(domDriverCard);
      await tester.pumpAndSettle();
      await tester.tap(billyDriverCard);
      await tester.pumpAndSettle();

      // Pressing on a DriverCard's "Hail Ride" button requests that certain
      // driver. A rider can request as many drivers as they want. When a
      // certain driver accepts, the app should navigate to the
      // RequestAcceptedView
      final domHailRide = find.descendant(
          of: domDriverCard, matching: find.byType(ElevatedButton));
      final billyHailRide = find.descendant(
          of: billyDriverCard, matching: find.byType(ElevatedButton));
      await tester.tap(domHailRide);
      await tester.pumpAndSettle();
      await tester.tap(billyHailRide);
      await tester.pumpAndSettle();
      CloudFunctionsApi.acceptRider(
        riderIdx: 14,
        driverIdx: 8,
      ); // Rider[14] is Mother's Milk (currentUser), Driver[8] is Billy Butcher
      while (findsNothing.matches(find.byType(RequestAcceptedView), {})) {
        await tester.pumpAndSettle();
      }
      expect(find.byType(RequestAcceptedView), findsOneWidget);

      // @RequestAcceptedView
      // At RequestAcceptedView the correct accepting driver's name should be
      // shown on the screen
      expect(find.text("Billy Butcher"), findsOneWidget);

      // Adding accepted riders should show up as coriders on the screen. With
      // this, adding n number of riders should show up (n+1) CircleAvatars, the
      // additional one is the acceptingDriver's
      CloudFunctionsApi.acceptRider(riderIdx: 5, driverIdx: 8);
      CloudFunctionsApi.acceptRider(riderIdx: 6, driverIdx: 8);
      CloudFunctionsApi.acceptRider(riderIdx: 7, driverIdx: 8);
      while (!(findsNWidgets(4).matches(find.byType(CircleAvatar), {}))) {
        await tester.pumpAndSettle();
      }
      expect(find.byType(CircleAvatar), findsNWidgets(4));

      // Dropping off the currentUser brings back the app to the HomeView
      CloudFunctionsApi.dropRider(riderIdx: 14, driverIdx: 8);
      while (findsNothing.matches(find.byType(HomeView), {})) {
        await tester.pumpAndSettle();
      }
      expect(find.byType(HomeView), findsOneWidget);
    },
  );
}
