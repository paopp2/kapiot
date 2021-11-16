import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core/core_algorithms.dart';
import 'package:kapiot/data/core/core_providers.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/logic/driver/rider_manager_view_model.dart';
import 'package:kapiot/logic/driver/rider_manager_view_state.dart';
import 'package:kapiot/model/dist_matrix_element/dist_matrix_element.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/model/route_config/route_config.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'core_algo_point_system_test.mocks.dart';

@GenerateMocks([DistanceMatrixService])
Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'secrets/secrets.env');
  group('PS1: Single rider tests', () {
    test(
      'PS1.1.1: Assuming rider from Pitogo Lacion to Pacific Mall',
      () async {
        await verifyPoints(
          assumedTravelDistance: 5123,
          assumedTravelTime: 840,
          expectedPoints: 96.306666,
        );
      },
    );
    test(
      'PS1.1.2: Assuming rider from Mendero Medical Center to Co Jordan Farm and Fishing',
      () async {
        await verifyPoints(
          assumedTravelDistance: 2755,
          assumedTravelTime: 360,
          expectedPoints: 48.733333,
        );
      },
    );
    test(
      "PS1.1.3: Assuming rider from Citi Hardware Cebu Mandaue to Stephanie's Korean Restaurant",
      () async {
        await verifyPoints(
          assumedTravelDistance: 4603,
          assumedTravelTime: 480,
          expectedPoints: 77.373333,
        );
      },
    );
    test(
      "PS1.1.4: Assuming rider from CIM Community to KFC M.C. Briones",
      () async {
        await verifyPoints(
          assumedTravelDistance: 2645,
          assumedTravelTime: 300,
          expectedPoints: 45.266667,
        );
      },
    );
    test(
      "PS1.1.5: Assuming rider from Jagobiao NHS to DPond Family Fishing",
      () async {
        await verifyPoints(
          assumedTravelDistance: 5169,
          assumedTravelTime: 720,
          expectedPoints: 92.92,
        );
      },
    );
    test(
      'PS1.2.1: Assuming rider from Marigondon to Grandmall Basak',
      () async {
        await verifyPoints(
          assumedTravelDistance: 5225,
          assumedTravelTime: 940,
          expectedPoints: 101,
        );
      },
    );
    test(
      'PS1.2.2: Assuming rider from Mactan Doctor\'s Hospital to Tamiya, LLC',
      () async {
        await verifyPoints(
          assumedTravelDistance: 6777,
          assumedTravelTime: 1360,
          expectedPoints: 135.6933333,
        );
      },
    );
    test('PS1.2.3: Assuming rider from Babag to Cordova', () async {
      await verifyPoints(
        assumedTravelDistance: 5102,
        assumedTravelTime: 921,
        expectedPoints: 98.72666667,
      );
    });
    test(
      'PS1.2.4: Assuming rider from Soong to Savemore Maribago',
      () async {
        await verifyPoints(
          assumedTravelDistance: 2010,
          assumedTravelTime: 360,
          expectedPoints: 38.8,
        );
      },
    );
    test(
      'PS1.2.5: Assuming rider from Marigondon to Grandmall Basak',
      () async {
        await verifyPoints(
          assumedTravelDistance: 6851,
          assumedTravelTime: 1446,
          expectedPoints: 139.5466667,
        );
      },
    );
    test(
      'PS1.3.1: Assuming rider from Mabolo Church to USC-TC',
      () async {
        await verifyPoints(
          assumedTravelDistance: 4652,
          assumedTravelTime: 1440,
          expectedPoints: 110.026667,
        );
      },
    );
    test(
      'PS1.3.2: Assuming rider from USC-Main to SM City Cebu',
      () async {
        await verifyPoints(
          assumedTravelDistance: 3950,
          assumedTravelTime: 1020,
          expectedPoints: 86.666667,
        );
      },
    );
    test(
      'PS1.3.3: Assuming rider from Cafe Racer to Marco Polo Plaza Cebu',
      () async {
        await verifyPoints(
          assumedTravelDistance: 6298,
          assumedTravelTime: 1860,
          expectedPoints: 145.973333,
        );
      },
    );
    test(
      'PS1.3.4: Assuming rider from Gaisano Country Mall to SM Seaside City Cebu',
      () async {
        await verifyPoints(
          assumedTravelDistance: 9274,
          assumedTravelTime: 3120,
          expectedPoints: 227.653333,
        );
      },
    );
    test(
      'PS1.3.5: Assuming rider from Harolds Hotel to Bonifacio District',
      () async {
        await verifyPoints(
          assumedTravelDistance: 4420,
          assumedTravelTime: 1080,
          expectedPoints: 94.933333,
        );
      },
    );
  });

  group('PS2: Multi rider tests', () {
    test(
      'PS2.1.1 Assuming riders along Pitogo Barangay Hall to Pacific Mall',
      () async {
        await verifyTotalPoints(
          assumedRiderCount: 3,
          assumedDistanceTimePerRider: [
            {'distance': 2503, 'time': 364},
            {'distance': 1132, 'time': 189},
            {'distance': 1600, 'time': 315},
          ],
          expectedTotalPoints: 98.733333,
        );
      },
    );
    test(
      "PS2.1.2 Assuming riders along Seamen's Hospital Cebu to dPond Family Fishing",
      () async {
        await verifyTotalPoints(
          assumedRiderCount: 2,
          assumedDistanceTimePerRider: [
            {'distance': 2811, 'time': 300},
            {'distance': 2365, 'time': 328},
          ],
          expectedTotalPoints: 89.946667,
        );
      },
    );
    test(
      "PS2.1.3 Assuming riders along Seamen's Hospital Cebu to dPond Family Fishing",
      () async {
        await verifyTotalPoints(
          assumedRiderCount: 4,
          assumedDistanceTimePerRider: [
            {'distance': 1401, 'time': 248},
            {'distance': 1369, 'time': 188},
            {'distance': 1918, 'time': 240},
            {'distance': 2537, 'time': 366},
          ],
          expectedTotalPoints: 131.066667,
        );
      },
    );
    test(
      "PS2.1.4 Assuming riders along JMall to Paknaan Barangay Hall",
      () async {
        await verifyTotalPoints(
          assumedRiderCount: 2,
          assumedDistanceTimePerRider: [
            {'distance': 1298, 'time': 185},
            {'distance': 1301, 'time': 242},
          ],
          expectedTotalPoints: 48.886667,
        );
      },
    );
    test(
      "PS2.1.5 Assuming riders along Eversley to Co Jordan Talaban Farm Fishing",
      () async {
        await verifyTotalPoints(
          assumedRiderCount: 3,
          assumedDistanceTimePerRider: [
            {'distance': 1444, 'time': 183},
            {'distance': 750, 'time': 123},
            {'distance': 2200, 'time': 241},
          ],
          expectedTotalPoints: 76.820000,
        );
      },
    );
    test(
      'PS2.2.1: Assuming rider from Marigondon to Grandmall Basak',
      () async {
        await verifyTotalPoints(
          assumedRiderCount: 3,
          assumedDistanceTimePerRider: [
            {'distance': 1406, 'time': 364},
            {'distance': 1248, 'time': 189},
            {'distance': 1509, 'time': 315},
          ],
          expectedTotalPoints: 84.44,
        );
      },
    );
    test(
      "PS2.2.2: Assuming rider from Mactan Doctor\'s Hospital to Tamiya, LLC",
      () async {
        await verifyTotalPoints(
          assumedRiderCount: 2,
          assumedDistanceTimePerRider: [
            {'distance': 2800, 'time': 312},
            {'distance': 2265, 'time': 328},
          ],
          expectedTotalPoints: 88.86666666666667,
        );
      },
    );
    test(
      "PS2.2.3: Assuming rider from Babag to Cordova",
      () async {
        await verifyTotalPoints(
          assumedRiderCount: 4,
          assumedDistanceTimePerRider: [
            {'distance': 5102, 'time': 921},
            {'distance': 5469, 'time': 912},
            {'distance': 5258, 'time': 940},
            {'distance': 5447, 'time': 996},
          ],
          expectedTotalPoints: 409.31333333333,
        );
      },
    );
    test(
      "PS2.2.4: Assuming rider from Soong to Savemore Maribago",
      () async {
        await verifyTotalPoints(
          assumedRiderCount: 2,
          assumedDistanceTimePerRider: [
            {'distance': 2010, 'time': 360},
            {'distance': 2020, 'time': 275},
          ],
          expectedTotalPoints: 74.9,
        );
      },
    );
    test(
      "PS2.2.5: Assuming rider from Marigondon to Grandmall Basak",
      () async {
        await verifyTotalPoints(
          assumedRiderCount: 3,
          assumedDistanceTimePerRider: [
            {'distance': 6851, 'time': 1446},
            {'distance': 6750, 'time': 1423},
            {'distance': 6224, 'time': 1441},
          ],
          expectedTotalPoints: 408.0,
        );
      },
    );
    test(
      'PS2.3.1: Assuming riders along Mabolo Church to USC-TC',
      () async {
        await verifyTotalPoints(
          assumedRiderCount: 2,
          assumedDistanceTimePerRider: [
            {'distance': 4652, 'time': 1440},
            {'distance': 2745, 'time': 840},
          ],
          expectedTotalPoints: 174.626667,
        );
      },
    );
    test(
      'PS2.3.2: Assuming riders along USC-Main to SM City Cebu',
      () async {
        await verifyTotalPoints(
          assumedRiderCount: 3,
          assumedDistanceTimePerRider: [
            {'distance': 3950, 'time': 1020},
            {'distance': 2630, 'time': 960},
            {'distance': 1490, 'time': 677},
          ],
          expectedTotalPoints: 196.166667,
        );
      },
    );
    test(
      'PS2.3.3: Assuming riders along Cafe Racer to Marco Polo Plaza Cebu',
      () async {
        await verifyTotalPoints(
          assumedRiderCount: 4,
          assumedDistanceTimePerRider: [
            {'distance': 6298, 'time': 1860},
            {'distance': 1720, 'time': 628},
            {'distance': 2880, 'time': 1241},
            {'distance': 6210, 'time': 1388},
          ],
          expectedTotalPoints: 398.673333,
        );
      },
    );
    test(
      'PS2.3.4: Assuming riders along Gaisano Country Mall to SM Seaside City Cebu',
      () async {
        await verifyTotalPoints(
          assumedRiderCount: 3,
          assumedDistanceTimePerRider: [
            {'distance': 9274, 'time': 3120},
            {'distance': 2280, 'time': 482},
            {'distance': 980, 'time': 206},
          ],
          expectedTotalPoints: 294.053333,
        );
      },
    );
    test(
      'PS2.3.5: Assuming riders along Harolds Hotel to Bonifacio District',
      () async {
        await verifyTotalPoints(
          assumedRiderCount: 3,
          assumedDistanceTimePerRider: [
            {'distance': 4420, 'time': 1080},
            {'distance': 2210, 'time': 540},
            {'distance': 1470, 'time': 360},
          ],
          expectedTotalPoints: 174,
        );
      },
    );
  });
}

