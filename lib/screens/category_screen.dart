import 'package:flutter/material.dart';
class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List foods = ["Burger", "Pizza", "Snacks", "Water"];

  List foods2 = [
    "Chicken Burger",
    "Cheese Pizza",
  ];

  List<Color> bgColors = [
    Color(0xFFFBDCDA),
    Color(0xFFD4EEF3),
    Color(0xFFFAE6D5),
    Color(0xFFEFCFE7),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(color: Colors.black, onPressed: () {Navigator.pop(context);  }, icon: Icon(Icons.arrow_back_ios_new),),


        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
title: Text("Categories",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Colors.black),),
      ),
      body:     SingleChildScrollView(
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          shrinkWrap: true,
          children: List.generate(foods.length, (index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child:  Container(
                width: 100,
                margin: EdgeInsets.only(left: 15),
                padding: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: bgColors[index],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/${foods[index]}.png",
                      height: 80,
                      width: 80,
                    ),
                    Text(
                      foods[index],
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    )
                  ],
                ),
              ),
            );
          },),
        ),
      ),
    );
  }
}