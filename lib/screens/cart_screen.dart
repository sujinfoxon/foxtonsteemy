import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:lottie/lottie.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff949494),
      appBar: AppBar(
        backgroundColor: Color(0xff949494),
        centerTitle: true,
        automaticallyImplyLeading: false,

        elevation: 0,
        title: Text(
          "My Cart",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFefcf18)),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users-cart-items")
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection("items")
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Something is wrong"),
            );
          }
          try{
            if (snapshot.data!.docs.length==0) {
              return Scaffold(

                body: Center(
                    child:Column(children: [Lottie.asset("assets/Animation - 1700584045216.json"),
                      Text("Your Cart is Empty",style: TextStyle(color: Colors.black87,fontSize: 24,fontWeight: FontWeight.bold),)
                    ],)
                ),
              );
            }
          }catch(exception){

          }


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
                            motion: const StretchMotion(), children: [
                            SlidableAction(backgroundColor: Colors.red,icon:Icons.delete,label: "Delete",onPressed:(context) =>{
                            FirebaseFirestore.instance
                                .collection("users-cart-items")
                                .doc(FirebaseAuth.instance.currentUser!.email)
                                .collection("items")
                                .doc(_documentSnapshot.id)
                                .delete(),
                          Get.snackbar(' Cart', 'Item Removed From Cart',
                          colorText: Color(0xFFefcf18),
                          duration: Duration(seconds: 3),
                          backgroundColor: Color(0xFF282828),
                          snackPosition: SnackPosition.TOP
                          ),

                            },)
                          ],
                          ),
                          child: Container(
                            margin: EdgeInsets.all(15),
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      image: DecorationImage(
                                          image: NetworkImage( _documentSnapshot["images"][1]))),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  _documentSnapshot['name'],
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  height: 50,
                                  width: 105,
                                  decoration: BoxDecoration(
                                    color: Color(0xff949494),
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 35,
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.minimize,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        color: Color(0xfff7ede6),
                                        height: 50,
                                        width: 35,
                                        child: Center(
                                          child: Text(
                                            "02",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width: 35,
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),


                      ],
                    );

                  },),
              ),

            ],
          );
        },
      ),
      bottomNavigationBar:  Container(
        margin: EdgeInsets.all(15),
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.red,

        ),
        child: Center(child: Text("Finalize Order",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),)),
      ),
    );
  }

}
