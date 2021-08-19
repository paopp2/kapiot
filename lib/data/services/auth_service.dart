import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authServiceProvider = Provider.autoDispose(
  (ref) => AuthService(
    ref.read,
    GoogleSignIn(),
  ),
);

// TODO: Add firebaseauth provider
class AuthService {
  AuthService(this.read, this.googleSignIn);
  final Reader read;
  final GoogleSignIn googleSignIn;

  Future<UserCredential?> signInWithGoogle() async {
    AuthCredential? googleAuthCreds = await _googleCredentials();
    if (googleAuthCreds == null) {
      return null;
    }
    final signedInUserCreds =
        await read(fireauthProvider).signInWithCredential(googleAuthCreds);
    return signedInUserCreds;
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
    await read(fireauthProvider).signOut();
  }

  Future<AuthCredential?> _googleCredentials() async {
    try {
      final googleSignInAcc = await googleSignIn.signIn();
      final googleSignInAuth = await googleSignInAcc?.authentication;
      if (googleSignInAcc!.email.split("@")[1] == 'usc.edu.ph') {
        return GoogleAuthProvider.credential(
          accessToken: googleSignInAuth?.accessToken,
          idToken: googleSignInAuth?.idToken,
        );
      } else {
        signOutGoogle();
        throw Exception('Not USC Email');
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
