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
      userType: ref.watch(_currentUserType),
    );
  } else {
    return null;
  }
});

/// Private provider that allows currentUserProvider to listen to changes to
/// currentUserInfoProvider's userType property without having to rebuild when
/// any other property changes
final _currentUserType = Provider.autoDispose<UserType?>((ref) {
  final currentUserType = ref.watch(currentUserInfoProvider).data?.value;
  return currentUserType?.userType;
});

final currentUserInfoProvider = StreamProvider.autoDispose<KapiotUserInfo?>(
  (ref) async* {
    final firebaseUser = ref.watch(fireauthProvider).currentUser;
    if (firebaseUser != null) {
      final userInfoStream = ref
          .watch(userInfoRepositoryProvider)
          .getUserInfoStream(firebaseUser.uid);
      await for (final userInfo in userInfoStream) {
        yield userInfo;
      }
    } else {
      yield null;
    }
  },
);
