import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/services/auth_service.dart';
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

  Future<void> signInWithGoogle() async => await authService.signInWithGoogle();
}
