import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sa_foodie/src/screens/dashboard/dashboard.dart';
import 'package:sa_foodie/src/screens/dashboard/profile_screen/list_widget.dart';
import 'package:sa_foodie/src/screens/signin/signin.dart';

import '../../../firebase/firebase_service.dart';
import '../../login/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "";
  String email = "";
  String photoUrl = "";

  void getCurrentUser() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        photoUrl = currentUser.photoURL!;
        name = currentUser.displayName!;
        email = currentUser.email!;
      }
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
              color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          TextButton(onPressed: () {},
              child: Text('Edit'))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100.0),
            photoUrl.isNotEmpty
                ? CircleAvatar(backgroundImage: NetworkImage(photoUrl))
                : const CircleAvatar(
              backgroundImage:
              AssetImage('lib/src/assets/images/profile.jpg'),
            ),
            SizedBox(height: 50),
            Text(name),
            SizedBox(height: 20),
            Text(email),
            BuildList(),


          ],
        ),
      ),
    );
  }

  Widget BuildList() {
    final auth = FirebaseAuth.instance;

    return Flexible(child: ListView.separated(
      padding: EdgeInsets.all(30),
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            ListTile(
              leading: Text('Payment method'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              leading: Text('Invite friend'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              leading: Text('Settings'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
                leading: Text('Logout'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () async {
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

