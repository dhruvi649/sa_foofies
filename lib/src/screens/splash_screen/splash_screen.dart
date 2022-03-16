import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sa_foodie/src/screens/dashboard/dashboard.dart';
import 'package:sa_foodie/src/screens/welcome_screen/welcome_screen/welcome_screen.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 7000));
    // final CurvedAnimation curve =
    //     CurvedAnimation(parent: controller, curve: Curves.elasticOut);
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.elasticOut,
    );

    controller.forward();

    startTimer();
  }

  Widget builder(BuildContext context, Widget? child) {
    return RotationTransition(
      turns: animation,
      child: Image.asset('assets/splash_screen.png'),
    );
  }

  dispose() {
    controller.dispose(); // you need this
    super.dispose();
  }

  startTimer() async {
    var duration = Duration(milliseconds: 3000);
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
