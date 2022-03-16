import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sa_foodie/src/widget/app_bar.dart';
import 'package:sa_foodie/src/widget/text_style.dart';

class ForgotPassword extends StatefulWidget {
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  final TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
        centerTitle: true,
        title: Text('Forgot Password', style: text_style),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(50),
              child: buildTextFormField(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildElevatedButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildElevatedButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(300, 50),
        primary: Colors.yellow,
      ),
      onPressed: () {
        if(_formKey.currentState!.validate())
          auth.sendPasswordResetEmail(email: emailController.text);
        emailController.clear();
        final snackBar = SnackBar(
          duration: Duration(seconds: 1),
          content: const Text(
              'Please check your email for change password'),
          action: SnackBarAction(
            onPressed: () {},
            label: '',
          ),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      },
      child: Text(
        'Submit',
        style: style_text_image,
      ),
    );
  }

  TextFormField buildTextFormField() {
    return TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your email");
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please enter a valid email");
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}
