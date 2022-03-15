import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sa_foodie/src/firebase/firebase_service.dart';
import 'package:sa_foodie/src/model/user_model.dart';
import 'package:sa_foodie/src/screens/dashboard/profile_screen/change_password.dart';
import 'package:sa_foodie/src/screens/dashboard/profile_screen/update_profile.dart';
import 'package:sa_foodie/src/screens/login/login_screen.dart';
import 'package:sa_foodie/src/widget/app_bar.dart';
import 'package:sa_foodie/src/widget/text_style.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ProfileScreen> {

  User? user = FirebaseAuth.instance.currentUser;
  UserModel logedInUser = UserModel();

  void initState(){
    super.initState();
    FirebaseFirestore.instance
    .collection('user')
    .doc(user!.uid)
    .get()
    .then((value){
      this.logedInUser = UserModel.fromMap(value.data());
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfile()));
              },
              child: Text('Edit',
              style: TextStyle(color: Colors.blue,
                  fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 20),),),
        ],
        title: Text(
          'Profile',
          style: text_style),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Padding(
            padding: EdgeInsets.all(20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),

            CircleAvatar(backgroundImage: AssetImage('assets/profile.jpeg'),
            radius: 80,),
            SizedBox(height: 30,),

            Text('${logedInUser.name}',
            style: style_text_image),

            SizedBox(height: 20),
            Text('${logedInUser.email}',
              style: style_text_image),

            SizedBox(height: 30),
            BuildList(),



          ],
        ),
        ),
      ),
    );
  }

Widget BuildList() {
  final auth = FirebaseAuth.instance;

  return Flexible(child: ListView.separated(
    padding: EdgeInsets.only(top: 40,left: 30,right: 30),
    itemCount: 1,
    itemBuilder: (BuildContext context, int index) {
      return Column(
        children: [
          ListTile(
            leading: Text('Invite Friends',style: TextStyle(fontFamily: 'Montserrat',fontSize: 20),),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Text('Change Password',style: TextStyle(fontFamily: 'Montserrat',fontSize: 20)),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () async {await Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword(),),);},
          ),
          ListTile(
            leading: Text('Settings',style: TextStyle(fontFamily: 'Montserrat',fontSize: 20)),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
              leading: Text('Logout',style: TextStyle(fontFamily: 'Montserrat',fontSize: 20)),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                FirebaseService service = FirebaseService();
                await service.signOutFromGoogle();
                await auth.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              }),
        ],
      );
    },
    separatorBuilder: (BuildContext context, int index) {
      return Divider();
    },
  ),
  );
}
}