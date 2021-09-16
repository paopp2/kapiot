import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/services/auth_service.dart';
import 'package:kapiot/logic/shared/map_controller.dart';
import 'package:kapiot/logic/shared/view_model.dart';

final loginViewModel = Provider.autoDispose(
  (ref) => LoginViewModel(
    read: ref.read,
    authService: ref.watch(authServiceProvider),
  ),
);

class LoginViewModel extends ViewModel {
  LoginViewModel({
    required Reader read,
    required this.authService,
  }) : super(read);
  final AuthService authService;

  Future<void> signInWithGoogle({
    required BuildContext context,
    required Widget nonUscEmailDialog,
  }) async {
    final authCreds = await authService.signInWithGoogle();
    authCreds.fold(
      // The email used to sign-in is not part of the USC organization
      (notUscEmail) => showDialog(
        context: context,
        builder: (context) => nonUscEmailDialog,
      ),
      // Ensure shared map state is reset before building the HomeView
      // This is required to avoid errors such as the map's initialCameraPosition
      // is already set before the starting location is retrieved
      (creds) {
        // Sign in process may have been aborted by user. In which case,
        // credentials are null
        if (creds != null) MapController.reset(read);
      },
    );
  }
}
