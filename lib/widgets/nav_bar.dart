import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_monkey/UI/allStores.dart';
import 'package:meal_monkey/screens/cart_screen.dart';
import 'package:meal_monkey/screens/favourite_screen.dart';
import 'package:meal_monkey/testing/cart_test.dart';
import 'package:meal_monkey/widgets/favourite_page.dart';

import '../screens/home_screen.dart';

class NavBarRoots extends StatefulWidget {
  const NavBarRoots({super.key});

  @override
  State<NavBarRoots> createState() => _NavBarRootsState();
}

class _NavBarRootsState extends State<NavBarRoots> {
  int _selectedIndex = 0;
  final _screens = [
    HomeScreen( uid: FirebaseAuth.instance.currentUser!.uid),
    FavouriteScreen(),
    CartScreen(),
    AllStores()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFFefcf18),
        unselectedItemColor: Color(0xFF282828),
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.heart_fill), label: "Favorites"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cart_fill), label: "Cart"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cube_box_fill), label: "Orders"),
        ],
      ),
    );
  }
}
