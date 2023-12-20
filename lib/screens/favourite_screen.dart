import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "My Favourites",
          style: TextStyle(
              fontSize: 22, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users-favourite-items")
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection("items")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Something is wrong"),
            );
          }
          try {
            if (snapshot.data!.docs.length == 0) {
              return Scaffold(
                body: Center(
                    child: Column(
                  children: [
                    Lottie.asset("assets/Animation - 1700584045216.json"),
                    Text(
                      "Your Cart is Empty",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )),
              );
            }
          } catch (exception) {}

          return Column(
            children: [
              Flexible(
                child: ListView.builder(
                  itemCount:
                      snapshot.data == null ? 0 : snapshot.data!.docs.length,
                  itemBuilder: (_, index) {
                    DocumentSnapshot _documentSnapshot =
                        snapshot.data!.docs[index];

                    return Column(
                      children: [
                        Slidable(
                          endActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                backgroundColor: Colors.red,
                                icon: Icons.delete,
                                label: "Delete",
                                onPressed: (context) => {
                                  FirebaseFirestore.instance
                                      .collection("users-favourite-items")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.email)
                                      .collection("items")
                                      .doc(_documentSnapshot.id)
                                      .delete(),
                                  Get.snackbar(
                                      ' Cart', 'Item Removed From Favourites',
                                      colorText: Color(0xFFefcf18),
                                      duration: Duration(seconds: 3),
                                      backgroundColor: Color(0xFF282828),
                                      snackPosition: SnackPosition.TOP),
                                },
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(


                              children: [

                                Center(
                                  child: Container(
                                    width: double.infinity,
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
                                           _documentSnapshot['images'],
                                            height: 120,
                                            width: double.infinity,
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
                                                    _documentSnapshot["name"],
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    _documentSnapshot["hotel"],
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
                                                          "${  _documentSnapshot['distance'].round()}KM",
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
                                                      "${_documentSnapshot["price"]}₹",
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
