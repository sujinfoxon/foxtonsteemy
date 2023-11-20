import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget fetchDatas (String collectionName){

  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection(collectionName)
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
                  Text("Your Cart is Empty",style: TextStyle(color:Colors.yellow,fontSize: 24,fontWeight: FontWeight.bold),)
                ],)
            ),
          );
        }
      }catch(exception){

      }


      return ListView.builder(
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
                          color:Colors.yellow,
                          child: Image.network(
                            _documentSnapshot["images"][0],fit:BoxFit.fitHeight,
                          ))),

                  title: Text(
                    " ${_documentSnapshot['name']} : ${_documentSnapshot['price']}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.red),
                  ),

                  trailing: GestureDetector(
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child:
                      Icon(Icons.delete,color: Colors.red,),
                    ),
                    onTap: () {
                      FirebaseFirestore.instance
                          .collection(collectionName)
                          .doc(FirebaseAuth.instance.currentUser!.email)
                          .collection("items")
                          .doc(_documentSnapshot.id)
                          .delete();
                    },
                  ),

                ),

              ),

            ],
          );

        },);
    },
  );
}

