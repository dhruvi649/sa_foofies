import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:sa_foodie/src/screens/dashboard/home_screen/popular_food.dart';
import 'package:sa_foodie/src/widget/app_bar.dart';
import 'package:sa_foodie/src/widget/text_style.dart';
import '../../review/review_screen.dart';
import 'icrcream.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final currentUser = FirebaseAuth.instance.currentUser;
  DateTime pre_backpress = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= Duration(seconds: 2);
        pre_backpress = DateTime.now();
        if (cantExit) {
          final snack = SnackBar(
            content: Text('Press Back button again to Exit'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow[600],
          centerTitle: true,
          title: Text('Welcome to Foodiez', style: text_style),
          automaticallyImplyLeading: false,
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
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Popular Food',
                      style: buildTextStyle(),
                    ),
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
                    child: Text(
                      'See all',
                      style: buildTextStyleSeeAll(),
                    ),
                  ),
                ],
              ),
              buildScroll(context, currentUser!.uid),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Ice Cream',
                      style: buildTextStyle(),
                    ),
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
                    child: Text(
                      'See all',
                      style: buildTextStyleSeeAll(),
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

  TextStyle buildTextStyleSeeAll() {
    return TextStyle(
        color: Colors.blue, fontSize: 18.0, fontFamily: 'Montserrat');
  }

  TextStyle buildTextStyle() {
    return TextStyle(
        fontFamily: 'Montserrat',
        color: Colors.black,
        fontSize: 25.0,
        fontWeight: FontWeight.bold);
  }
}

Widget buildScroll(BuildContext context, String uid) => Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("cuisines")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot cuisines = snapshot.data?.docs[index]
                            as DocumentSnapshot<Object?>;
                        return Card(
                            elevation: 10.0,
                            child: GestureDetector(
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReviewScreen(
                                        name: cuisines['name'],
                                        img: cuisines['img']),
                                  ),
                                );
                              },
                              child: Container(
                                width: 200,
                                height: 200,
                                child: Column(
                                  children: [
                                    Text(cuisines['name'],
                                        style: style_text_image),
                                    Image.network(
                                      cuisines['img'],
                                      height: 170,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection('user')
                                            .doc(uid)
                                            .collection('favourites')
                                            .add({
                                          'category':cuisines['category'],
                                          'name': cuisines['name'],
                                          'img': cuisines['img'],
                                        });
                                        final snackBar = SnackBar(
                                          duration: Duration(seconds: 1),
                                          content: const Text(
                                              'Item added to favorite!'),
                                          action: SnackBarAction(
                                            onPressed: () {},
                                            label: '',
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      },
                                      icon: Icon(
                                        Icons.favorite_border,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ));
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
              height: MediaQuery.of(context).size.height * 0.3,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("icecream")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot icecream = snapshot.data?.docs[index]
                            as DocumentSnapshot<Object?>;
                        return Card(
                            elevation: 10.0,
                            child: GestureDetector(
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReviewScreen(
                                        name: icecream['name'],
                                        img: icecream['img']),
                                  ),
                                );
                              },
                              child: Container(
                                width: 200,
                                height: 200,
                                child: Column(
                                  children: [
                                    Text(icecream['name'],
                                        style: style_text_image),
                                    Image.network(
                                      icecream['img'],
                                      height: 170,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.favorite_border),
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection('user')
                                            .doc(uid)
                                            .collection('favourites')
                                            .add({
                                          'category': icecream['category'],
                                          'name': icecream['name'],
                                          'img': icecream['img'],
                                        });
                                        final snackBar = SnackBar(
                                          duration: Duration(seconds: 1),
                                          content: const Text(
                                              'Item added to favorite!'),
                                          action: SnackBarAction(
                                            onPressed: () {},
                                            label: '',
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
