import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core/core_algorithms.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/model/route_config/route_config.dart';

void main() {
  group("CP1: Drivers at their startLocs and along rider's route", () {
    test('CP1.1.1: Seaoil Pitogo to Consolacion Community College', () async {
      await verifyCompatibleDrivers(
        rider: 'Jim Preston',
        shouldMatchWith: ["Mark Antony"],
      );
    });
    test('CP1.1.2: ABSCBN Mandaue to Insular Square', () async {
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
    test('CP1.1.3: Rose Pharmacy Pitogo to Basak Elem Mandaue', () async {
      await verifyCompatibleDrivers(
        rider: "Mother's Milk",
        shouldMatchWith: [
          "Billy Butcher",
          "Nicolas Paolo Pepito",
          "Dominic Toretto",
        ],
      );
    });
    test('CP1.1.4: Jollibee Lacion to Toyota Mandaue North', () async {
      await verifyCompatibleDrivers(
        rider: "Frenchie",
        shouldMatchWith: [
          "Nicolas Paolo Pepito",
          "Dominic Toretto",
          "Hughie Campbell",
        ],
      );
    });
    test("CP1.1.5: Mcdo Lacion to Steph's Korean Restaurant", () async {
      await verifyCompatibleDrivers(
        rider: "A-Train",
        shouldMatchWith: ["Julius Caesar"],
      );
    });
    test('CP1.2.1: Soltana Nature Residences to Gaisano Grandmall Basak, LLC',
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
    test('CP1.2.2: Basak Mercado, LLC to Mactan Doctor\'s Hospital', () async {
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
    test('CP1.2.3: Cookies \'N Dream to BOSS B Food Hub', () async {
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
    test('CP1.2.4: Sebastien Hotel to YES Mart', () async {
      await verifyCompatibleDrivers(
        rider: "Dupli-Kate",
        shouldMatchWith: [
          "The Invincible",
          "Battle Beast",
          "Mauler",
        ],
      );
    });
    test('CP1.2.5: Savemore Market Maribago to Fairchild Villas', () async {
      await verifyCompatibleDrivers(
        rider: "Black Samson",
        shouldMatchWith: [
          "The Invincible",
          "Battle Beast",
          "Mauler",
        ],
      );
    });
    test('CP1.3.1: Prime Care @ APM Shopping Center to Kaffe Alde Mabolo',
        () async {
      await verifyCompatibleDrivers(
        rider: "Oogie Boogie",
        shouldMatchWith: [
          "Skeleton Jack",
        ],
      );
    });

    test('CP1.3.2: AA BBQ Salinas Drive to UC Banilad', () async {
      await verifyCompatibleDrivers(
        rider: "Morty Smith",
        shouldMatchWith: [
          "Rick Sanchez",
        ],
      );
    });
    test('CP1.3.3: Cafe Georg to Coastal Conservation and Education', () async {
      await verifyCompatibleDrivers(
        rider: "Jesse Pinkman",
        shouldMatchWith: [
          "Skeleton Jack",
          "Morty Smith",
          "Rick Sanchez",
          "Jin Kazama",
          "Tom Marvolo Riddle",
        ],
      );
    });
    test('CP1.3.4: Holy Family Village II to Cafe Belle', () async {
      await verifyCompatibleDrivers(
        rider: "Jin Kazama",
        shouldMatchWith: [
          "Skeleton Jack",
          "Tom Marvolo Riddle",
        ],
      );
    });
    test('CP1.3.5: USPF to Yoshimeatsu', () async {
      await verifyCompatibleDrivers(
        rider: "Hwoarang",
        shouldMatchWith: [
          "Rick Sanchez",
          "Morty Smith",
        ],
      );
    });
  });
  group('CP2: Same routes with Case 1 but reversed', () {
    test('CP2.1.1: Consolacion Community College to Seaoil Pitogo', () async {
      await verifyCompatibleDrivers(
        rider: 'R_Jim Preston',
        shouldMatchWith: ["R_Mark Antony"],
      );
    });
    test('CP2.1.2: Insular Square to ABSCBN Mandaue', () async {
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
    test('CP2.1.3: Basak Elem Mandaue to Rose Pharmacy Pitogo', () async {
      await verifyCompatibleDrivers(
        rider: "R_Mother's Milk",
        shouldMatchWith: [
          "R_Billy Butcher",
          "R_Nicolas Paolo Pepito",
          "R_Dominic Toretto",
        ],
      );
    });
    test('CP2.1.4: Toyota Mandaue North to Jollibee Lacion', () async {
      await verifyCompatibleDrivers(
        rider: "R_Frenchie",
        shouldMatchWith: [
          "R_Nicolas Paolo Pepito",
          "R_Dominic Toretto",
          "R_Hughie Campbell",
        ],
      );
    });
    test("CP2.1.5: Steph's Korean Restaurant to Mcdo Lacion", () async {
      await verifyCompatibleDrivers(
        rider: "R_A-Train",
        shouldMatchWith: ["R_Julius Caesar"],
      );
    });
    test('CP2.2.1: Gaisano Grandmall Basak, LLC to Soltana Nature Residences ',
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
    test('CP2.2.2: Mactan Doctor\'s Hospital to Basak Mercado, LLC', () async {
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
    test('CP2.2.3: BOSS B Food Hub to Cookies \'N Dream', () async {
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
    test('CP2.2.4: YES Mart to Sebastien Hotel', () async {
      await verifyCompatibleDrivers(
        rider: "R_Dupli-Kate",
        shouldMatchWith: [
          "R_The Invincible",
          "R_Battle Beast",
          "R_Mauler",
        ],
      );
    });
    test('CP2.2.5: Fairchild Villas to Savemore Market Maribago', () async {
      await verifyCompatibleDrivers(
        rider: "R_Black Samson",
        shouldMatchWith: [
          "R_The Invincible",
          "R_Battle Beast",
          "R_Mauler",
        ],
      );
    });
    test('CP2.3.1: Kaffee Alde Mabolo to Prime Care @ APM Shopping Center',
        () async {
      await verifyCompatibleDrivers(
        rider: "R_Oogie Boogie",
        shouldMatchWith: [
          "R_Skeleton Jack",
          "R_Jin Kazama",
        ],
      );
    });
    test('CP2.3.2: UC Banilad to AA BBQ Salinas Drive', () async {
      await verifyCompatibleDrivers(
        rider: "R_Morty Smith",
        shouldMatchWith: [
          "R_Rick Sanchez",
          "R_Morty Smith",
        ],
      );
    });
    test('CP2.3.3: Phoenix Banilad to 88th Avenue', () async {
      await verifyCompatibleDrivers(
        rider: "R_Walter White",
        shouldMatchWith: [
          "R_Rick Sanchez",
          "R_Morty Smith",
          "Christian Benedict Gonzales",
          "Mad Max",
          "R_Jin Kazama",
        ],
      );
    });
    test('CP2.3.4: Coastal Conservation and Education to Cafe Georg', () async {
      await verifyCompatibleDrivers(
        rider: "R_Jesse Pinkman",
        shouldMatchWith: [
          "R_Rick Sanchez",
          "R_Morty Smith",
          "Christian Benedict Gonzales",
          "Mad Max",
          "R_Jin Kazama",
        ],
      );
    });
    test('CP2.3.5: Cafe Belle to Holy Family Village II', () async {
      await verifyCompatibleDrivers(
        rider: "R_Jin Kazama",
        shouldMatchWith: [],
      );
    });
  });
  group("CP3: A user can't pair with oneself as both rider and driver", () {
    test('CP3.1.1A Same user: SM Lacion to Fatima Basak', () async {
      await verifyCompatibleDrivers(
        rider: "Nicolas Paolo Pepito",
        shouldMatchWith: [
          "Billy Butcher",
          "Hughie Campbell",
          "Dominic Toretto",
        ],
      );
    });
    test('CP3.1.1B Diff user: SM Lacion to Fatima Basak', () async {
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
    test('CP3.1.2A Same user: ABS CBN Mandaue to Lucky Table Factory',
        () async {
      await verifyCompatibleDrivers(
        rider: "Julius Caesar",
        shouldMatchWith: [],
      );
    });
    test('CP3.1.2B Diff user: ABS CBN Mandaue to Lucky Table Factory',
        () async {
      await verifyCompatibleDrivers(
        rider: "Cleopatra Philopator",
        shouldMatchWith: ["Julius Caesar"],
      );
    });
    test('CP3.1.3A Same user: Rose Pharmacy Pitogo to Co Jordan', () async {
      await verifyCompatibleDrivers(
        rider: "Mark Antony",
        shouldMatchWith: [],
      );
    });
    test('CP3.1.3B Diff user: Rose Pharmacy Pitogo to Co Jordan', () async {
      await verifyCompatibleDrivers(
        rider: "Atia Balba",
        shouldMatchWith: ["Mark Antony"],
      );
    });
    test('CP3.1.4A Same user: Mcdo Lacion to Lacion Municipal Hall', () async {
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
    test('CP3.1.4B Diff user: Mcdo Lacion to Lacion Municipal Hall', () async {
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
    test('CP3.1.5A Same user: Rusi Mandaue to Dave Housing Supply', () async {
      await verifyCompatibleDrivers(
        rider: "Queen Maeve",
        shouldMatchWith: [],
      );
    });
    test('CP3.1.5B Diff user: RUSI Mandaue to Dave Housing Supply', () async {
      await verifyCompatibleDrivers(
        rider: "Madelyn Stillwell",
        shouldMatchWith: ["Queen Maeve"],
      );
    });
    test(
        'CP3.2.1A Same user: Soltana Nature Residences to Gaisano Grandmall Basak, LLC',
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
        'CP3.2.1B Diff user: Soltana Nature Residences to Gaisano Grandmall Basak, LLC',
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
    test('CP3.2.2A Same user: Papa Rony to City Time Square, LLC', () async {
      await verifyCompatibleDrivers(
        rider: "Omni Man",
        shouldMatchWith: [
          "Charles Jr. Ausejo",
          "Damien Darkblood",
          "Allen the Alien",
        ],
      );
    });
    test('CP3.2.2B Diff user: Papa Rony to City Time Square, LLC', () async {
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
    test('CP3.2.3A Same user: Sebastien Hotel to YES Mart', () async {
      await verifyCompatibleDrivers(
        rider: "The Invincible",
        shouldMatchWith: [
          "Battle Beast",
          "Mauler",
        ],
      );
    });
    test('CP3.2.3B Diff user: Sebastien Hotel to YES Mart', () async {
      await verifyCompatibleDrivers(
        rider: "Oliver Grayson",
        shouldMatchWith: [
          "The Invincible",
          "Battle Beast",
          "Mauler",
        ],
      );
    });
    test('CP3.2.4A Same user: AA BBQ Soong to Babag II Road', () async {
      await verifyCompatibleDrivers(
        rider: "Battle Beast",
        shouldMatchWith: [
          "The Invincible",
          "Mauler",
        ],
      );
    });
    test('CP3.2.4B Diff user:  AA BBQ Soong to Babag II Road', () async {
      await verifyCompatibleDrivers(
        rider: "Vazol BreastBone",
        shouldMatchWith: [
          "The Invincible",
          "Battle Beast",
          "Mauler",
        ],
      );
    });
    test('CP3.2.5A Same user: Mactan to Babag II Road', () async {
      await verifyCompatibleDrivers(
        rider: "Mauler",
        shouldMatchWith: [
          "The Invincible",
          "Battle Beast",
        ],
      );
    });
    test('CP3.2.5B Diff user:  Mactan to Babag II Road', () async {
      await verifyCompatibleDrivers(
        rider: "The REAL Mauler",
        shouldMatchWith: [
          "The Invincible",
          "Battle Beast",
          "Mauler",
        ],
      );
    });

    test('CP3.3.1A Same user: AA BBQ Salinas Drive to UC Banilad', () async {
      await verifyCompatibleDrivers(
        rider: "Morty Smith",
        shouldMatchWith: [
          "Rick Sanchez",
        ],
      );
    });
    test('CP3.3.1B Diff user: AA BBQ Salinas Drive to UC Banilad', () async {
      await verifyCompatibleDrivers(
        rider: "Steve Jobs",
        shouldMatchWith: [
          "Rick Sanchez",
          "Morty Smith",
        ],
      );
    });
    test('CP3.3.2A Same user: SM Cebu to Family Park Talamban', () async {
      await verifyCompatibleDrivers(
        rider: "Skeleton Jack",
        shouldMatchWith: [],
      );
    });
    test('CP3.3.2B Diff user: SM Cebu to Family Park Talamban', () async {
      await verifyCompatibleDrivers(
        rider: "Oogie Boogie",
        shouldMatchWith: [
          "Skeleton Jack",
        ],
      );
    });
    test('CP3.3.3A Same user: Sunny Hills to Ayala Cebu', () async {
      await verifyCompatibleDrivers(
        rider: "Mad Max",
        shouldMatchWith: [
          "Christian Benedict Gonzales",
        ],
      );
    });
    test('CP3.3.3B Diff user: Sunny Hills to Ayala Cebu', () async {
      await verifyCompatibleDrivers(
        rider: "Dolores Umbridge",
        shouldMatchWith: [
          "Christian Benedict Gonzales",
          "Mad Max",
        ],
      );
    });
    test('CP3.3.4A Same user: J&T Mabolo to Silver Hills Nasipit', () async {
      await verifyCompatibleDrivers(
        rider: "Jin Kazama",
        shouldMatchWith: [
          "Skeleton Jack",
          "Tom Marvolo Riddle",
        ],
      );
    });
    test('CP3.3.4B Diff user: J&T Mabolo to Silver Hills Nasipit', () async {
      await verifyCompatibleDrivers(
        rider: "Walter White",
        shouldMatchWith: [
          "Skeleton Jack",
          "Rick Sanchez",
          "Morty Smith",
          "Jin Kazama",
          "Tom Marvolo Riddle"
        ],
      );
    });
    test('CP3.3.5A Same user: CIC Cebu to Tintay Terminal', () async {
      await verifyCompatibleDrivers(
        rider: "Tom Marvolo Riddle",
        shouldMatchWith: [],
      );
    });
    test('CP3.3.5B Diff user: CIC Cebu to Tintay Terminal', () async {
      await verifyCompatibleDrivers(
        rider: "Jin Kazama",
        shouldMatchWith: [
          "Skeleton Jack",
          "Tom Marvolo Riddle",
        ],
      );
    });
  });

  group("CP4: Compatible drivers can't match with passed riders", () {
    test(
      'CP4.1.1 Seaoil Pitogo to Consolacion Community College, 1 driver passed',
      () async {
        await verifyCompatibleDrivers(
          rider: "Jim Preston",
          driverCurrentLocOverrides: {
            "Mark Antony": const KapiotLocation(
              address: 'Doc Darwin Clinic',
              lat: 10.377972240521853,
              lng: 123.96308286005973,
            ),
          },
          shouldMatchWith: [],
        );
      },
    );
    test('CP4.1.2: ABSCBN Mandaue to Insular Square, 2 drivers passed',
        () async {
      await verifyCompatibleDrivers(
        rider: 'Arthur',
        driverCurrentLocOverrides: {
          "Nicolas Paolo Pepito": const KapiotLocation(
            address: "Cenapro Chemical Corp., Mandaue City, Cebu Philippines",
            lat: 10.365097859554922,
            lng: 123.95064973628318,
          ),
          "Hughie Campbell": const KapiotLocation(
            address:
                "360 Pharmacy, Skina Canduman, Mandaue City, Cebu Philippines",
            lat: 10.362572419176354,
            lng: 123.94983174740908,
          ),
        },
        shouldMatchWith: [
          "Billy Butcher",
          "Dominic Toretto",
        ],
      );
    });
    test('CP4.1.3: Insular Square to ABSCBN Mandaue', () async {
      await verifyCompatibleDrivers(
        rider: 'R_Arthur',
        driverCurrentLocOverrides: {
          "R_Billy Butcher": const KapiotLocation(
            address: "Lapas Insular Square Padung Lacion, Mandaue Cebu",
            lat: 10.350659670577313,
            lng: 123.94923958853667,
          ),
          "R_Dominic Toretto": const KapiotLocation(
            address: "Tabok Supershell Gas Station, Cebu Philippines",
            lat: 10.350962498801193,
            lng: 123.94930915643847,
          ),
        },
        shouldMatchWith: [
          "R_Nicolas Paolo Pepito",
          "R_Hughie Campbell",
        ],
      );
    });
    test(
      'CP4.1.4 Mcdo Lacion to Lacion Municipal Hall, 2 drivers passed',
      () async {
        await verifyCompatibleDrivers(
          rider: "The Homelander",
          driverCurrentLocOverrides: {
            "Julius Caesar": const KapiotLocation(
              address: "Approaching Mcdo Lacion (near but did not pass rider)",
              lat: 10.379394167865847,
              lng: 123.96523141541483,
            ),
            "Billy Butcher": const KapiotLocation(
              address: "Eleven J Bakeshop, Consolacion Cebu",
              lat: 10.378393468548602,
              lng: 123.96361026482597,
            ),
            "Dominic Toretto": const KapiotLocation(
              address: "Skina Laray, Consolacion Cebu",
              lat: 10.378795692408227,
              lng: 123.96394871330784,
            ),
          },
          shouldMatchWith: [
            "Nicolas Paolo Pepito",
            "Hughie Campbell",
            "Julius Caesar",
          ],
        );
      },
    );
    test(
      "CP4.1.5: Stephanie's Korean Restaurant to Mcdo Lacion, 1 driver passed",
      () async {
        await verifyCompatibleDrivers(
          rider: "R_A-Train",
          driverCurrentLocOverrides: {
            "R_Julius Caesar": const KapiotLocation(
              address: "Unahan Steph's Korean Restaurant",
              lat: 10.3685132733364,
              lng: 123.92905751878283,
            ),
          },
          shouldMatchWith: [],
        );
      },
    );
    test(
      'CP4.2.1: Soltana Nature Residences to Gaisano Grandmall Basak LLC, 1 driver passed',
      () async {
        await verifyCompatibleDrivers(
          rider: "Robot",
          driverCurrentLocOverrides: {
            "Charles Jr. Ausejo": const KapiotLocation(
                address: 'Basak-Marigondon Rd',
                lat: 10.289813053956808,
                lng: 123.96750010228797),
          },
          shouldMatchWith: [
            "Omni Man",
            "Damien Darkblood",
            "Allen the Alien",
          ],
        );
      },
    );
    test(
        'CP4.2.2: Basak Mercado, LLC to Mactan Doctor\'s Hospital, 2 drivers passed',
        () async {
      await verifyCompatibleDrivers(
        rider: 'Atom Eve',
        driverCurrentLocOverrides: {
          "Omni Man": const KapiotLocation(
              address: "TNC Mactan",
              lat: 10.293767415079285,
              lng: 123.96561179866607),
          "Damien Darkblood": const KapiotLocation(
              address: "6015 Basak-Marigondon Rd.",
              lat: 10.296378521568169,
              lng: 123.96448902351165),
        },
        shouldMatchWith: ["Charles Jr. Ausejo", "Allen the Alien"],
      );
    });
    test('CP4.2.3: Cookies \'N Dream to BOSS B Food Hub, 1 driver passed',
        () async {
      await verifyCompatibleDrivers(
        rider: 'The Immortal',
        driverCurrentLocOverrides: {
          "Allen the Alien": const KapiotLocation(
              address: "EUMS Water Refilling Station & Pet Supplies",
              lat: 10.307174678590808,
              lng: 123.95205208486078),
        },
        shouldMatchWith: ["Charles Jr. Ausejo", "Omni Man", "Damien Darkblood"],
      );
    });
    test(
      'CP4.2.4: YES Mart to Sebastien Hotel, 3 drivers passed',
      () async {
        await verifyCompatibleDrivers(
          rider: "R_Dupli-Kate",
          driverCurrentLocOverrides: {
            "R_The Invincible": const KapiotLocation(
                address: "M.L. Quezon National Highway",
                lat: 10.30499102729754,
                lng: 124.00823621499799),
            "R_Battle Beast": const KapiotLocation(
                address: "3 M.L. Quezon National Highway",
                lat: 10.305993824224478,
                lng: 124.00919108137111),
            "R_Mauler": const KapiotLocation(
                address: "M.L. Quezon National Highway",
                lat: 10.305184542217843,
                lng: 124.00837556211796),
          },
          shouldMatchWith: [],
        );
      },
    );
    test(
      "CP4.2.5: Fairchild Villas to Savemore Market Maribago, 2 drivers passed",
      () async {
        await verifyCompatibleDrivers(
          rider: "R_Black Samson",
          driverCurrentLocOverrides: {
            "R_The Invincible": const KapiotLocation(
                address: "Josephine Store",
                lat: 10.272994380145574,
                lng: 123.97245790192787),
            "R_Battle Beast": const KapiotLocation(
                address: "Beboy's Original La Paz Batchoy",
                lat: 10.275084628362467,
                lng: 123.97565509495247),
          },
          shouldMatchWith: ["R_Mauler"],
        );
      },
    );

    test('CP4.3.1: USPF to Yoshimeatsu, 1 driver passed', () async {
      await verifyCompatibleDrivers(
        rider: 'Hwoarang',
        driverCurrentLocOverrides: {
          "Rick Sanchez": const KapiotLocation(
            address:
                "Honda Philippines, Inc., Salinas Dr, Cebu City, 6000 Cebu",
            lat: 10.327283651784851,
            lng: 123.90527950055528,
          ),
        },
        shouldMatchWith: [
          "Morty Smith",
        ],
      );
    });
    test(
        'CP4.3.2: Cafe Georg to Coastal Conservation and Education, 2 driver passed',
        () async {
      await verifyCompatibleDrivers(
        rider: 'Jesse Pinkman',
        driverCurrentLocOverrides: {
          "Skeleton Jack": const KapiotLocation(
            address: "Mandaue Foam, Gov. M. Cuenco Ave, Cebu City, 6000 Cebu",
            lat: 10.332779236953503,
            lng: 123.91058584666708,
          ),
          "Morty Smith": const KapiotLocation(
            address: "Cebu Country Club, Cebu City, Cebu",
            lat: 10.331354330063593,
            lng: 123.91008159140792,
          ),
        },
        shouldMatchWith: [
          "Rick Sanchez",
          "Jin Kazama",
          "Tom Marvolo Riddle",
        ],
      );
    });
    test(
        'CP4.3.3: Prime Care @ APM Shopping Center to Kaffe Alde Mabolo, 1 driver passed',
        () async {
      await verifyCompatibleDrivers(
        rider: 'Oogie Boogie',
        driverCurrentLocOverrides: {
          "Skeleton Jack": const KapiotLocation(
            address: "Roadstar, 135 Juan Luna Avenue, Cebu City, 6000 Cebu",
            lat: 10.318324288528808,
            lng: 123.91257008226225,
          ),
        },
        shouldMatchWith: [],
      );
    });
    test('CP4.3.4: Holy Family Village II to Cafe Belle, 1 driver passed',
        () async {
      await verifyCompatibleDrivers(
        rider: 'Jin Kazama',
        driverCurrentLocOverrides: {
          "Rick Sanchez": const KapiotLocation(
            address:
                "Silogan Ni Gian, Banilad Gov. M. Cuenco Avenue, Cebu City, Cebu",
            lat: 10.347554190243633,
            lng: 123.91304718395735,
          ),
        },
        shouldMatchWith: [
          "Skeleton Jack",
          "Tom Marvolo Riddle",
        ],
      );
    });
    test('CP4.3.5: 88th Avenue to Phoenix Banilad, 3 driver passed', () async {
      await verifyCompatibleDrivers(
        rider: 'Walter White',
        driverCurrentLocOverrides: {
          "Jin Kazama": const KapiotLocation(
            address:
                "Cafe Georg, Ground Floor MLD Building, Gov. M. Cuenco Ave, Cebu City, 6000 Cebu",
            lat: 10.33002753149996,
            lng: 123.90959988153878,
          ),
          "Skeleton Jack": const KapiotLocation(
            address: "Mandaue Foam, Gov. M. Cuenco Ave, Cebu City, 6000 Cebu",
            lat: 10.332779236953503,
            lng: 123.91058584666708,
          ),
          "Tom Marvolo Riddle": const KapiotLocation(
            address:
                "Sr. Pedro Lechon Manok, Gov. M. Cuenco Ave, Cebu City, 6000 Cebu",
            lat: 10.3346822231077,
            lng: 123.91090879953619,
          ),
        },
        shouldMatchWith: [
          "Morty Smith",
          "Rick Sanchez",
        ],
      );
    });
  });
}

/// Verifies that [rider] is compatible with the drivers he [shouldMatchWith]
///
/// All references to either [rider] or drivers in [shouldMatchWith] should be
/// by displayName. The method should also be called within the callback of the
/// 'test' function. When [driverCurrentLocOverrides] is provided, it overrides the
/// specified driver/s' currentLocation (useful for testing the case wherein a
/// driver has passed a rider)
Future<void> verifyCompatibleDrivers({
  required String rider,
  required List<String> shouldMatchWith,
  Map<String, KapiotLocation> driverCurrentLocOverrides = const {},
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
    if (coreAlgorithms.checkCompatibility(
      riderConfig: RouteConfig.fromJson(riderConfig),
      driverConfig: driver,
      driverCurrentLoc: driverCurrentLocOverrides[driver.user.displayName] ??
          driver.startLocation,
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
