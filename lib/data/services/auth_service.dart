import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core_providers/firebase_providers.dart';

final authServiceProvider = Provider.autoDispose(
  (ref) => AuthService(
    ref.read,
    GoogleSignIn(),
  ),
);

class AuthService {
  AuthService(this.read, this.googleSignIn);
  final Reader read;
  final GoogleSignIn googleSignIn;

  Future<UserCredential?> signInWithGoogle() async {
    AuthCredential? googleAuthCreds = await googleCredentials();
    if (googleAuthCreds == null) {
      return null;
    }
    final signedInUserCreds =
        await read(fireauthProvider).signInWithCredential(googleAuthCreds);
    return signedInUserCreds;
  }

  Future<void> signOutGoogle() async {
    try {
      await googleSignIn.disconnect();
    } catch (e) {
      print(e);
    }
    await googleSignIn.signOut();
    await read(fireauthProvider).signOut();
  }

  //TODO: Revert back to checking for USC email
  Future<AuthCredential?> googleCredentials() async {
    try {
      final googleSignInAcc = await googleSignIn.signIn();
      final googleSignInAuth = await googleSignInAcc?.authentication;
      // if (googleSignInAcc!.email.split("@")[1] == 'usc.edu.ph') {
      //   return GoogleAuthProvider.credential(
      //     accessToken: googleSignInAuth?.accessToken,
      //     idToken: googleSignInAuth?.idToken,
      //   );
      // } else {
      //   signOutGoogle();
      //   throw Exception('Not USC Email');
      // }
      return GoogleAuthProvider.credential(
        accessToken: googleSignInAuth?.accessToken,
        idToken: googleSignInAuth?.idToken,
      );
    } catch (e) {
      print(e);
      return null;
    }
  }
}
