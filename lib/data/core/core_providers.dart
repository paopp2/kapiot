import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/repositories/user_info_repository.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/model/kapiot_user_info/kapiot_user_info.dart';

final fireauthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authStateChangesProvider = StreamProvider<User?>(
    (ref) => ref.watch(fireauthProvider).authStateChanges());

final currentUserProvider = Provider.autoDispose<KapiotUser?>((ref) {
  User? firebaseUser = ref.watch(fireauthProvider).currentUser;
  if (firebaseUser != null) {
    return KapiotUser(
      id: firebaseUser.uid,
      displayName: firebaseUser.displayName,
      email: firebaseUser.email,
      phoneNumber: firebaseUser.phoneNumber,
      photoUrl: firebaseUser.photoURL,
    );
  } else {
    return null;
  }
});

final currentUserInfoProvider = StreamProvider.autoDispose<KapiotUserInfo?>(
  (ref) async* {
    final currentUser = ref.watch(currentUserProvider);
    if (currentUser != null) {
      final userInfoStream = ref
          .watch(userInfoRepositoryProvider)
          .getUserInfoStream(currentUser.id);
      await for (final userInfo in userInfoStream) {
        yield userInfo;
      }
    } else {
      yield null;
    }
  },
);