/// Verifies that the [expectedPoints] matches the actual calculated value by
/// the system based on the [assumedTravelDistance] and the
/// [assumedTravelTime]
///
/// The 'assumed' parameters are the assumed values to be returned by the
/// DistanceMatrixApi. The [assumedTravelDistance] should be in meters while the
/// [assumedTravelTime] in seconds. The [expectedPoints] should have at least 3
/// decimals
Future<void> verifyPoints({
  required double assumedTravelDistance,
  required double assumedTravelTime,
  required double expectedPoints,
}) async {
  final mockDistMatrixService = MockDistanceMatrixService();
  final ridersFile = File('functions/test_data/riders.json');
  final riderData = jsonDecode(await ridersFile.readAsString());
  final ridersList = riderData['ridersList'] as List<dynamic>;
  final randomConfig = RouteConfig.fromJson(ridersList.first);
  final container = ProviderContainer(
    overrides: [
      googleMapsApiServicesProvider.overrideWithValue(
        GoogleMapsApiServices(
          places: PlacesService.instance,
          directions: DirectionsService.instance,
          utils: MapsUtils.instance,
          distMatrix: mockDistMatrixService,
        ),
      )
    ],
  );
  addTearDown(container.dispose);
  final coreAlgorithms = container.read(coreAlgorithmsProvider);

  when(mockDistMatrixService.getDistMatrixElement(
    pointA: argThat(isA<KapiotLocation>(), named: 'pointA'),
    pointB: argThat(isA<KapiotLocation>(), named: 'pointB'),
  )).thenAnswer((_) async => DistMatrixElement(
        distanceText: '',
        distanceValue: assumedTravelDistance,
        durationText: '',
        durationValue: assumedTravelTime,
      ));

  final points = await coreAlgorithms.calculateDriverPointsFromRider(
    randomConfig,
  );
  expect(
    points,
    isA<double>().having(
      (pts) => (pts.toStringAsFixed(2) == expectedPoints.toStringAsFixed(2)),
      'Actual and expected points are equal for up to 2 decimal places',
      true,
    ),
  );
}

