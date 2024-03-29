import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core/core_providers.dart';

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

  Future<Either<Exception, UserCredential?>> signInWithUscEmail() async {
    try {
      final googleSignInAcc = await getGoogleSignInAcc();
      if (googleSignInAcc != null) {
        final googleAuthCreds = await uscAuthCredentials(googleSignInAcc);
        final signedInUserCreds =
            await read(fireauthProvider).signInWithCredential(googleAuthCreds);
        return Right(signedInUserCreds);
      } else {
        // Cancelled sign-in
        return const Right(null);
      }
    } catch (e) {
      return Left(e as Exception);
    }
  }

  Future<GoogleSignInAccount?> getGoogleSignInAcc() async {
    return await googleSignIn.signIn();
  }

  Future<AuthCredential> uscAuthCredentials(
    GoogleSignInAccount googleSignInAcc,
  ) async {
    if (googleSignInAcc.email.split("@")[1] == 'usc.edu.ph') {
      final googleSignInAuth = await googleSignInAcc.authentication;
      return GoogleAuthProvider.credential(
        accessToken: googleSignInAuth.accessToken,
        idToken: googleSignInAuth.idToken,
      );
    } else {
      signOutGoogle();
      throw Exception('Not USC Email');
    }
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
    await read(fireauthProvider).signOut();
  }
}
