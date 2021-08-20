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
        final mh = constraints.maxHeight;
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: model.signOut,
              )
            ],
          ),
          body: Stack(
            children: [
              (currentLoc == null)
                  ? const LoadingScreen(text: "Fetching current location...")
                  : GoogleMapSection(model),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Container(
                  height: mh * 0.4,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TextField(),
                        const TextField(),
                        TextButton(
                          child: const Text("Date picker"),
                          onPressed: () => showDatePicker(
                            context: context,
                            firstDate: DateTime(1970),
                            lastDate: DateTime(2050),
                            initialDate: DateTime.now(),
                          ),
                        ),
                        ElevatedButton(
                          child: const Text("Go to Lake"),
                          onPressed: model.gotoLake,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
