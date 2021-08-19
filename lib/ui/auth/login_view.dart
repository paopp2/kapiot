import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/auth/login_view_model.dart';

class LoginView extends HookConsumerWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(loginViewModel);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            label: const Text("Go to HomeView"),
            onPressed: model.gotoHomeView,
          ),
          body: Container(
            color: Colors.green,
          ),
        );
      },
    );
  }
}
