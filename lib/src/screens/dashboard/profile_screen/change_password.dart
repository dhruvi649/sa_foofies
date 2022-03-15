import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sa_foodie/src/screens/login/login_screen.dart';

class ChangePassword extends StatefulWidget {
  @override
  State<ChangePassword> createState() => _ChangePasswordScreen();
}

class _ChangePasswordScreen extends State<ChangePassword> {
  @override
  final currentUser = FirebaseAuth.instance.currentUser;    final passwordController = new TextEditingController();

  var newPassword = "";
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();


  Widget build(BuildContext context) {

    final passwordField = TextFormField(
      controller: passwordController,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Please enter your password");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter valid password(Minimum 6 character)");
        }
        return null;
      },
      obscureText: _isObscure,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: IconButton(
            icon: Icon(
              _isObscure ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            }),
      ),
      // onSaved: (value) {
      //   newPassword = passwordController.text;
      // },
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
      body: Form(
        key: _formKey,
        child: Padding(padding: EdgeInsets.all(70),
          child: Center(
            child: Column(
              children: [
                passwordField,
                SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.yellow),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await currentUser!.updatePassword(passwordController.text);
                      Navigator.pop(context);
                    }
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
      ),
    );
  }
}
  
