import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SeeReviews extends StatefulWidget {
  final String name;

  const SeeReviews({Key? key, required this.name}) : super(key: key);

  @override
  _SeeReviewsState createState() => _SeeReviewsState();
}

class _SeeReviewsState extends State<SeeReviews> {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
        centerTitle: true,
        title: const Text(
          'See All Reviews',
          style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.black,
              fontSize: 25.0,
              fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('reviews').where('itemName', isEqualTo: widget.name).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final reviews = snapshot.data?.docs;
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: reviews?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Card(
                      elevation: 10.0,
                      child: Container(
                        width: 400,
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Text(
                                reviews![index]['user'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                reviews[index]['review'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
