import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core_providers/firebase_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

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
