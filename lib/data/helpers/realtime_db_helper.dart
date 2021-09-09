import 'package:firebase_database/firebase_database.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';

const realtimeDbUrl =
    "https://kapiot-46cbc-default-rtdb.asia-southeast1.firebasedatabase.app";

class RealtimeDbHelper {
  RealtimeDbHelper._();
  static final instance = RealtimeDbHelper._();
  FirebaseDatabase? realtimeDb;
  late final DatabaseReference dbRef = realtimeDb?.reference() ??
      FirebaseDatabase(databaseURL: realtimeDbUrl).reference();

  Future<void> setData(
      {required String path, required Map<String, dynamic> data}) async {
    dbRef.child(path).set(data);
  }

  // DocumentStream
}
