import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/services/auth_service.dart';

final homeViewModel = Provider.autoDispose((ref) => HomeViewModel(
      read: ref.read,
      authService: ref.watch(authServiceProvider),
    ));

class HomeViewModel {
  HomeViewModel({required this.read, required this.authService});
  final Reader read;
  final AuthService authService;

  void initState() {}
  Future<void> signOut() async => await authService.signOutGoogle();
  void dispose() {}
}
