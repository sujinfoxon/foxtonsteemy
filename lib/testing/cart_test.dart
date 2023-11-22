import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';





class Cart extends StatefulWidget {




  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {




  void getTotal() async {
    int? sum = 0;


    FirebaseFirestore.instance.collection('users-cart-items').doc(FirebaseAuth.instance.currentUser!.email)
        .collection("items").get().then(
          (querySnapshot) {
        querySnapshot.docs.forEach((result) {
          for (var i = 1; i < result.data()['price'].toString().length; i++) {
            sum = (sum! + result.data()['price']) as int?;

          }

        });

        //     print('total : $sum');
        // return sum;
      },

    );

  }

  @override
  void initState() {
    // TODO: implement initState
    fetchPrice();
    super.initState();
  }
  int amount = 0;
  int? sum = 0;
  void fetchPrice() async {
    final data = await  FirebaseFirestore.instance.collection('users-cart-items').doc(FirebaseAuth.instance.currentUser!.email)
        .collection("items").get();

    List<Map<String, dynamic>?>? documentData = data?.docs.map((e) => e.data() as Map<String, dynamic>?).toList(); //working

    int len = documentData!.length;
    int price = documentData![0]!['price'];


    for( int i = 0 ; i < len; i++ ) {
      sum = (sum! + documentData![i]!['price']) as int?;
      print('i ' + i.toString() + ' amt: ' + sum.toString());
    }
    setState(() {
      amount = sum!;
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,

        title: Text("Cart",style: TextStyle(color:Colors.white),),




      ),
      body: SafeArea(
          child:StreamBuilder(
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
                        child:Column(children: [ Image.asset('assets/3.webp'),
                          Text("Your Cart is Empty",style: TextStyle(color: Colors.yellow,fontSize: 24,fontWeight: FontWeight.bold),)
                        ],)
                    ),
                  );
                }
              }catch(exception){

              }


              return Container(
                child: Column(
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
                              Card(
                                elevation: 5,
                                child: ListTile(

                                  leading:    AspectRatio(
                                      aspectRatio: 1.5,
                                      child: Container(
                                          color: Colors.yellow,
                                          child: Image.network(
                                            _documentSnapshot["images"][0],fit:BoxFit.fitHeight,
                                          ))),

                                  title: Text(
                                    " ${_documentSnapshot['name']} : ${_documentSnapshot['price']}₹",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, color: Colors.red),
                                  ),

                                  trailing: GestureDetector(
                                    child:
                                    Icon(Icons.delete,color: Colors.red,),
                                  ),
                                  onTap: () {

                                    setState(() {
                                      FirebaseFirestore.instance
                                          .collection("users-cart-items")
                                          .doc(FirebaseAuth.instance.currentUser!.email)
                                          .collection("items")
                                          .doc(_documentSnapshot.id)
                                          .delete();
                                      amount = sum!;
                                    });
                                  },

                                ),

                              ),



                            ],
                          );

                        },),
                    ),
                    Container(
                      color: Colors.yellow,
                      width: double.infinity,
                      height: 150,
                      child: Column(
                        children: [
                          SizedBox(height: 2,),
                          Text("Delivery Charge : 20₹",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                          Divider(height: 2,),
                          Text("Total Price: ${amount}₹",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),

                          SizedBox(height: 20,),
                          Container(
                            width:250,
                            height:  50,
                            margin: EdgeInsets.only(
                              top:  0.1,
                            ),
                            child: ElevatedButton(
                              onPressed: () {



                                //   DocumentReference copyFrom = FirebaseFirestore.instance.collection('Delivery Datas').doc(FirebaseAuth.instance.currentUser!.email);
                                //  DocumentReference copyTo = FirebaseFirestore.instance.collection('Productmodel').doc(FirebaseAuth.instance.currentUser!.email);

                                // copyFrom.get().then((value) => {
                                //    copyTo.set(value.data())
                                //  });


                                //  Get.to(() =>  Mywidget());
                              //  Get.to(() =>  CheckoutScreen());


                              },
                              child: Text(
                                'Checkout',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  primary: Colors.green),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          )

      ),

    );

  }
}
