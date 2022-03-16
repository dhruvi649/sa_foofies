import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sa_foodie/src/screens/review/see_reviews.dart';
import 'package:sa_foodie/src/widget/app_bar.dart';
import 'package:sa_foodie/src/widget/text_style.dart';

class ReviewScreen extends StatefulWidget {
  final String name;
  final String img;

  const ReviewScreen({Key? key, required this.name, required this.img})
      : super(key: key);

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController _controller = TextEditingController();
  String _displayName = '';

  @override
  void initState() {
    super.initState();
    getName();
  }

  void getName()async{
    var docSnapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get();
    if(docSnapshot.exists){
      setState(() {
        _displayName = docSnapshot.get('name');
      });
    }
    print(user!.uid);
    print(docSnapshot.get('name'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
        centerTitle: true,
        title: Text(
          'Review',
          style: text_style
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(right: 250, left: 20.0),
                    child: Text(
                      widget.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 350,
                    child: Image.network(
                      widget.img,
                      height: 250,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Text(
                          'Give Review',
                          style: textLogin
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SeeReviews(
                                        name: widget.name,
                                      )));
                        },
                        child: Text(
                          'See all reviews',
                          style: TextStyle(color: Colors.blue, fontSize: 18.0),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        minLines: 8,
                        // any number you need (It works as the rows for the textarea)
                        keyboardType: TextInputType.multiline,
                        controller: _controller,
                        decoration: InputDecoration(
                            hintText: 'Give Review',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                        maxLines: null,
                      )),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.yellow,
                        padding: EdgeInsets.symmetric(
                            horizontal: 130.0, vertical: 15.0)),
                    onPressed: () async {

                      await FirebaseFirestore.instance
                          .collection('reviews')
                          .add({
                        'review': _controller.text,
                        'user': _displayName,
                        'itemName': widget.name,
                      });
                      final snackBar = SnackBar(
                        duration: Duration(seconds: 1),
                        content: const Text('Review added successfully!'),
                        action: SnackBarAction(
                          onPressed: () {},
                          label: '',
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);


                      _controller.clear();
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.black, fontSize: 25.0),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
