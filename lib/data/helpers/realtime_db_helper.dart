import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

const realtimeDbUrl =
    "https://kapiot-46cbc-default-rtdb.asia-southeast1.firebasedatabase.app";

class RealtimeDbHelper {
  RealtimeDbHelper._();
  static final instance = RealtimeDbHelper._();
  FirebaseDatabase? realtimeDb;
  late final DatabaseReference dbRef = realtimeDb?.reference() ??
      FirebaseDatabase(databaseURL: realtimeDbUrl).reference();
  StreamSubscription? _colStreamSub;
  StreamSubscription? _docStreamSub;

  void cancelStreams() {
    _colStreamSub?.cancel();
    _docStreamSub?.cancel();
  }

  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    dbRef.child(path).set(data);
  }

  Future<void> deleteData({required String path}) async {
    dbRef.child(path).remove();
  }

  Stream<T> documentStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data) builder,
  }) {
    final streamController = StreamController<T>();
    // Filter stream (sometimes Firebase RTDB emits null events)
    final Stream<Event> events =
        dbRef.child(path).onValue.where((e) => (e.snapshot.value != null));
    // Remap values at event stream into JSON (Map) data
    final Stream<Map<String, dynamic>> snapshots = events.map(
      (e) => (Map<String, dynamic>.from(e.snapshot.value)),
    );
    _docStreamSub = snapshots.listen((snapshot) {
      streamController.add(builder(snapshot));
    }, cancelOnError: true);
    streamController.onCancel = streamController.close;
    return streamController.stream;
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
    List<String>? keysOfDocsToGet,
  }) {
    final streamController = StreamController<List<T>>();
    // Filter stream (sometimes Firebase RTDB emits null events)
    final Stream<Event> events =
        dbRef.child(path).onValue.where((e) => (e.snapshot.value != null));
    // Remap values at event stream into JSON (Map) data
    var snapshots =
        events.map((e) => Map<String, dynamic>.from(e.snapshot.value));
    // If keys of docs to get is specified, filter snapshots stream to only
    // return those with keys included in the list
    if (keysOfDocsToGet != null) {
      snapshots = snapshots.map((event) {
        final tempMap = event;
        tempMap.removeWhere((key, value) => !(keysOfDocsToGet.contains(key)));
        return tempMap;
      });
    }
    // Convert into a Stream of list of all retrieved 'documents' as JSON,
    // also passing their docID to the builder callback
    _colStreamSub = snapshots.listen((snapshot) {
      final List<T> tList = [];
      snapshot.forEach(
        (key, value) => tList.add(builder(
          Map<String, dynamic>.from(value), // JSON document data
          key, // document ID
        )),
      );
      streamController.add(tList);
    }, cancelOnError: true);
    streamController.onCancel = streamController.close;
    return streamController.stream;
  }
}
