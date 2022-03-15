import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PopularFood extends StatelessWidget
{
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
        title: Text('Popular Foods',
        style: TextStyle(color: Colors.black,  fontSize: 25.0, fontWeight: FontWeight.bold,fontFamily: 'Montserrat',),),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20),
          child: popularFood(context, currentUser!.uid)),
    );
  }

}

Widget popularFood(BuildContext context, String uid) => Container(
  child:
        Container(
          //padding: EdgeInsets.only(top: 10),
          //height: MediaQuery.of(context).size.height * 0.2,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("cuisines_list").snapshots(),
            builder: (context, snapshot){
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  //scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index){
                    if(!snapshot.hasData){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    DocumentSnapshot cuisines_list = snapshot.data?.docs[index] as DocumentSnapshot<Object?>;
                    return Card(
                      elevation: 10.0,
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Column(
                          children: [
                            Text(
                              cuisines_list['name'],
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            Image.network(cuisines_list['img'],height: 120,width: 200,fit: BoxFit.cover,),
                            IconButton(onPressed: () async {
                              await FirebaseFirestore.instance.collection('user').doc(uid).collection('favourites').add(
                                  {
                                    'name':cuisines_list['name'],
                                    'img':cuisines_list['img'],
                                  });
                              final snackBar = SnackBar(
                                content: const Text('Item added to favorite!'),
                                action: SnackBarAction(
                                  onPressed: () {
                                  }, label: '',
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }, icon: Icon(Icons.favorite_border)),
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
        ),

);