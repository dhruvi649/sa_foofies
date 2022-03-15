import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sa_foodie/src/screens/dashboard/dashboard.dart';
import 'package:sa_foodie/src/screens/forgot_password/forgot_password.dart';
import 'package:sa_foodie/src/screens/signin/signin.dart';
import 'package:sa_foodie/src/firebase/firebase_service.dart';

import '../../../constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    final emailField = TextFormField(
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
    );


    final passwordField = TextFormField(
      autofocus: false,
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
      obscureText: _isObscure,
      onSaved: (value) {
        passwordController.text = value!;
      },
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
    );

    final loginButton = Material(
      elevation: 5,
      color: Colors.yellow,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery
            .of(context)
            .size
            .width,
        onPressed: () {
         signIn(emailController.text, passwordController.text);
        },
        child: Text('Login', style: TextStyle(
          fontSize: 20.0,
          fontFamily: 'Montserrat',
          color: Colors.black,
        ),),),
    );

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(36),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 80,
                    ),
                Text('Login', style: TextStyle(color: Colors.black,
                    fontSize: 30, fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),),
                  SizedBox(height: 90),
                    emailField,
                    SizedBox(height: 25),
                    passwordField,
                    SizedBox(height: 25),
                    TextButton(
                        onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => ForgotPassword()));
                        },
                        child: Text('Forgot Password?',
                        style: TextStyle(color: Colors.blue,
                        fontFamily: 'Montserrat',
                        fontSize: 15),)),
                    SizedBox(height: 25,),
                    loginButton,
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.yellow,
                          fixedSize: const Size(320, 50)),
                      onPressed: () async {
                        FirebaseService service = FirebaseService();
                        try {
                          await service.signInWithGoogle();
                          navigateScreen(context, Dashboard());
                        } catch (e) {
                          if (e is FirebaseAuthException) {
                            showMessage(context, e.message!);
                          }
                        }
                      },
                      child: Text(
                        'Sign up with google',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Dont have an account?',
                        style: TextStyle(fontFamily: 'Montserrat' ),),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => SigninScreen()));
                          },
                          child: Text('SignUp', style: TextStyle(
                            fontSize: 15, color: Colors.blue,
                            fontFamily: 'Montserrat'
                          ),),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
          await _auth.signInWithEmailAndPassword(email: email, password: password)
              .then((uid) => {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Dashboard())),

          });
    }
  }
}
