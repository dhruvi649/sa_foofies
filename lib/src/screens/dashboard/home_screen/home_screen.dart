import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:sa_foodie/src/screens/dashboard/home_screen/popular_food.dart';
import 'package:firebase_database/firebase_database.dart';
import 'icrcream.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.yellow[600],
          centerTitle: true,
          title: Text(
            'Welcome to Foodiez',
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(56.0),
            child: Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for delicious food',
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: EdgeInsets.zero,
                  filled: true,
                  fillColor: Colors.white70,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Food',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PopularFood(),
                        ),
                      );
                    },
                    child: const Text(
                      'See all',
                      style: TextStyle(color: Colors.blue, fontSize: 18.0,fontFamily: 'Montserrat'),
                    ),
                  ),
                ],
              ),
              buildScroll(context,currentUser!.uid),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ice Cream',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,fontFamily: 'Montserrat',),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IceCream(),
                        ),
                      );
                    },
                    child: const Text(
                      'See all',
                      style: TextStyle(color: Colors.blue, fontSize: 18.0,fontFamily: 'Montserrat'),
                    ),
                  ),
                ],
              ),
              icecreamList(context, currentUser!.uid),

            ],
          ),
        ),
      ),
    );
  }
}

Widget buildScroll(BuildContext context,String uid) => Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              // padding: EdgeInsets.only(top: 5),
              height: MediaQuery.of(context).size.height * 0.3,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("cuisines")
                    .snapshots(),
                builder: (context, snapshot) {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot cuisines = snapshot.data?.docs[index]
                            as DocumentSnapshot<Object?>;
                        return Card(
                          elevation: 10.0,
                          child: Container(
                            width: 200,
                            height: 200,
                            child: Column(
                              children: [
                                Text(
                                  cuisines['name'],
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                Image.network(
                                  cuisines['img'],
                                  height: 170,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await FirebaseFirestore.instance.collection('user').doc(uid).collection('favourites').add(
                                        {
                                          'name':cuisines['name'],
                                          'img':cuisines['img'],
                                        });
                                  },
                                  icon: Icon(
                                    Icons.favorite_border,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );

Widget icecreamList(BuildContext context, String uid) => Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              // padding: EdgeInsets.only(top: 5),
              height: MediaQuery.of(context).size.height * 0.3,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("icecream")
                    .snapshots(),
                builder: (context, snapshot) {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot icecream = snapshot.data?.docs[index]
                            as DocumentSnapshot<Object?>;
                        return Card(
                          elevation: 10.0,
                          child: Container(
                            width: 200,
                            height: 200,
                            child: Column(
                              children: [
                                Text(
                                  icecream['name'],
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                Image.network(
                                  icecream['img'],
                                  height: 170,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                IconButton(
                                  icon: Icon(Icons.favorite_border),
                                  onPressed: () async {
                                    await FirebaseFirestore.instance.collection('user').doc(uid).collection('favourites').add(
                                        {
                                          'name':icecream['name'],
                                          'img':icecream['img'],
                                        });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );

