import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sa_foodie/constants.dart';
import 'package:sa_foodie/src/screens/dashboard/dashboard.dart';
import 'package:sa_foodie/src/screens/dashboard/home_screen/home_screen.dart';
import 'package:sa_foodie/src/screens/login/login_screen.dart';
import 'package:sa_foodie/src/screens/signin/signin.dart';
import 'package:sa_foodie/src/screens/welcome_screen/welcome_screen/welcome_screen.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 10000));
    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.linear);
    animation = Tween(begin: 0.0, end: 500.0).animate(curve);

    controller.forward();

    startTimer();
  }

  Widget builder(BuildContext context, Widget? child) {
    return Container(
      height: animation.value,
      width: animation.value,
      child: Image.asset('lib/src/assets/images/splash_screen.jpg'),
    );
  }

  dispose() {
    controller.dispose(); // you need this
    super.dispose();
  }

  startTimer() async {
    var duration = Duration(milliseconds: 10000);
    return Timer(duration, loginRoute);
  }

  loginRoute() {
    if (FirebaseAuth.instance.currentUser?.email! != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(32.0),
              child: Center(
                child: AnimatedBuilder(animation: animation, builder: builder),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
