import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';

final loginViewModel = Provider.autoDispose((ref) => LoginViewModel(ref.read));

class LoginViewModel {
  LoginViewModel(this.read);
  final Reader read;

  void gotoHomeView() => AppRouter.instance.navigateTo(Routes.homeView);
}
