import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  final currentUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
        centerTitle: true,
        title: Text(
          'Favorite',
          style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.black,
              fontSize: 25.0,
              fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: FoodList(context, currentUser!.uid),
      ),
    );
  }

  Widget FoodList(BuildContext context, String uid) => Container(
        child: Container(
          //padding: EdgeInsets.only(top: 10),
          //height: MediaQuery.of(context).size.height * 0.2,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('user')
                .doc(uid)
                .collection('favourites')
                .snapshots(),
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    final food_list = snapshot.data?.docs[index];
                    return Card(
                      elevation: 10.0,
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Column(
                          children: [
                            Text(
                              food_list!['name'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  fontFamily: 'Montserrat'),
                            ),
                            Image.network(
                              food_list['img'],
                              height: 120,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                            IconButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('user')
                                      .doc(uid)
                                      .collection('favourites')
                                      .doc(food_list.id)
                                      .delete();
                                  final snakbar = SnackBar(content: const Text('Item removed from favorite!'),
                                    action: SnackBarAction(
                                      onPressed: () {
                                      }, label: '',
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snakbar);

                                },
                                icon: Icon(Icons.favorite),
                                color: Colors.red),
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
        ),
      );
}
