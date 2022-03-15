import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sa_foodie/src/widget/app_bar.dart';

class ForgotPassword extends StatefulWidget
{
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotPassword>{
  final auth = FirebaseAuth.instance;
  final TextEditingController emailController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
      centerTitle: true,
      title: Text(
        'Forgot Password',
        style: text_style
      ),
      iconTheme: IconThemeData(color: Colors.black),
    ),

      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(50),
          child:  TextFormField(
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
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow,

                ),
                  onPressed: (){
                  if(emailController.text.isEmpty)
                    {
                      print("Please enter email");
                    }
                  else{
                    auth.sendPasswordResetEmail(email: emailController.text);
                    Navigator.of(context).pop();
                  }

                  },
                  child: Text('Submit',
                  style: TextStyle(fontFamily:  'Montserrat',
                  color: Colors.black),),),
            ],
          ),
        ],
      ),

    );
  }



}
