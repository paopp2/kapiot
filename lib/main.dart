import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/ui/auth/login_view.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
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
      home: const LoginView(),
    );
  }
}
