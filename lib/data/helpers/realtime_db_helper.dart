import 'package:firebase_database/firebase_database.dart';

const realtimeDbUrl =
    "https://kapiot-46cbc-default-rtdb.asia-southeast1.firebasedatabase.app";

class RealtimeDbHelper {
  RealtimeDbHelper._();
  static final instance = RealtimeDbHelper._();
  FirebaseDatabase? realtimeDb;
  late final DatabaseReference dbRef = realtimeDb?.reference() ??
      FirebaseDatabase(databaseURL: realtimeDbUrl).reference();

  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    dbRef.child(path).set(data);
  }

  Stream<T> documentStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data) builder,
  }) {
    // Filter stream (sometimes Firebase RTDB emits null events)
    final Stream<Event> events =
        dbRef.child(path).onValue.where((e) => (e.snapshot.value != null));
    // Remap values at event stream into JSON (Map) data
    final Stream<Map<String, dynamic>> snapshots = events.map(
      (e) => (Map<String, dynamic>.from(e.snapshot.value)),
    );
    return snapshots.map((snapshot) => builder(snapshot));
  }
}
