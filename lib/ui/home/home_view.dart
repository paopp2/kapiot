import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/home/home_view_model.dart';
import 'package:kapiot/logic/home/home_view_state.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(homeViewModelProvider);
    final startLocation = ref.watch(startLocationProvider).state;

    useEffect(() {
      model.initState();
      return model.dispose;
    }, []);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: model.goToGwapoHouse,
            label: const Text('Balay sa gwapo 😎'),
          ),
          body: (startLocation == null)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      Text("Fetching current location..."),
                    ],
                  ),
                )
              : GoogleMap(
                  mapType: MapType.hybrid,
                  initialCameraPosition: model.initialPosition,
                  onMapCreated: model.onMapCreated,
                ),
        );
      },
    );
  }
}
