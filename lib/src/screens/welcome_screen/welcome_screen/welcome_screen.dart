import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sa_foodie/src/screens/login/login_screen.dart';
import 'package:sa_foodie/src/screens/welcome_screen/widget/image.dart';
import 'package:sa_foodie/src/screens/welcome_screen/widget/welcome_button.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
      IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'Quick Search',
            body: 'Set your location to start exploring  restaurants around you',
            image: SizedBox(
                height: 150,
                child: search
            ),
          ),
          PageViewModel(
            title: 'Verity of Food',
            body: 'Set your location to start exploring  restaurants around you',
            image: SizedBox(
                height: 150,
                child: food
            ),
          ),
          PageViewModel(
            title: 'Search for a Place',
            body: 'Set your location to start exploring  restaurants around you',
            image: SizedBox(
                height: 150,
                child: map
            ),
          ),
          PageViewModel(
            title: 'Fast Shipping',
            body: 'Set your location to start exploring  restaurants around you',
            image: SizedBox(
                height: 150,
                child: shipping
            ),
            footer: WelcomeButtom(),
          ),
        ],
        onDone: () => gotoLogin(context),
        showDoneButton: false,
        next: Icon(Icons.arrow_forward),
        dotsDecorator: getDotsDecoration(),
        onChange: (index) => print('Page $index selected'),
        globalBackgroundColor: Colors.yellow,
        animationDuration: 1000,

      ),
    );
  }

  void gotoLogin(context) =>
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => LoginScreen())
      );

  DotsDecorator getDotsDecoration() =>
      DotsDecorator(
        activeColor: Colors.black,
      );
}

