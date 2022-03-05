import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sa_foodie/src/screens/dashboard/dashboard.dart';

class ForgotPassword extends StatefulWidget
{
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotPassword>{

  late String _email;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
      centerTitle: true,
      title: Text(
        'Forgot Password',
        style: TextStyle(
            fontFamily:  'Montserrat',
            color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold),
      ),
      iconTheme: IconThemeData(color: Colors.black),
    ),

      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(50),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Email",),
            onChanged: (value){
              setState(() {
                _email = value;
              });
            },
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
                    auth.sendPasswordResetEmail(email: _email);
                    Navigator.of(context).pop();
                  },
                  child: Text('Submit',
                  style: TextStyle(fontFamily:  'Montserrat'),),),
            ],
          ),
        ],
      ),

    );
  }



}
