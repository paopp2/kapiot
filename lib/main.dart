import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/root_view.dart';
import 'package:kapiot/ui/auth/login_view.dart';
import 'package:kapiot/ui/home/home_view.dart';
import 'package:kapiot/ui/portal_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appRouter = AppRouter.instance;
    return MaterialApp(
        title: 'Kapiot',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: _appRouter.navigationKey,
        routes: _appRouter.routesList,
        home: PortalView()
        //  RootView(
        //   loggedInBuilder: (_) => const HomeView(),
        //   loggedOutBuilder: (_) => const LoginView(),
        // ),
        );
  }
}