/// Verifies that the [expectedTotalPoints] matches the actual calculated value
/// by the system based on the values in the [assumedDistanceTimePerRider] of
/// length [assumedRiderCount]
///
/// For each entry in the assumedDistanceTimePerRider, there should be a value
/// for the keys 'time' and 'distance'. As the RiderManagerViewModel is the one
/// responsible for adding up the points per rider dropped off, it is the one
/// tested here.
Future<void> verifyTotalPoints({
  required int assumedRiderCount,
  required List<Map<String, double>> assumedDistanceTimePerRider,
  required double expectedTotalPoints,
}) async {
  assert(assumedRiderCount == assumedDistanceTimePerRider.length);
  final mockDistMatrixService = MockDistanceMatrixService();
  final ridersFile = File('functions/test_data/riders.json');
  final riderData = jsonDecode(await ridersFile.readAsString());
  final ridersList = riderData['ridersList'] as List<dynamic>;
  final randomConfig = RouteConfig.fromJson(ridersList.first);
  final container = ProviderContainer(
    overrides: [
      googleMapsApiServicesProvider.overrideWithValue(
        GoogleMapsApiServices(
          places: PlacesService.instance,
          directions: DirectionsService.instance,
          utils: MapsUtils.instance,
          distMatrix: mockDistMatrixService,
        ),
      ),
      currentUserProvider.overrideWithValue(const KapiotUser(id: 'fake_id')),
    ],
  );
  addTearDown(container.dispose);

  for (final entry in assumedDistanceTimePerRider) {
    when(mockDistMatrixService.getDistMatrixElement(
      pointA: argThat(isA<KapiotLocation>(), named: 'pointA'),
      pointB: argThat(isA<KapiotLocation>(), named: 'pointB'),
    )).thenAnswer((_) async => DistMatrixElement(
          distanceText: '',
          distanceValue: entry['distance']!,
          durationText: '',
          durationValue: entry['time']!,
        ));
    await container
        .read(riderManagerViewModel)
        .updateDriverPoints(randomConfig);
  }

  expect(
    container.read(driverPointsProvider).state,
    isA<double>().having(
      (tp) => (tp.toStringAsFixed(2) == expectedTotalPoints.toStringAsFixed(2)),
      'Actual and expected total points are equal for up to 2 decimal places',
      true,
    ),
  );
}
