import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdateProfile extends StatefulWidget {
  @override
  State<UpdateProfile> createState() => _UpdateProfileScreen();
}

class _UpdateProfileScreen extends State<UpdateProfile> {
  @override
  final currentUser = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();


  Widget build(BuildContext context) {
    final nameEditingController = new TextEditingController();
    final emailEditingController = new TextEditingController();

    final nameField = TextFormField(
      autofocus: false,
      controller: nameEditingController,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your username");
        }
      },
      onSaved: (value) {
        setState(() {
          nameEditingController.text = value!;
        });
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          hintText: "Username",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    final emailField = TextFormField(
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
        // return null;
      },
      onSaved: (value) {
        setState(() {
          emailEditingController.text = value!;

        });

      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    final signupButton = Material(
      elevation: 5,
      color: Colors.yellow,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            try {
              await FirebaseFirestore.instance
                  .collection('user')
                  .doc(currentUser!.uid)
                  .update({
                'name': nameEditingController.text,
                'email': emailEditingController.text
              });
              Navigator.pop(context, true);

            } catch (e) {
              print(e);
            }
          }

        },
        child: Text(
          'Update',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
        title: Text(
          'Update Profile',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Montserrat',
              fontSize: 25.0,
              fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(70),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  nameField,
                  SizedBox(height: 30),
                  emailField,
                  SizedBox(height: 40),
                  signupButton,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
