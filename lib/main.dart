// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kitchen_partners/routes/route_names.dart';
import 'package:kitchen_partners/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'constants/themes.dart';
import 'kitchenpartners_app.dart';
import 'logic/providers/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'modules/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(_setAllProviders()));
}

Widget _setAllProviders() {
  return MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(
        state: AppTheme.getThemeData,
      ),
    ),
  ], child: KPApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kitchen Partners',
      home: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return const Splash();
            } else {
              var _animationController;
              return HomeScreenView(
                animationController: _animationController,
              );
            }
          }),
        ),
      ),
    );
  }
}
