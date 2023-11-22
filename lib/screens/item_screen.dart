import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../widgets/nav_bar.dart';
import '../widgets/text_field_widget.dart';

class ItemScreen extends StatefulWidget {
  var _product;

  ItemScreen(this._product);

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(
          widget._product['product-name'],
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NavBarRoots()));
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black45,
          ),
        ),
        actions: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users-favourite-items").doc(FirebaseAuth.instance.currentUser!.email)
                .collection("items").where("name",isEqualTo: widget._product['product-name']).snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.data==null){
                return Text("User Cart Item is empty");
              }
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  backgroundColor:  Color(0xFF282828),
                  child: IconButton(
                    onPressed: () => snapshot.data.docs.length==0?addToFavourite():print("Already Added"),
                    icon: snapshot.data.docs.length==0? Icon(
                      Icons.favorite_outline,
                      color:Color(0xFFefcf18),
                    ):Icon(
                      Icons.favorite,
                      color:Color(0xFFefcf18),
                    ),
                  ),
                ),
              );
            },

          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              widget._product['product-description'],
              style: TextStyle(color: Colors.black45, fontSize: 17),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: Color(0xFFFF2F08),
                  size: 22,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "4.7",
                  style: TextStyle(fontSize: 16, color: Colors.black45),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(25),
              child: Image.network(widget._product['product-img'][1]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Calories",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black45),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget._product['product-calories'],
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  height: 30,
                  width: 2,
                  color: Colors.black45,
                ),
                Column(
                  children: [
                    Text(
                      "Volume",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black45),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget._product['product-volume'],
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  height: 30,
                  width: 2,
                  color: Colors.black45,
                ),
                Column(
                  children: [
                    Text(
                      "Distance",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black45),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "1 KM",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "From",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black45,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "TAJ Hotel",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Delivery",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black45,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Express",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Price",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black45,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget._product['product-price'],
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF2F08),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          addToCart();
        },
        child: Container(
          height: 60,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          padding: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Color(0xFFFF2F08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Add to Cart",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.add_circle_outline_rounded,
                color: Colors.white,
                size: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future addToFavourite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("users-favourite-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget._product["product-name"],
      "price": widget._product["product-price"],
      "images": widget._product["product-img"],

    }).then((value) => print("Added to favourite"));
  }

  Future addToCart() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("users-cart-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget._product["product-name"],
      "price": widget._product["product-price"],
      "images": widget._product["product-img"],
    }).then((value) =>
        Get.snackbar(' Cart', 'Product Added to Cart Successfully',
          colorText: Color(0xFFefcf18),
          duration: Duration(seconds: 3),
          backgroundColor: Color(0xFF282828),
          snackPosition: SnackPosition.TOP
        ),
    );
  }
}
