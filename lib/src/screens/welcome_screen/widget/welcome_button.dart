import 'package:flutter/material.dart';
import 'package:sa_foodie/src/screens/login/login_screen.dart';

class WelcomeButtom extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen(),),);
        },
        child: Text('Login',
        style: TextStyle(color: Colors.black),),
        style: ElevatedButton.styleFrom(primary: Colors.white),);
  }

}