import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/data/core_providers/firebase_providers.dart';
import 'package:kapiot/main.dart';
import 'package:kapiot/ui/home/home_view.dart';
import 'package:kapiot/ui/rider/request_drivers/components/driver_card.dart';
import 'package:kapiot/ui/rider/request_drivers/request_drivers_view.dart';

import 'cloud_functions_api.dart';

Future<void> main() async {
  testWidgets(
    "The correct compatible drivers are shown",
    (WidgetTester tester) async {
      final user = MockUser(
        isAnonymous: false,
        uid: 'LPRde2OpOF101T42uHSWAc6tvDci',
        email: 'titan_gel_4200@email.com',
        displayName: "Titan",
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

      // Wait for loading animation to finish
      await tester.pumpAndSettle();

      await verifyCompatibility(
        tester: tester,
        startAddress: "Prime Care Cebu @ APM CENTRALE",
        endAddress: "Kaffee Alde Mabolo",
        expectedDrivers: ["Skeleton Jack"],
      );

      await verifyCompatibility(
        tester: tester,
        startAddress: "AA BBQ, Salinas Drive, Cebu City, Cebu, Philippines",
        endAddress:
            "University of Cebu - Banilad Campus, Gov. M. Cuenco Avenue, Cebu City, Cebu, Philippines",
        expectedDrivers: ["Rick Sanchez"],
      );

      await verifyCompatibility(
        tester: tester,
        startAddress:
            "88th Avenue, Gov. M. Cuenco Avenue, Cebu City, Cebu, Philippines",
        endAddress:
            "Phoenix Banilad / Kasambagan, Paradise Village Road, Cebu City, Cebu, Philippines",
        expectedDrivers: ["Skeleton Jack", "Rick Sanchez"],
      );

      await verifyCompatibility(
        tester: tester,
        startAddress: "7/11 Lamac, Consolacion, Consolacion, Cebu, Philippines",
        endAddress: "Basak Elementary School, Mandaue City, Cebu, Philippines",
        expectedDrivers: ["Dominic Toretto", "Billy Butcher"],
      );

      await verifyCompatibility(
        tester: tester,
        startAddress:
            "Jollibee, Cebu North Road, Consolacion, Cebu, Philippines",
        endAddress:
            "Toyota Mandaue North Cebu, Inc., Central Nautical Highway, Mandaue City, Cebu, Philippines",
        expectedDrivers: ["Dominic Toretto", "Hughie Campbell"],
      );

      await verifyCompatibility(
        tester: tester,
        startAddress:
            "Pike The Pet Supply Store Consolacion Branch, Consolacion, Cebu, Philippines",
        endAddress:
            "Yasco Motor Parts Corporation, North Road, Mandaue City, Cebu, Philippines",
        expectedDrivers: [
          "Dominic Toretto",
          "Billy Butcher",
          "Hughie Campbell",
        ],
      );

      await verifyCompatibility(
        tester: tester,
        startAddress:
            "Savemore Market Maribago, Maribago, Lapu-Lapu City, Cebu, Philippines",
        endAddress: "Fairchild Villas, Lapu-Lapu City, Cebu, Philippines",
        expectedDrivers: ["The Invincible"],
      );

      await verifyCompatibility(
        tester: tester,
        startAddress:
            "Soltana Nature Residences, Lapu-Lapu City, Cebu, Philippines",
        endAddress:
            "Gaisano Grandmall Basak, Grandmall, Lapu-Lapu City, Cebu, Philippines",
        expectedDrivers: ["Omni Man"],
      );
    },
  );
}

Future<void> verifyCompatibility({
  required WidgetTester tester,
  required String startAddress,
  required String endAddress,
  required List<String> expectedDrivers,
}) async {
  final startAddrSplit = startAddress.split(",");

  // String manipulation. Splitting the complete addresses into an input to
  // type into the place search TextFields, the partial address to search for in
  // the suggested places and the complete address to check for when it is set
  // after tapping on them
  String startAddrInput, startAddrSuggestion;
  if (startAddrSplit.length > 2) {
    final partialAddr = "${startAddrSplit[0]}, ${startAddrSplit[1]}";
    startAddrInput = partialAddr.toLowerCase() + " ";
    startAddrSuggestion = startAddrSplit.first;
  } else {
    startAddrInput = startAddrSplit.first.toLowerCase() + " ";
    startAddrSuggestion = startAddrSplit.first;
  }

  final endAddrSplit = endAddress.split(",");
  String endAddrInput, endAddrSuggestion;
  if (endAddrSplit.length > 2) {
    final partialAddr = "${endAddrSplit[0]}, ${endAddrSplit[1]}";
    endAddrInput = partialAddr.toLowerCase() + " ";
    endAddrSuggestion = endAddrSplit.first;
  } else {
    endAddrInput = endAddrSplit.first.toLowerCase() + " ";
    endAddrSuggestion = endAddrSplit.first;
  }

  // Tapping on the startLoc TextField @HomeView opens the PlacePickerView
  final startLocTextFieldHome =
      find.widgetWithText(TextField, "Start location");
  await tester.tap(startLocTextFieldHome);
  await tester.pumpAndSettle();

  // StartLoc TextField should be highlighted when PlacePickerView is pumped.
  // Entering text shows place suggestions. Tapping on the correct ListTile
  // should set the address to the TextField
  final startLocTextFieldPlacePicker =
      find.widgetWithIcon(TextField, CupertinoIcons.smallcircle_circle);
  await tester.tap(startLocTextFieldPlacePicker);
  await tester.pumpAndSettle();
  tester.testTextInput.enterText(startAddrInput);
  await tester.pumpAndSettle();
  final correctStartSuggestion =
      find.widgetWithText(ListTile, startAddrSuggestion);
  while (findsNothing.matches(correctStartSuggestion, {})) {
    await tester.pumpAndSettle();
  }
  await tester.tap(correctStartSuggestion.first);
  final startLocAddress = find.ancestor(
    of: find.textContaining(startAddress),
    matching: find.byType(TextField),
  );
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
  tester.testTextInput.enterText(endAddrInput);
  await tester.pumpAndSettle();
  final correctEndSuggestion = find.widgetWithText(ListTile, endAddrSuggestion);
  while (findsNothing.matches(correctEndSuggestion, {})) {
    await tester.pumpAndSettle();
  }
  await tester.tap(correctEndSuggestion.first);
  final endLocAddress = find.ancestor(
    of: find.textContaining(endAddress),
    matching: find.byType(TextField),
  );
  while (findsNothing.matches(find.byType(HomeView), {})) {
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
  // At RequestDriversView, verify that there are the correct number of shown
  // (compatible) drivers
  await tester.pumpAndSettle();
  expect(
    find.byType(DriverCard, skipOffstage: false),
    findsNWidgets(expectedDrivers.length),
  );

  // Tapping on each DriverCard should animate their route on the map
  for (var driver in expectedDrivers) {
    var driverCard = find.widgetWithText(DriverCard, driver);
    await tester.ensureVisible(driverCard);
    await tester.tap(driverCard);
    await tester.pumpAndSettle();
  }
  AppRouter.instance.popView();
  while (findsNothing.matches(find.byType(HomeView), {})) {
    await tester.pumpAndSettle();
  }
  expect(find.byType(HomeView), findsOneWidget);
}
