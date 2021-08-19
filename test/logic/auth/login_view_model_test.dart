import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/data/services/auth_service.dart';
import 'package:kapiot/logic/auth/login_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'login_view_model_test.mocks.dart';

@GenerateMocks([AppRouter, AuthService])
void main() {
  group("signInWithGoogle:", () {
    test("verify AuthService signInWithGoogle() method gets called", () {
      final mockAuthService = MockAuthService();
      when(mockAuthService.signInWithGoogle()).thenAnswer((_) async => null);
      final container = ProviderContainer(overrides: [
        loginViewModel.overrideWithProvider(
          Provider.autoDispose(
            (ref) => LoginViewModel(
              read: ref.read,
              authService: mockAuthService,
            ),
          ),
        )
      ]);
      container.read(loginViewModel).signInWithGoogle();
      verify(mockAuthService.signInWithGoogle()).called(1);
    });
  });
}
