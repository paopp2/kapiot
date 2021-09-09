import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core_providers/auth_providers.dart';
import 'package:kapiot/logic/home/home_view_model.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/ui/home/components/route_config_panel.dart';
import 'package:kapiot/ui/shared/kapiot_sliding_panel.dart';
import 'components/home_view_map.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(context, ref) {
    final model = ref.watch(homeViewModel);
    final currentUser = ref.watch(currentUserProvider);
    final resetKey = ref.watch(resetKeyProvider).state;

    useEffect(() {
      model.initState();
      return model.dispose;
    }, [resetKey]);

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              leading: Container(
                margin: const EdgeInsets.only(top: 10, left: 10),
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: const Color(0xffffc901),
                  backgroundImage: NetworkImage(currentUser?.photoUrl ?? ''),
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.only(top: 10, right: 10),
                  decoration: BoxDecoration(
                    color: const Color(0x5f808080),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.logout, color: Colors.white),
                    onPressed: model.signOut,
                  ),
                )
              ],
            ),
            body: KapiotSlidingPanel(
              constraints: constraints,
              title: "Route Configuration",
              map: HomeViewMap(model: model),
              panel: RouteConfigPanel(
                constraints: constraints,
                model: model,
              ),
            ),
          );
        },
      ),
    );
  }
}
