import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var inputText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Search for products"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                //  height: constrains.maxHeight * 0.1,
                decoration: BoxDecoration(
                  color: Color(0xffB4B4B4).withOpacity(0.4),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Center(
                    child: TextFormField(

                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search for products"



                      ),

                      onChanged: (val) {
                        setState(() {
                          inputText = val;
                          print(inputText);
                        });
                      },


                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: Container(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("popular_foods")
                          .where("product-name",
                          isGreaterThanOrEqualTo: inputText)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Something went wrong"),
                          );
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Text("Loading"),
                          );
                        }

                        return ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                            return Card(
                              elevation: 5,
                              child: ListTile(
                                title: Text(data['product-name']),
                                leading: Image.network(data['product-img']),
                              ),
                            );
                          }).toList(),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}