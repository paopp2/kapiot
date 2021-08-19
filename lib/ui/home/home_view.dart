import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/home/home_view_model.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(homeViewModel);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Container(
            color: Colors.amber,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(18.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  // icon: const Icon(FontAwesomeIcons.google),
                  icon: const Icon(Icons.exit_to_app_outlined),
                  label: const Text('Sign Out'),
                  onPressed: model.signOut,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
