import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/helpers/firestore_helper.dart';
import 'package:kapiot/data/helpers/firestore_path.dart';
import 'package:kapiot/model/driver_info/driver_info.dart';
import 'package:kapiot/model/kapiot_user_info/kapiot_user_info.dart';

final userInfoRepositoryProvider = Provider.autoDispose(
  (ref) => UserInfoRepository(firestoreHelper: FirestoreHelper.instance),
);

class UserInfoRepository {
  UserInfoRepository({
    required this.firestoreHelper,
  });
  final FirestoreHelper firestoreHelper;

  Future<void> pushUserInfo({
    required String userId,
    required KapiotUserInfo userInfo,
  }) async {
    firestoreHelper.setData(
      path: FirestorePath.docUserInfo(userId),
      data: userInfo.toJson(),
    );
  }

  Stream<KapiotUserInfo?> getUserInfoStream(String userId) {
    return firestoreHelper.documentStream(
      path: FirestorePath.docUserInfo(userId),
      builder: (data, _) => KapiotUserInfo.fromJson(data),
    );
  }

  Stream<DriverInfo?> getDriverInfoStream(String driverId) {
    return firestoreHelper.documentStream(
      path: FirestorePath.docDriverInfo(driverId),
      builder: (data, _) => DriverInfo.fromJson(data),
    );
  }
}
