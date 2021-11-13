import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core/core_algorithms.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/model/route_config/route_config.dart';

void main() {
  group("Case 1: Drivers at their startLocs and along rider's route", () {
    test('1.1.1: Seaoil Pitogo to Consolacion Community College', () async {
      await verifyCompatibleDrivers(
        rider: 'Jim Preston',
        shouldMatchWith: ["Mark Antony"],
      );
    });
    test('1.1.2: ABSCBN Mandaue to Insular Square', () async {
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
    test('1.1.3: Rose Pharmacy Pitogo to Basak Elem Mandaue', () async {
      await verifyCompatibleDrivers(
        rider: "Mother's Milk",
        shouldMatchWith: [
          "Billy Butcher",
          "Nicolas Paolo Pepito",
          "Dominic Toretto",
        ],
      );
    });
    test('1.1.4: Jollibee Lacion to Toyota Mandaue North', () async {
      await verifyCompatibleDrivers(
        rider: "Frenchie",
        shouldMatchWith: [
          "Nicolas Paolo Pepito",
          "Dominic Toretto",
          "Hughie Campbell",
        ],
      );
    });
    test("1.1.5: Mcdo Lacion to Steph's Korean Restaurant", () async {
      await verifyCompatibleDrivers(
        rider: "A-Train",
        shouldMatchWith: ["Julius Caesar"],
      );
    });
    test('1.2.1: Soltana Nature Residences to Gaisano Grandmall Basak, LLC',
        () async {
      await verifyCompatibleDrivers(
        rider: "Robot",
        shouldMatchWith: [
          "Charles Jr. Ausejo",
          "Omni Man",
          "Damien Darkblood",
          "Allen the Alien",
        ],
      );
    });
    test('1.2.2: Basak Mercado, LLC to Mactan Doctor\'s Hospital', () async {
      await verifyCompatibleDrivers(
        rider: "Atom Eve",
        shouldMatchWith: [
          "Charles Jr. Ausejo",
          "Omni Man",
          "Damien Darkblood",
          "Allen the Alien",
        ],
      );
    });
    test('1.2.3: Cookies \'N Dream to BOSS B Food Hub', () async {
      await verifyCompatibleDrivers(
        rider: "The Immortal",
        shouldMatchWith: [
          "Charles Jr. Ausejo",
          "Omni Man",
          "Damien Darkblood",
          "Allen the Alien",
        ],
      );
    });
    test('1.2.4: Sebastien Hotel to YES Mart', () async {
      await verifyCompatibleDrivers(
        rider: "Dupli-Kate",
        shouldMatchWith: [
          "The Invincible",
          "Battle Beast",
          "Mauler",
        ],
      );
    });
    test('1.2.5: Savemore Market Maribago to Fairchild Villas', () async {
      await verifyCompatibleDrivers(
        rider: "Black Samson",
        shouldMatchWith: [
          "The Invincible",
          "Battle Beast",
          "Mauler",
        ],
      );
    });
    test('1.3.1: Prime Care @ APM Shopping Center to Kaffe Alde Mabolo',
        () async {
      await verifyCompatibleDrivers(
        rider: "Oogie Boogie",
        shouldMatchWith: [
          "Skeleton Jack",
        ],
      );
    });

    test('1.3.2: AA BBQ Salinas Drive to UC Banilad', () async {
      await verifyCompatibleDrivers(
        rider: "Morty Smith",
        shouldMatchWith: [
          "Rick Sanchez",
        ],
      );
    });

    test('1.3.3: 88th Avenue to Phoenix Banilad', () async {
      await verifyCompatibleDrivers(
        rider: "Walter White",
        shouldMatchWith: [
          "Skeleton Jack",
          "Rick Sanchez",
          "Morty Smith",
          "Jin Kazama",
        ],
      );
    });

    test('1.3.4: Cafe Georg to Coastal Conservation and Education', () async {
      await verifyCompatibleDrivers(
        rider: "Jesse Pinkman",
        shouldMatchWith: [
          "Skeleton Jack",
          "Morty Smith",
          "Rick Sanchez",
          "Jin Kazama",
        ],
      );
    });

    test('1.3.5: Holy Family Village II to Cafe Belle', () async {
      await verifyCompatibleDrivers(
        rider: "Jin Kazama",
        shouldMatchWith: [
          "Skeleton Jack",
        ],
      );
    });

    test('1.3.6: Marco Polo Plaza to SM City Cebu', () async {
      await verifyCompatibleDrivers(
        rider: "Heiachi Mishima",
        shouldMatchWith: [],
      );
    });

    test('1.3.7: USPF to Yoshimeatsu', () async {
      await verifyCompatibleDrivers(
        rider: "Hwoarang",
        shouldMatchWith: [
          "Rick Sanchez",
          "Morty Smith",
        ],
      );
    });
  });

  // TODO: Update test_data with reverse routes then add tests here
  group('Case 2: Same routes with Case 1 but reversed', () {
    test('2.1.1: Consolacion Community College to Seaoil Pitogo', () async {
      await verifyCompatibleDrivers(
        rider: 'R_Jim Preston',
        shouldMatchWith: ["R_Mark Antony"],
      );
    });
    test('2.1.2: Insular Square to ABSCBN Mandaue', () async {
      await verifyCompatibleDrivers(
        rider: 'R_Arthur',
        shouldMatchWith: [
          "R_Billy Butcher",
          "R_Nicolas Paolo Pepito",
          "R_Dominic Toretto",
          "R_Hughie Campbell",
        ],
      );
    });
    test('2.1.3: Basak Elem Mandaue to Rose Pharmacy Pitogo', () async {
      await verifyCompatibleDrivers(
        rider: "R_Mother's Milk",
        shouldMatchWith: [
          "R_Billy Butcher",
          "R_Nicolas Paolo Pepito",
          "R_Dominic Toretto",
        ],
      );
    });
    test('2.1.4: Toyota Mandaue North to Jollibee Lacion', () async {
      await verifyCompatibleDrivers(
        rider: "R_Frenchie",
        shouldMatchWith: [
          "R_Nicolas Paolo Pepito",
          "R_Dominic Toretto",
          "R_Hughie Campbell",
        ],
      );
    });
    test("2.1.5: Steph's Korean Restaurant to Mcdo Lacion", () async {
      await verifyCompatibleDrivers(
        rider: "R_A-Train",
        shouldMatchWith: ["R_Julius Caesar"],
      );
    });
    test('2.2.1: Gaisano Grandmall Basak, LLC to Soltana Nature Residences ',
        () async {
      await verifyCompatibleDrivers(
        rider: "R_Robot",
        shouldMatchWith: [
          "R_Charles Jr. Ausejo",
          "R_Omni Man",
          "R_Damien Darkblood",
          "R_Allen the Alien",
        ],
      );
    });
    test('2.2.2: Mactan Doctor\'s Hospital to Basak Mercado, LLC', () async {
      await verifyCompatibleDrivers(
        rider: "R_Atom Eve",
        shouldMatchWith: [
          "R_Charles Jr. Ausejo",
          "R_Omni Man",
          "R_Damien Darkblood",
          "R_Allen the Alien",
        ],
      );
    });
    test('2.2.3: BOSS B Food Hub to Cookies \'N Dream', () async {
      await verifyCompatibleDrivers(
        rider: "R_The Immortal",
        shouldMatchWith: [
          "R_Charles Jr. Ausejo",
          "R_Omni Man",
          "R_Damien Darkblood",
          "R_Allen the Alien",
        ],
      );
    });
    test('2.2.4: YES Mart to Sebastien Hotel', () async {
      await verifyCompatibleDrivers(
        rider: "R_Dupli-Kate",
        shouldMatchWith: [
          "R_The Invincible",
          "R_Battle Beast",
          "R_Mauler",
        ],
      );
    });
    test('2.2.5: Fairchild Villas to Savemore Market Maribago', () async {
      await verifyCompatibleDrivers(
        rider: "R_Black Samson",
        shouldMatchWith: [
          "R_The Invincible",
          "R_Battle Beast",
          "R_Mauler",
        ],
      );
    });
    test('2.3.1: Kaffee Alde Mabolo to Prime Care @ APM Shopping Center',
        () async {
      await verifyCompatibleDrivers(
        rider: "R_Oogie Boogie",
        shouldMatchWith: [
          "R_Skeleton Jack",
        ],
      );
    });
    test('2.3.2: UC Banilad to AA BBQ Salinas Drive', () async {
      await verifyCompatibleDrivers(
        rider: "R_Morty Smith",
        shouldMatchWith: [
          "R_Rick Sanchez",
        ],
      );
    });
    test('2.3.3: Phoenix Banilad to 88th Avenue', () async {
      await verifyCompatibleDrivers(
        rider: "R_Walter White",
        shouldMatchWith: [
          // "R_Skeleton Jack",
          // "R_Rick Sanchez",
          // "R_Morty Smith",
          // "R_Jin Kazama",
        ],
      );
    });
    test('2.3.4: Coastal Conservation and Education to Cafe Georg', () async {
      await verifyCompatibleDrivers(
        rider: "R_Jesse Pinkman",
        shouldMatchWith: [
          "R_Skeleton Jack",
          "R_Rick Sanchez",
          // "R_Morty Smith",
          // "R_Jin Kazama",
        ],
      );
    });
    test('2.3.5: Cafe Belle to Holy Family Village II', () async {
      await verifyCompatibleDrivers(
        rider: "R_Jin Kazama",
        shouldMatchWith: [
          // "R_Skeleton Jack",
        ],
      );
    });
  });
  group("Case 3: A user can't pair with oneself as both rider and driver", () {
    test('3.1.1A Same user: SM Lacion to Fatima Basak', () async {
      await verifyCompatibleDrivers(
        rider: "Nicolas Paolo Pepito",
        shouldMatchWith: [
          "Billy Butcher",
          "Hughie Campbell",
          "Dominic Toretto",
        ],
      );
    });
    test('3.1.1B Diff user: SM Lacion to Fatima Basak', () async {
      await verifyCompatibleDrivers(
        rider: "Gaius Octavius Thurinus",
        shouldMatchWith: [
          "Nicolas Paolo Pepito",
          "Billy Butcher",
          "Hughie Campbell",
          "Dominic Toretto",
        ],
      );
    });
    test('3.1.2A Same user: ABS CBN Mandaue to Lucky Table Factory', () async {
      await verifyCompatibleDrivers(
        rider: "Julius Caesar",
        shouldMatchWith: [],
      );
    });
    test('3.1.2B Diff user: ABS CBN Mandaue to Lucky Table Factory', () async {
      await verifyCompatibleDrivers(
        rider: "Cleopatra Philopator",
        shouldMatchWith: ["Julius Caesar"],
      );
    });
    test('3.1.3A Same user: Rose Pharmacy Pitogo to Co Jordan', () async {
      await verifyCompatibleDrivers(
        rider: "Mark Antony",
        shouldMatchWith: [],
      );
    });
    test('3.1.3B Diff user: Rose Pharmacy Pitogo to Co Jordan', () async {
      await verifyCompatibleDrivers(
        rider: "Atia Balba",
        shouldMatchWith: ["Mark Antony"],
      );
    });
    test('3.1.4A Same user: Mcdo Lacion to Lacion Municipal Hall', () async {
      await verifyCompatibleDrivers(
        rider: "Billy Butcher",
        shouldMatchWith: [
          "Nicolas Paolo Pepito",
          "Dominic Toretto",
          "Hughie Campbell",
          "Julius Caesar",
        ],
      );
    });
    test('3.1.4B Diff user: Mcdo Lacion to Lacion Municipal Hall', () async {
      await verifyCompatibleDrivers(
        rider: "The Homelander",
        shouldMatchWith: [
          "Billy Butcher",
          "Nicolas Paolo Pepito",
          "Dominic Toretto",
          "Hughie Campbell",
          "Julius Caesar",
        ],
      );
    });
    test('3.1.5A Same user: Rusi Mandaue to Dave Housing Supply', () async {
      await verifyCompatibleDrivers(
        rider: "Queen Maeve",
        shouldMatchWith: [],
      );
    });
    test('3.1.5B Diff user: RUSI Mandaue to Dave Housing Supply', () async {
      await verifyCompatibleDrivers(
        rider: "Madelyn Stillwell",
        shouldMatchWith: ["Queen Maeve"],
      );
    });
    test(
        '3.2.1A Same user: Soltana Nature Residences to Gaisano Grandmall Basak, LLC',
        () async {
      await verifyCompatibleDrivers(
        rider: "Charles Jr. Ausejo",
        shouldMatchWith: [
          "Omni Man",
          "Damien Darkblood",
          "Allen the Alien",
        ],
      );
    });
    test(
        '3.2.1B Diff user: Soltana Nature Residences to Gaisano Grandmall Basak, LLC',
        () async {
      await verifyCompatibleDrivers(
        rider: "Dekodeimos Vonzehos",
        shouldMatchWith: [
          "Charles Jr. Ausejo",
          "Omni Man",
          "Damien Darkblood",
          "Allen the Alien",
        ],
      );
    });
    test('3.2.2A Same user: Papa Rony to City Time Square, LLC', () async {
      await verifyCompatibleDrivers(
        rider: "Omni Man",
        shouldMatchWith: [
          "Charles Jr. Ausejo",
          "Damien Darkblood",
          "Allen the Alien",
        ],
      );
    });
    test('3.2.2B Diff user: Papa Rony to City Time Square, LLC', () async {
      await verifyCompatibleDrivers(
        rider: "Naughty Man",
        shouldMatchWith: [
          "Charles Jr. Ausejo",
          "Omni Man",
          "Damien Darkblood",
          "Allen the Alien",
        ],
      );
    });
    test('3.2.3A Same user: Sebastien Hotel to YES Mart', () async {
      await verifyCompatibleDrivers(
        rider: "The Invincible",
        shouldMatchWith: [
          "Battle Beast",
          "Mauler",
        ],
      );
    });
    test('3.2.3B Diff user: Sebastien Hotel to YES Mart', () async {
      await verifyCompatibleDrivers(
        rider: "Oliver Grayson",
        shouldMatchWith: [
          "The Invincible",
          "Battle Beast",
          "Mauler",
        ],
      );
    });
    test('3.2.4A Same user: AA BBQ Soong to Babag II Road', () async {
      await verifyCompatibleDrivers(
        rider: "Battle Beast",
        shouldMatchWith: [
          "The Invincible",
          "Mauler",
        ],
      );
    });
    test('3.2.4B Diff user:  AA BBQ Soong to Babag II Road', () async {
      await verifyCompatibleDrivers(
        rider: "Vazol BreastBone",
        shouldMatchWith: [
          "The Invincible",
          "Battle Beast",
          "Mauler",
        ],
      );
    });
    test('3.2.5A Same user: Mactan to Babag II Road', () async {
      await verifyCompatibleDrivers(
        rider: "Mauler",
        shouldMatchWith: [
          "The Invincible",
          "Battle Beast",
        ],
      );
    });
    test('3.2.5B Diff user:  Mactan to Babag II Road', () async {
      await verifyCompatibleDrivers(
        rider: "The REAL Mauler",
        shouldMatchWith: [
          "The Invincible",
          "Battle Beast",
          "Mauler",
        ],
      );
    });

    test('3.3.1A Same user: AA BBQ Salinas Drive to UC Banilad', () async {
      await verifyCompatibleDrivers(
        rider: "Morty Smith",
        shouldMatchWith: [
          "Rick Sanchez",
        ],
      );
    });
    test('3.3.1B Diff user: AA BBQ Salinas Drive to UC Banilad', () async {
      await verifyCompatibleDrivers(
        rider: "Steve Jobs",
        shouldMatchWith: [
          "Rick Sanchez",
          "Morty Smith",
        ],
      );
    });
    test('3.3.2A Same user: SM Cebu to Family Park Talamban', () async {
      await verifyCompatibleDrivers(
        rider: "Skeleton Jack",
        shouldMatchWith: [],
      );
    });
    test('3.3.2B Diff user: SM Cebu to Family Park Talamban', () async {
      await verifyCompatibleDrivers(
        rider: "Oogie Boogie",
        shouldMatchWith: [
          "Skeleton Jack",
        ],
      );
    });
    test('3.3.3A Same user: Sunny Hills to Ayala Cebu', () async {
      await verifyCompatibleDrivers(
        rider: "Mad Max",
        shouldMatchWith: [
          "Christian Benedict Gonzales",
        ],
      );
    });
    test('3.3.3B Diff user: Sunny Hills to Ayala Cebu', () async {
      await verifyCompatibleDrivers(
        rider: "Dolores Umbridge",
        shouldMatchWith: [
          "Christian Benedict Gonzales",
          "Mad Max",
        ],
      );
    });
    test('3.3.4A Same user: J&T Mabolo to Silver Hills Nasipit', () async {
      await verifyCompatibleDrivers(
        rider: "Jin Kazama",
        shouldMatchWith: [
          "Skeleton Jack",
        ],
      );
    });
    test('3.3.4B Diff user: J&T Mabolo to Silver Hills Nasipit', () async {
      await verifyCompatibleDrivers(
        rider: "Walter White",
        shouldMatchWith: [
          "Skeleton Jack",
          "Rick Sanchez",
          "Morty Smith",
          "Jin Kazama",
        ],
      );
    });
  });

  // TODO: Any mix of Case 1 / 2 but some of the compatible drivers' current locations
  // should be 'ahead' of the rider's starting location
  // group("Case 4: Drivers can't match with passed riders even if compatible", () {});
}

/// Verifies that [rider] is compatible with the drivers he [shouldMatchWith]
///
/// All references to either [rider] or drivers in [shouldMatchWith] should be
/// by displayName. The method should also be called within the callback of the
/// 'test' function. When [driverLocOverrides] is provided, it overrides the
/// specified driver/s' currentLocation (useful for testing the case wherein a
/// driver has passed a rider)
Future<void> verifyCompatibleDrivers({
  required String rider,
  required List<String> shouldMatchWith,
  Map<String, KapiotLocation> driverLocOverrides = const {},
}) async {
  final container = ProviderContainer();
  final coreAlgorithms = container.read(coreAlgorithmsProvider);
  final ridersFile = File('functions/test_data/riders.json');
  final driversFile = File('functions/test_data/drivers.json');
  final riderData = jsonDecode(await ridersFile.readAsString());
  final driverData = jsonDecode(await driversFile.readAsString());
  final ridersList = riderData['ridersList'] as List;
  final driversList = driverData['driversList'] as List;
  final riderConfig = (ridersList.firstWhere((e) {
    e as Map<String, dynamic>;
    return e['user']['displayName'] == rider;
  }));
  final List<RouteConfig> compatibleDrivers = [];
  for (final driver in driversList.map((rc) => RouteConfig.fromJson(rc))) {
    if (await coreAlgorithms.checkCompatibility(
      riderConfig: RouteConfig.fromJson(riderConfig),
      driverConfig: driver,
      driverCurrentLoc:
          driverLocOverrides[driver.user.displayName] ?? driver.startLocation,
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
