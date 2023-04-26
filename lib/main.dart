import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_level_up/app_routers/routers.dart';
import 'package:firestore_level_up/firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const FireStoreLearnApp());
}

class FireStoreLearnApp extends StatelessWidget {
  const FireStoreLearnApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: appRouter.routeInformationParser,
      routerDelegate: appRouter.routerDelegate,
      title: 'FireStoreLevelUp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
