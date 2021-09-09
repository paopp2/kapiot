import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';

const realtimeDbUrl =
    "https://kapiot-46cbc-default-rtdb.asia-southeast1.firebasedatabase.app";

class RealtimeDbHelper {
  RealtimeDbHelper._();
  static final instance = RealtimeDbHelper._();
  FirebaseDatabase? realtimeDb;
  late final DatabaseReference dbRef = realtimeDb?.reference() ??
      FirebaseDatabase(databaseURL: realtimeDbUrl).reference();

  Future<void> setData(String path, Map<String, dynamic> data) async {
    dbRef.child(path).set(data);
  }

  // Stream<T> documentStream<T>({
  //   required String path,
  //   // required T Function(Map<String, dynamic> data, String documentID) builder,
  // }) {
  //   final ref = dbRef.child(path).onValue();

  //   // final Stream<DataSnapshot> snapshots = Stream.fromFuture(dataSnapshot);
  //   // return snapshots.map((snapshot) =>
  //   //     builder(snapshot.key as Map<String, dynamic>, snapshot.value));
  // }
  // DocumentStream

  Stream<Event> documentStream() {
    return dbRef.child('trial/path/').onValue;
  }
}
