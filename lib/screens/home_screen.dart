import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meal_monkey/firebase/datas/userdata.dart';
import 'package:meal_monkey/profile_pages/user_profile_screen.dart';
import 'package:meal_monkey/screens/category_screen.dart';
import 'package:meal_monkey/screens/item_screen.dart';
import 'package:meal_monkey/screens/restaurants.dart';
import 'package:meal_monkey/utils/utils.dart';
import '../firebase/offer slider/offer_slider.dart';
import '../widgets/tab_controller.dart';
import 'package:image_picker/image_picker.dart';
class HomeScreen extends StatefulWidget {
  final String uid;
 HomeScreen({super.key,required this.uid});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var userData = {};
  bool isLoading = false;

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      // get post lENGTH



      userData = userSnap.data()!;

      setState(() {});
    } catch (e) {

    }
    setState(() {
      isLoading = false;
    });
  }
  Uint8List? _image;
  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }
  Position? _currentUserPosition;
  double? distanceImMeter = 0.0;
  Future _getTheDistance() async {
    _currentUserPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    for (int i = 0; i < _products.length; i++) {
      double storelat =  _products[i]["hotel-latitude"];
      double storelng =   _products[i]["hotel-longitude"];

      distanceImMeter = await Geolocator.distanceBetween(
        _currentUserPosition!.latitude,
        _currentUserPosition!.longitude,
        storelat,
        storelng,
      );
      var distance = distanceImMeter?.round().toInt();

      _products[i]["hotel-distance"] = (distance! / 1000);
      setState(() {});
    }
  }
  List _products = [];
  List _Hotels = [];
  var _firestoreInstance = FirebaseFirestore.instance;
  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("popular_foods").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "product-img": qn.docs[i]["product-img"],
          "product-price": qn.docs[i]["product-price"],
          "product-description": qn.docs[i]["product-description"],
          "product-calories": qn.docs[i]["product-calories"],
          "product-volume": qn.docs[i]["product-volume"],
          "product-name": qn.docs[i]["product-name"],
          "hotel-latitude": qn.docs[i]["hotel-latitude"],
          "hotel-longitude": qn.docs[i]["hotel-longitude"],
          "hotel-distance": qn.docs[i]["hotel-distance"],
          "food-type": qn.docs[i]["food-type"],
          "product-from": qn.docs[i]["product-from"],
        });
      }
    });

    return qn.docs;
  }
  fetchHotels() async {
    QuerySnapshot qn = await _firestoreInstance.collection("restaurants").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _Hotels.add({
          "hotel-img": qn.docs[i]["hotel-img"],
          "hotel-name": qn.docs[i]["hotel-name"],
          "hotel-type": qn.docs[i]["hotel-type"],
        });
      }
    });

    return qn.docs;
  }

  @override
  void initState() {
    fetchHotels();
    _getTheDistance();
    getData();
    startStreaming();
    super.initState();
    fetchProducts();
    // Get the current user ID.

    // Get the current user document from Firestore.

  }

  late ConnectivityResult result;
  late StreamSubscription subscription;
  var isConnected = false;
  checkInternet() async{
    result = await Connectivity().checkConnectivity();
    if(result != ConnectivityResult.none){
      isConnected = true;
    }else{
      isConnected = false;
      showDialogBox();
    }
    setState(() {

    });
  }
  showDialogBox(){
    showDialog(context: context, builder:(context)=>CupertinoAlertDialog(
      title: Text("No Internet"),
      content: Text("Please check your internet connection"),

      actions: [
        CupertinoButton.filled(child: Text("Retry"), onPressed:(){}),
      ],
    ));
  }
  startStreaming(){
    subscription = Connectivity().onConnectivityChanged.listen((event) async{
      checkInternet();
    });
  }
  @override
  Widget build(BuildContext context) {
    List foods = ["Burger", "Pizza", "Snacks", "Water",];

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
    return isLoading
        ? Center(
          child: const SpinKitCubeGrid(
      color: Color(0xFFefcf18),
      size: 50.0,
    ),
        ): Scaffold(

      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          "Deliver to",
                          style: TextStyle(fontSize: 22, color: Colors.black54,fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Color(0xFFFF5208),
                            ),
                            Text(
                              userData['username'],
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox( height: 5,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 23),
                          width:MediaQuery.of(context).size.width / 1.4,
                          child: Text(
                            userData['address'],maxLines: 1,overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400,color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>UserProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid)));},
                      child: Stack(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey,
                                backgroundImage: NetworkImage(
                                  userData['photoUrl'],
                                ),
                                radius: 30,
                              ),

                            ],
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.4,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Color(0xFFF3F3F3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Search your food here...",
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>   ProfileScreen()));

                    },
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Color(0xFF282828),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.filter_list,
                        color: Color(0xFFefcf18),
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ImageSliderFirebase(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Categories",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryScreen()));
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(
                              color: Color(0xFFefcf18),
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 120,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: foods.length,
                    itemBuilder: (context, index) {
                      return Container(
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
                      );
                    }),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                        onPressed: () {

                        },
                        child: Text(
                          "See All",
                          style: TextStyle(
                              color: Color(0xFFefcf18),
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 251,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {

                        Navigator.push(context,MaterialPageRoute(builder: (context) => ItemScreen(_products[index])));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.4,
                        margin: EdgeInsets.only(
                            left: 15, top: 5, bottom: 5, right: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 2,
                              )
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: Image.network(
                                _products[index]["product-img"],
                                height: 120,
                                width: MediaQuery.of(context).size.width / 1.4,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _products[index]["product-name"],
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        _products[index]["food-type"],
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black45),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Color(0xFFFF2F08),
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            "4.7",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "(941 Ratings)",
                                            style:
                                                TextStyle(color: Colors.black45),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Color(0xFFFF2F08),
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              "${  _products[index]["hotel-distance"].round()} KM",
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: Color(0xFFFF2F08),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                            )),
                                        child: Text(
                                          "${_products[index]["product-price"]}₹",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular Restaurants",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) =>ResTabBar()));
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(
                              color: Color(0xFFefcf18),
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: foods2.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context) => Restaurants()));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.4,
                        margin: EdgeInsets.only(
                            left: 15, top: 5, bottom: 5, right: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 2,
                              )
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: Image.asset(
                                "assets/img.png",
                                height: 120,
                                width: MediaQuery.of(context).size.width / 1.4,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Mubarak",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Hotel & Restaurant",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black45),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Color(0xFFFF2F08),
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            "4.9",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "(4541 Ratings)",
                                            style:
                                            TextStyle(color: Colors.black45),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Color(0xFFFF2F08),
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              "5 kM",
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),


                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Restaurants",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) =>ResTabBar()));
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(
                              color: Color(0xFFefcf18),
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {

                        Navigator.push(context,MaterialPageRoute(builder: (context) => ItemScreen(_products[index])));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.4,
                        margin: EdgeInsets.only(
                            left: 15, top: 5, bottom: 5, right: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 2,
                              )
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: Image.network(
                                _Hotels[index]["hotel-img"],
                                height: 120,
                                width: MediaQuery.of(context).size.width / 1.4,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _Hotels[index]["hotel-name"],
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        _Hotels[index]["hotel-type"],
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),

                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Color(0xFFFF2F08),
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            "4.7",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "(941 Ratings)",
                                            style:
                                            TextStyle(color: Colors.black45),
                                          ),
                                          SizedBox(height:5)
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Color(0xFFFF2F08),
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              "1 kM",
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),


                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height:30)
            ],
          ),

        ),
      ) ,
    );
  }
}
