import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sa_foodie/src/screens/dashboard/home_screen/home_screen.dart';
import 'package:sa_foodie/src/screens/login/login_screen.dart';
import 'package:sa_foodie/src/screens/signin/signin.dart';
import 'src/screens/splash_screen/splash_screen.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}


class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) =>
     MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );


}

