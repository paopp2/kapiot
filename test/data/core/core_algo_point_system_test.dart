import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core/core_algorithms.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/model/dist_matrix_element/dist_matrix_element.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/model/route_config/route_config.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'core_algo_point_system_test.mocks.dart';

@GenerateMocks([DistanceMatrixService])
Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'secrets/secrets.env');
  group('PS1: Single rider tests', () {
    test('PS1.1.1: Assuming rider from Pitogo Lacion to Pacific Mall',
        () async {
      await verifyPoints(
        assumedTravelDistance: 5123,
        assumedTravelTime: 840,
        expectedPoints: 96.306666,
      );
    });
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

  final totalPoints = await coreAlgorithms.calculateDriverPointsFromRider(
    randomConfig,
  );
  expect(
    totalPoints,
    isA<double>().having(
      (tp) {
        return (tp.toStringAsFixed(2) == expectedPoints.toStringAsFixed(2));
      },
      'Actual and expected totalPoints are equal for up to 2 decimal places',
      true,
    ),
  );
}
