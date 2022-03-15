import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sa_foodie/src/widget/app_bar.dart';

class ChangePassword extends StatefulWidget {
  @override
  State<ChangePassword> createState() => _ChangePasswordScreen();
}

class _ChangePasswordScreen extends State<ChangePassword> {
  @override
  final currentUser = FirebaseAuth.instance.currentUser;
  final passwordController = new TextEditingController();
  var newPassword = "";
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
        title: Text('Change Password', style: text_style),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(70),
          child: Center(
            child: Column(
              children: [
                buildTextFormFieldPassword(),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.yellow, fixedSize: Size(250, 50)),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await currentUser!
                          .updatePassword(passwordController.text);
                      Navigator.pop(context);
                    }
                    final snackBar = SnackBar(
                      duration: Duration(seconds: 1),
                      content: const Text('Password changed successfully!'),
                      action: SnackBarAction(
                        onPressed: () {},
                        label: '',
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildTextFormFieldPassword() {
    return TextFormField(
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
  }
}
