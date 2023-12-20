import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import '../widgets/confrim_page.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool isFinished = false;
  String gender = "male";
@override
  void initState() {
  fetchPrice();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Checkout",
          style: TextStyle(
              fontSize: 22, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black54,
                    width: 5,
                  ),
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Item Price:",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${amount}₹",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Delivery Charges:",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "40",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Price:",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${amount + total}₹",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Payments",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black54,
                    width: 5,
                  ),
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage("assets/img_2.png"),
                        ),
                        Text(
                          "Pay Online",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Radio(
                            value: "Pay Online",
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value.toString();
                              });
                            })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage("assets/img_3.png"),
                        ),
                        Text(
                          "Cash on Delivery",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Radio(
                          value: "Cash on Delivery",
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value.toString();
                            });
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(25),
        child: SwipeableButtonView(
            buttonText: "Slide to Pay",
            buttontextstyle: TextStyle(fontSize: 25, color: Colors.white),
            buttonWidget: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey,
            ),
            activeColor: Color(0xff009c41),
            onWaitingProcess: () {
              Future.delayed(const Duration(seconds: 2),
                  () => setState(() => isFinished = true));
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
            }),
      ),
    );
  }

  int amount = 0;
  int? sum = 0;
  int total =  40 ;

  void fetchPrice() async {
    final data = await FirebaseFirestore.instance
        .collection('users-cart-items')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("items")
        .get();

    List<Map<String, dynamic>?>? documentData = data?.docs
        .map((e) => e.data() as Map<String, dynamic>?)
        .toList(); //working

    int len = documentData!.length;
    int price = documentData![0]!['price'];

    for (int i = 0; i < len; i++) {
      sum = (sum! + documentData![i]!['price']) as int?;
      print('i ' + i.toString() + ' amt: ' + sum.toString());
    }
    setState(() {
      amount = sum!;
    });
  }
}
