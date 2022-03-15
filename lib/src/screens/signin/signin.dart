import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sa_foodie/src/model/user_model.dart';
import 'package:sa_foodie/src/screens/dashboard/dashboard.dart';
import 'package:sa_foodie/src/screens/login/login_screen.dart';
import 'package:sa_foodie/src/widget/text_style.dart';

import '../../../constants.dart';
import '../../firebase/firebase_service.dart';

class SigninScreen extends StatefulWidget {
  @override
  State<SigninScreen> createState() => SigninScreenState();
}

class SigninScreenState extends State<SigninScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isObscure = true;


  final _formKey = GlobalKey<FormState>();
  final nameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      height: 70,
                    ),
                    Text(
                      'Welcome to Foodies',
                      style: textLogin
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Create your account',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                          fontSize: 15),
                    ),
                    SizedBox(height: 50),
                    buildTextFormFieldUname(),
                    SizedBox(height: 25),
                    buildTextFormFieldEmail(),
                    SizedBox(height: 25),
                    buildTextFormFieldPassword(),
                    SizedBox(height: 25),
                    buildMaterial(context),
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
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue,
                              fontFamily: 'Montserrat',
                            ),
                          ),
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

  Material buildMaterial(BuildContext context) {
    return Material(
    elevation: 5,
    color: Colors.yellow,
    borderRadius: BorderRadius.circular(30),
    child: MaterialButton(
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      minWidth: MediaQuery.of(context).size.width,
      onPressed: () {
        SignUp(emailEditingController.text, passwordEditingController.text);
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
      },
      child: Text(
        'SignUp',
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 20.0,
          color: Colors.black,
        ),
      ),
    ),
  );
  }

  TextFormField buildTextFormFieldPassword() {
    return TextFormField(
    autofocus: false,
    controller: passwordEditingController,
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
      passwordEditingController.text = value!;
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
  }

  TextFormField buildTextFormFieldEmail() {
    return TextFormField(
    autofocus: false,
    controller: emailEditingController,
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
      emailEditingController.text = value!;
    },
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )),
  );
  }

  TextFormField buildTextFormFieldUname() {
    return TextFormField(
    autofocus: false,
    controller: nameEditingController,
    validator: (value){
      if(value!.isEmpty){
        return ("Please enter your username");
      }
    },
    onSaved: (value) {
      nameEditingController.text = value!;
    },
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
        hintText: "Username",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )),
  );
  }

  void SignUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                postDetailsToFirestore(),
              });
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = nameEditingController.text;
    userModel.password = passwordEditingController.text;

    await firebaseFirestore
        .collection("user")
        .doc(user.uid)
        .set(userModel.toMap());

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => Dashboard()), (route) => false);
  }
}
