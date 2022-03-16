import 'package:flutter/material.dart';
import 'package:sa_foodie/src/screens/dashboard/favorite_screen/favorite_food.dart';
import 'package:sa_foodie/src/screens/dashboard/favorite_screen/favorite_icecream.dart';
import 'package:sa_foodie/src/widget/app_bar.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[600],
        centerTitle: true,
        title: Text('Favorite', style: text_style),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          children: [
            GestureDetector(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoriteFood(),
                  ),
                );
              },
              child: buildCardCuisines(),
            ),
            GestureDetector(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoriteIcecream(),
                  ),
                );
              },
              child: buildCardIceCream(),
            ),
          ],
        ),
      ),
    );
  }

  Card buildCardIceCream() {
    return Card(
      elevation: 5,
      child: Container(
        height: 150,
        width: 200,
        child: Column(
          children: [
            Image.asset(
              'assets/images_icecream.jpeg',
              fit: BoxFit.cover,
              height: 140,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                'Ice Cream',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card buildCardCuisines() {
    return Card(
      elevation: 5,
      child: Container(
        height: 150,
        width: 200,
        child: Column(
          children: [
            Image.asset(
              'assets/images_cuisines.jpeg',
              fit: BoxFit.cover,
              height: 140,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                'Cuisines',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
