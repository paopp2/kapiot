import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final fireauthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
