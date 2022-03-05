import 'package:flutter/material.dart';
import 'package:sa_foodie/src/screens/dashboard/home_screen/home_screen.dart';
import 'package:sa_foodie/src/screens/dashboard/profile_screen/profile_screen.dart';
import 'dashboard_constants.dart';
import 'favorite_screen/favorite_screen.dart';
import 'location_screen/location_screen.dart';

class Dashboard extends StatefulWidget
{
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = [
    HomeScreen(),
    LocationScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:
      _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 28.0,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        items: bottomNavigationItem,
        onTap: _onItemTapped,
      ),

    );

  }
}