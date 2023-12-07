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
                              fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "200",
                          style: TextStyle(
                              fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
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
                              fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "40",
                          style: TextStyle(
                              fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
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
                              fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "240",
                          style: TextStyle(
                              fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
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
                    fontSize: 22, color: Colors.black54, fontWeight: FontWeight.bold),
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

                           backgroundImage: AssetImage("assets/img_1.png"),
                          ),
                        Text(
                          "Pay Online",
                          style: TextStyle(
                              fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Radio(
                            value: "radio value",
                            groupValue: "group value",
                            onChanged: (value){
                              print(value); //selected value
                            }
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(

                          backgroundImage: AssetImage("assets/img_1.png"),
                        ),
                        Text(
                          "Cash on Delivery",
                          style: TextStyle(
                              fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Radio(
                            value: "radio value",
                            groupValue: "group value",
                            onChanged: (value){
                              print(value); //selected value
                            }
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
}
