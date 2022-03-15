import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sa_foodie/src/screens/login/login_screen.dart';
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
              height: 100,
              child: Image.asset(
                  'lib/src/assets/images/welcome_screen/search.png',
              ),
            ),
          ),
          PageViewModel(
            title: 'Verity of Food',
            body: 'Set your location to start exploring  restaurants around you',
            image: SizedBox(
              height: 100,
              child: Image.asset('lib/src/assets/images/welcome_screen/food.png',
              ),
            ),
          ),
          PageViewModel(
            title: 'Search for a Place',
            body: 'Set your location to start exploring  restaurants around you',
            image: SizedBox(
              height: 100,
              child: Image.asset(
                  'lib/src/assets/images/welcome_screen/map.png',
                height: 190,
                width: 190,
              ),
            ),
          ),
          PageViewModel(
            title: 'Fast Shipping',
            body: 'Set your location to start exploring  restaurants around you',
            image: SizedBox(
              height: 100,
              child: Image.asset(
                  'lib/src/assets/images/welcome_screen/shipping.jpg',
              ),
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
    void gotoLogin(context) => Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => LoginScreen())
    );


  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350,),);
}

DotsDecorator getDotsDecoration() => DotsDecorator(
  //color: Colors.black,
  activeColor: Colors.black,
);

