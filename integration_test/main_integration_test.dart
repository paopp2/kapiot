import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kapiot/data/helpers/realtime_db_helper.dart';

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
  RealtimeDbHelper.instance.realtimeDb = FirebaseDatabase(
    databaseURL: 'http://$localHostString:9000?ns=kapiot-46cbc-default-rtdb',
  );

  rider_flow_test.main();
  driver_flow_test.main();
  compatibility_algo_test.main();
}
