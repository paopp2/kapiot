import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/data/services/auth_service.dart';

final loginViewModel = Provider.autoDispose((ref) => LoginViewModel(
      read: ref.read,
      authService: ref.watch(authServiceProvider),
    ));

class LoginViewModel {
  LoginViewModel({required this.read, required this.authService});
  final Reader read;
  final AuthService authService;

  void initState() {}
  Future<void> signInWithGoogle() async => await authService.signInWithGoogle();
  void dispose() {}
}
