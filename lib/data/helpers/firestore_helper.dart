import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static final instance = FirestoreHelper._();
  StreamSubscription? _colStreamSub;
  StreamSubscription? _docStreamSub;

  void cancelStreams() {
    _colStreamSub?.cancel();
    _docStreamSub?.cancel();
  }

  Future<T> getData<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
  }) async {
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);
    final DocumentSnapshot snapshot = await reference.get();
    return builder(snapshot.data() as Map<String, dynamic>, snapshot.id);
  }

  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(data, SetOptions(merge: merge));
  }

  Future<void> deleteData({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.delete();
  }

  Future<void> moveData({
    required String sourcePath,
    required String destPath,
  }) async {
    final doc = await getData(
      path: sourcePath,
      builder: (data, _) => data,
    );
    await setData(
      path: destPath,
      data: doc,
    );
    await deleteData(path: sourcePath);
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    final streamController = StreamController<List<T>>();
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    _colStreamSub = snapshots.listen((snapshot) {
      final result = snapshot.docs
          .map((snapshot) =>
              builder(snapshot.data() as Map<String, dynamic>, snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      streamController.add(result);
    }, cancelOnError: true);
    streamController.onCancel = streamController.close;
    return streamController.stream;
  }

  Stream<T?> documentStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
  }) {
    final streamController = StreamController<T?>();
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();
    _docStreamSub = snapshots.listen((snapshot) {
      final data = snapshot.data();
      if (data != null) {
        streamController.add(builder(
          snapshot.data() as Map<String, dynamic>,
          snapshot.id,
        ));
      } else {
        streamController.add(null);
      }
    }, cancelOnError: true);
    streamController.onCancel = streamController.close;
    return streamController.stream;
  }

  Future<List<T>> collectionToList<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final Future<QuerySnapshot> snapshots = query.get();
    return snapshots.then((snapshot) {
      final result = snapshot.docs
          .map((snapshot) =>
              builder(snapshot.data() as Map<String, dynamic>, snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }
}
