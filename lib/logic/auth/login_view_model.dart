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

  Future<void> signInWithGoogle() async {
    // Returns credentials when signed in successfully, null if otherwise
    final authCreds = await authService.signInWithGoogle();
    if (authCreds != null) {
      // Ensure shared map state is reset before building the HomeView
      // This is required to avoid errors such as the map's initialCameraPosition
      // is already set before the starting location is retrieved
      MapController.reset(read);
    }
  }
}
