import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/home/home_view_model.dart';
import 'package:kapiot/logic/home/home_view_state.dart';

import 'components/google_map_section.dart';
import 'components/loading_screen.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(homeViewModelProvider);
    final currentLoc = ref.watch(currentLocationProvider).state;

    useEffect(() {
      model.initState();
      return model.dispose;
    }, []);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: model.signOut,
              )
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            label: const Text("Go to Lake"),
            onPressed: model.gotoLake,
          ),
          body: (currentLoc == null)
              ? const LoadingScreen(text: "Fetching current location...")
              : GoogleMapSection(model),
        );
      },
    );
  }
}
