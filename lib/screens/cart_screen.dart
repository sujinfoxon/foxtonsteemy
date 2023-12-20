import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:lottie/lottie.dart';
import 'package:meal_monkey/screens/checkout_screen.dart';
import 'package:meal_monkey/widgets/confrim_page.dart';
import 'package:meal_monkey/widgets/nav_bar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_flutter/swipebutton.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isFinished = false;
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  late VoidCallback _showPersBottomSheetCallBack;

  @override
  void initState() {
    super.initState();
    _showPersBottomSheetCallBack = _showPersistentBottomSheet;
  }

  void _showPersistentBottomSheet() {
    setState(() {
      _showPersBottomSheetCallBack;
    });
    _scaffoldKey.currentState
        ?.showBottomSheet((context) {
          return new Container(
            height: 200.0,
            color: Colors.green,
            child: new Center(
              child: new Text("Persistent BottomSheet",
                  textScaleFactor: 2,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          );
        })
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              _showPersBottomSheetCallBack = _showPersistentBottomSheet;
            });
          }
        });
  }

  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: 200.0,
            color: Colors.green,
            child: new Center(
                child: SwipeableButtonView(
                    buttonText: "Slide to Pay",
                    buttontextstyle:
                        TextStyle(fontSize: 25, color: Colors.white),
                    buttonWidget: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                    ),
                    activeColor: Color(0xff009c41),
                    onWaitingProcess: () {
                      Future.delayed(const Duration(seconds: 2), () => setState(() =>
                        isFinished = true));

                      },

                    isFinished: isFinished,
                    onFinish: () async {
                      await Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: ConfermationPage()));
                      setState(() {
                        isFinished = false;
                      });
                    })),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.white,
      appBar:  AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "My Cart",
          style: TextStyle(
              fontSize: 22, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users-cart-items")
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
                                      .collection("users-cart-items")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.email)
                                      .collection("items")
                                      .doc(_documentSnapshot.id)
                                      .delete(),
                                  Get.snackbar(
                                      ' Cart', 'Item Removed From Cart',
                                      colorText: Color(0xFFefcf18),
                                      duration: Duration(seconds: 3),
                                      backgroundColor: Color(0xFF282828),
                                      snackPosition: SnackPosition.TOP),
                                },
                              )
                            ],
                          ),
                          child: Container(
                            margin: EdgeInsets.all(15),
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.all(Radius.circular(8)),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  _documentSnapshot["images"]))),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),

                                    Column(
                                      children: [
                                        Text(
                                          _documentSnapshot['name'],
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          _documentSnapshot['hotel'],
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18),
                                        ),
                                        Text(
                                         " ${_documentSnapshot['price']}₹",
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),

                                    Container(
                                      margin: EdgeInsets.all(10),
                                      height: 40,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF282828),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(8)),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 25,
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                CupertinoIcons.minus,
                                                color: Color(0xFFefcf18),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            color: Color(0xFFefcf18),
                                            height: 40,
                                            width: 25,
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
                                            height: 40,
                                            width: 25,
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                CupertinoIcons.add,
                                                color: Color(0xFFefcf18),
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
      bottomNavigationBar: GestureDetector(
        onTap:(){
          Navigator.push(context,MaterialPageRoute(builder:(context)=>CheckoutScreen()));
        },
        child: Container(
          margin: EdgeInsets.all(15),
          height: 55,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.red,
          ),
          child: Center(
              child: Text(
            "Finalize Order",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }

}
