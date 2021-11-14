import 'dart:convert';
import 'dart:io' as io;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core/core_algorithms.dart';
import 'package:kapiot/model/route_config/route_config.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  io.HttpOverrides.global = null;
  await dotenv.load(fileName: 'secrets/secrets.env');
  test('PS1.1: Assuming driver from Pitogo Lacion to Pacific Mall', () async {
    await verifyPointsAcceptable(
      riders: ["Arthur", "Mother's Milk", "Frenchie"],
      expectedPoints: 185.666663,
    );
  });
  test('PS1.2: Assuming driver from Pacific Mall to Pitogo Lacion', () async {
    await verifyPointsAcceptable(
      riders: ["R_Arthur", "R_Mother's Milk", "R_Frenchie"],
      expectedPoints: 176.666663,
    );
  });
  test(
    "PS1.3: Assuming driver from Mcdo Lacion to Stephanie's Korean Restaurant",
    () async {
      await verifyPointsAcceptable(
        riders: ["A-Train"],
        expectedPoints: 103.333333,
      );
    },
  );
  test(
    "PS1.4: Assuming driver from Stepanie's Korean Restaurant to Mcdo Lacion",
    () async {
      await verifyPointsAcceptable(
        riders: ["R_A-Train"],
        expectedPoints: 99,
      );
    },
  );
  test(
    'PS1.5: Assuming driver from Seaoil Pitogo to Consolacion Community College',
    () async {
      await verifyPointsAcceptable(
        riders: ["Jim Preston"],
        expectedPoints: 33.333333,
      );
    },
  );
}

/// Verifies that the points calculated by the system is within 5% of the
/// manually calculated (expected) value
///
/// Parameters used for the manual calculation of the expected value are derived
/// from Google Maps' approximate time and distance of travel
Future<void> verifyPointsAcceptable({
  required List<String> riders,
  required double expectedPoints,
}) async {
  final container = ProviderContainer();
  final coreAlgorithms = container.read(coreAlgorithmsProvider);
  final ridersFile = io.File('functions/test_data/riders.json');
  final riderData = jsonDecode(await ridersFile.readAsString());
  final ridersList = riderData['ridersList'] as List;
  final riderConfigs = (ridersList.where(
    (rider) {
      rider as Map<String, dynamic>;
      return riders.contains(rider['user']['displayName']);
    },
  )).toList();

  double totalPoints = 0;
  for (final rider in riderConfigs) {
    totalPoints += await coreAlgorithms.calculateDriverPointsFromRider(
      RouteConfig.fromJson(rider),
    );
  }
  final percentError = ((totalPoints - expectedPoints).abs()) / expectedPoints;
  // print(totalPoints);
  // print(percentError);
  expect(
      percentError,
      isA<double>().having(
        (e) => (e < 0.05),
        'Percent error less than 5%',
        true,
      ));
}
