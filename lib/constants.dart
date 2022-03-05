import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sa_foodie/src/firebase/firebase_service.dart';
import 'package:sa_foodie/src/screens/signin/signin.dart';

const loginTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 25.0,
  fontWeight: FontWeight.bold,

);

const forgotPassword = TextStyle(
  color: Colors.blue,
  fontSize: 15.0,
);

Future navigateScreen(context, screen) {
  return Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

Future<void> logoutFromApp(context) async {
  FirebaseService service = FirebaseService();
  try {
    await service.signOutFromGoogle();
    navigateScreen(context, SigninScreen());
  } catch (e) {
    if (e is FirebaseAuthException) {
      showMessage(context, e.message!);
    }
  }
}

void showMessage(context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            child: const Text("Ok"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}