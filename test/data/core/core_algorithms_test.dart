import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core/core_algorithms.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/model/route_config/route_config.dart';

void main() {
  group("Case 1: Driver at start location and along rider's route", () {
    test('1.1.1: SM Lacion to Basak Simbahan', () async {
      await verifyCompatibleDrivers(
        rider: 'Nicolas Paolo Pepito',
        shouldMatchWith: [
          "Billy Butcher",
          "Nicolas Paolo Pepito",
          "Dominic Toretto",
          "Hughie Campbell",
        ],
      );
    });
    test('1.1.2: Basak Elem School Mandaue to Pacific Mall', () async {
      await verifyCompatibleDrivers(
        rider: 'Jim Preston',
        shouldMatchWith: [
          "Nicolas Paolo Pepito",
          "Dominic Toretto",
          "Hughie Campbell",
        ],
      );
    });
    test('1.1.3: ABSCBN Mandaue to Insular Square', () async {
      await verifyCompatibleDrivers(
        rider: 'Arthur',
        shouldMatchWith: [
          "Billy Butcher",
          "Nicolas Paolo Pepito",
          "Dominic Toretto",
          "Hughie Campbell",
        ],
      );
    });

    test('1.1.4: 7/11 Lamac to Basak Elem Mandaue', () async {
      await verifyCompatibleDrivers(
        rider: "Mother's Milk",
        shouldMatchWith: [
          "Billy Butcher",
          "Nicolas Paolo Pepito",
          "Dominic Toretto",
        ],
      );
    });

    test('1.1.5: Jollibee Lacion to Toyota Mandaue North', () async {
      await verifyCompatibleDrivers(
        rider: "Frenchie",
        shouldMatchWith: [
          "Nicolas Paolo Pepito",
          "Dominic Toretto",
          "Hughie Campbell",
        ],
      );
    });

    test('1.1.6: Enjoy Shopping Lacion to QBC Sporting Supplies', () async {
      await verifyCompatibleDrivers(
        rider: "Kimiko Miyashiro",
        shouldMatchWith: [
          "Billy Butcher",
          "Nicolas Paolo Pepito",
          "Dominic Toretto",
          "Hughie Campbell",
        ],
      );
    });

    test('1.1.7: Pike the Pet Lacion to Yasco Motor Parts Mandaue', () async {
      await verifyCompatibleDrivers(
        rider: "Annie January",
        shouldMatchWith: [
          "Billy Butcher",
          "Nicolas Paolo Pepito",
          "Dominic Toretto",
          "Hughie Campbell",
        ],
      );
    });
  });

  // TODO: Update test_data with reverse routes then add tests here
  // group('Case 2: Same routes with Case 1 but reversed', () {});

  // TODO: Add check to satisfy Case 3 in core_algorithms.dart
  // group("Case 3: A user can't pair with oneself as both rider and driver", () {});

  // TODO: Any mix of Case 1 / 2 but some of the compatible drivers' current locations
  // should be 'ahead' of the rider's starting location
  // group("Case 4: Drivers can't match with passed riders even if compatible", () {});
}

/// Verifies whether the provided [rider] is compatible with the provided list
/// of drivers the rider [shouldMatchWith].
///
/// Should be placed within a 'test' function
Future<void> verifyCompatibleDrivers({
  // required KapiotLocation riderStart,
  // required KapiotLocation riderEnd,
  required String rider,
  required List<String> shouldMatchWith,
}) async {
  final container = ProviderContainer();
  final coreAlgorithms = container.read(coreAlgorithmsProvider);
  final rawTestData = File('functions/test_data.json');
  final testData = jsonDecode(await rawTestData.readAsString());
  final ridersList = testData['ridersList'] as List;
  final driversList = testData['driversList'] as List;
  // Who the rider is doesn't matter as the important property is the rider's
  // startLocation [riderStart] and endLocation [riderEnd] (copywith-ed below)
  final riderConfig = (ridersList.firstWhere((e) {
    e as Map<String, dynamic>;
    return e['user']['displayName'] == rider;
  }));

  final List<RouteConfig> compatibleDrivers = [];
  for (final driver in driversList.map((rc) => RouteConfig.fromJson(rc))) {
    if (await coreAlgorithms.checkCompatibility(
      riderConfig: RouteConfig.fromJson(riderConfig),
      driverConfig: driver,
      driverCurrentLoc: driver.startLocation,
    )) {
      compatibleDrivers.add(driver);
    }
  }
  expect(
    compatibleDrivers.map((e) => e.user.displayName).toSet(),
    shouldMatchWith.toSet(),
  );
  addTearDown(container.dispose);
}
