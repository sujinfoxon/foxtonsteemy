
import 'package:flutter/material.dart';
import 'package:meal_monkey/firebase/datas/product_data.dart';


class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.yellow,
        title: Text("Wishlist"),
      ),
      body: SafeArea(
        child: fetchDatas("users-favourite-items"),
      ),
    );
  }
}