import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core_providers/firebase_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';

final authStateChangesProvider = StreamProvider<User?>(
    (ref) => ref.watch(fireauthProvider).authStateChanges());

// TODO: Create currentUserProvider 

