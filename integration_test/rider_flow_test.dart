import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kapiot/data/core_providers/firebase_providers.dart';
import 'package:kapiot/main.dart';
import 'package:kapiot/ui/home/components/place_picker_view.dart';
import 'package:kapiot/ui/home/home_view.dart';

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final localHostString = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  FirebaseFirestore.instance.settings = Settings(
    host: '$localHostString:8080',
    sslEnabled: false,
    persistenceEnabled: false,
  );

  testWidgets(
    "Rider Flow Test 1",
    (WidgetTester tester) async {
      final user = MockUser(
        isAnonymous: false,
        uid: 'b1z36iHozN6agFZEdEzoTHuyjCCX',
        email: 'mothersmilk@usc.edu.ph',
        displayName: "Mother's Milk (14)",
      );
      await tester.pumpWidget(ProviderScope(
        overrides: [
          fireauthProvider.overrideWithValue(
            MockFirebaseAuth(signedIn: true, mockUser: user),
          ),
        ],
        child: const MyApp(),
      ));

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
      // Then, similar with startLocTextField, tapping on the correct ListTile
      // should set the address to the TextField
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
      expect(endLocAddress, findsOneWidget);

      // Tapping on the back button should return the app to the HomeView with
      // the TextFields correctly set
      final backButton = find.byType(IconButton);
      await tester.tap(backButton);
      await tester.pumpAndSettle();
      expect(find.byType(HomeView), findsOneWidget);
      expect(startLocAddress, findsOneWidget);
      expect(endLocAddress, findsOneWidget);
    },
  );
}

// Future<void> main() async {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   final localHostString = Platform.isAndroid ? '10.0.2.2' : 'localhost';
//   FirebaseFirestore.instance.settings = Settings(
//     host: '$localHostString:8080',
//     sslEnabled: false,
//     persistenceEnabled: false,
//   );

//   testWidgets("Rider flow test", (WidgetTester tester) async {
//     await tester.pumpWidget(const ProviderScope(child: MyApp()));
//     expect(find.byType(CircularProgressIndicator), findsOneWidget);

//     await tester.pumpAndSettle();

//     final endLocField = find.widgetWithText(TextField, "End location");
//     await tester.tap(endLocField);
//     tester.testTextInput.enterText("our lady of fatima basak ");

//     await tester.pumpAndSettle();

//     final firstSuggestion = find.widgetWithText(ListTile,
//         "Our Lady of Fatima Basak Mandaue, Mandaue City, Cebu, Philippines");

//     while (findsNothing.matches(firstSuggestion, {})) {
//       await tester.pump();
//     }

//     await tester.tap(firstSuggestion);

//     while (findsOneWidget.matches(firstSuggestion, {})) {
//       await tester.pump();
//     }

//     final nextButton = find.widgetWithText(ElevatedButton, "Next");
//     await tester.tap(nextButton);

//     await tester.pumpAndSettle();

//     await CloudFunctionsApi.populateAll();

//     while (findsNothing.matches(find.byType(DriverCard), {})) {
//       await tester.pump();
//     }

//     expect(find.byType(DriverCard), findsNWidgets(2));
//     final hailRideFromDom = find.descendant(
//       of: find.widgetWithText(DriverCard, "Dominic Toretto (4)"),
//       matching: find.byType(ElevatedButton),
//     );

//     await tester.tap(hailRideFromDom);

//     // await CloudFunctionsApi.acceptRider(0);
//     // await CloudFunctionsApi.acceptRider(1);
//     await CloudFunctionsApi.acceptRider(2);

//     while (findsNothing.matches(find.text("Ride Information"), {})) {
//       await tester.pump();
//     }

//     await tester.pumpAndSettle();

//     await CloudFunctionsApi.acceptRider(4);
//     await CloudFunctionsApi.acceptRider(5);

//     await tester.pumpAndSettle();

//     final coRiderAvatar = find.descendant(
//       of: find.byType(Container),
//       matching: find.byType(CircleAvatar),
//     );

//     while (findsNothing.matches(coRiderAvatar, {})) {
//       await tester.pump();
//     }
//   });
// }
