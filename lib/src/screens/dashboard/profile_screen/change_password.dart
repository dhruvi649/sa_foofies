import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sa_foodie/src/screens/login/login_screen.dart';

class ChangePassword extends StatefulWidget {
  @override
  State<ChangePassword> createState() => _ChangePasswordScreen();
}

class _ChangePasswordScreen extends State<ChangePassword> {
  @override
  final currentUser = FirebaseAuth.instance.currentUser;
  var newPassword ="";

  Widget build(BuildContext context) {
    final passwordController = new TextEditingController();

    final passwordField = TextFormField(
      controller: passwordController,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Please enter your password");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter valid password(Minimum 6 character)");
        }
      },
      obscureText: true,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
      onFieldSubmitted: (value){
        setState(() {
          newPassword = passwordController.text;
        });
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
        title: Text('Change Password',
          style: TextStyle(color: Colors.black,
              fontFamily: 'Montserrat',
              fontSize: 25.0,
              fontWeight: FontWeight.bold),),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(padding: EdgeInsets.all(70),
        child: Center(
          child: Column(
            children: [
              passwordField,
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.yellow),
                  onPressed: () async{
                    await currentUser!.updatePassword(newPassword)
                        .then((_){
                      print("Successfully changed");
                    } );
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));

                  },
                  child: Text('Submit', style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20.0,
                    color: Colors.black,
                  ),),),
            ],
          ),
        ),
      ),
    );
  }
  
//   changePassword() async{
//     try{
//       await currentUser!.updatePassword(newPassword);
//       FirebaseAuth.instance.signOut();
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
//     }catch(e){}
//   }
//
 }