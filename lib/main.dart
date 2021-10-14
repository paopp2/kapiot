import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/data/helpers/realtime_db_helper.dart';
import 'package:kapiot/root_view.dart';
import 'package:kapiot/ui/auth/login_view.dart';
import 'package:kapiot/ui/home/home_view.dart';
import 'package:kapiot/ui/portal_view.dart';

// TODO: Set to false in production
const bool useFirebaseEmulator = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (useFirebaseEmulator) {
    final localHostString = Platform.isAndroid ? '10.0.2.2' : 'localhost';
    FirebaseFirestore.instance.settings = Settings(
      host: '$localHostString:8080',
      sslEnabled: false,
      persistenceEnabled: false,
    );
    RealtimeDbHelper.instance.realtimeDb = FirebaseDatabase(
      databaseURL: 'http://$localHostString:9000?ns=kapiot-46cbc-default-rtdb',
    );
  }

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter.instance;
    return MaterialApp(
      title: 'Kapiot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: appRouter.navigationKey,
      routes: appRouter.routesList,
      home: RootView(
        loggedInBuilder: (_) => const HomeView(),
        loggedOutBuilder: (_) => const LoginView(),
      ),
      // home: const PortalView(),
    );
  }
}
