import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:integration_test/integration_test.dart';

import 'rider_flow_test.dart' as rider_flow_test;
import 'driver_flow_test.dart' as driver_flow_test;
import 'compatibility_algo_test.dart' as compatibility_algo_test;

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final localHostString = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  FirebaseFirestore.instance.settings = Settings(
    host: '$localHostString:8080',
    sslEnabled: false,
    persistenceEnabled: false,
  );

  rider_flow_test.main();
  // driver_flow_test.main();
  compatibility_algo_test.main();
}
