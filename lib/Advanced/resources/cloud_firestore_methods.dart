import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:meal_monkey/Advanced/model/order_request_model.dart';
import 'package:meal_monkey/Advanced/model/product_model.dart';

import 'package:meal_monkey/Advanced/model/review_model.dart';
import 'package:meal_monkey/Advanced/model/user_details_model.dart';
import 'package:meal_monkey/Advanced/utils/utils.dart';
import 'package:meal_monkey/Advanced/widgets/simple_product_widget.dart';

class CloudFirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> uploadProductToDatabase({
    required Uint8List? image,
    required String productName,
    required String rawCost,
    required int discount,
    required String calories,
    required String volume,
    required String description,

  }) async {
    productName.trim();
    rawCost.trim();
    String output = "Something went wrong";

    if (image != null && productName != "" && rawCost != "") {
      try {
        String uid = Utils().getUid();
        String url = await uploadImageToDatabase(image: image, uid: uid);
        double cost = double.parse(rawCost);
        cost = cost - (cost * (discount / 100));
        ProductModel product = ProductModel(
            url: url,
            productName: productName,
            cost: cost,
            uid: uid,
            rating: 5,
            noOfRating: 0, calories: calories, volume: volume, description:description, discount: 0, );

        await firebaseFirestore
            .collection("popular_foods")
            .doc(uid)
            .set(product.getJson());
        output = "success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please make sure all the fields are not empty";
    }

    return output;
  }

  Future<String> uploadImageToDatabase(
      {required Uint8List image, required String uid}) async {
    Reference storageRef =
        FirebaseStorage.instance.ref().child("products").child(uid);
    UploadTask uploadToask = storageRef.putData(image);
    TaskSnapshot task = await uploadToask;
    return task.ref.getDownloadURL();
  }




  Future uploadReviewToDatabase(
      {required String productUid, required ReviewModel model}) async {
    await firebaseFirestore
        .collection("products")
        .doc(productUid)
        .collection("reviews")
        .add(model.getJson());
    await changeAverageRating(productUid: productUid, reviewModel: model);
  }

  Future addProductToCart({required ProductModel productModel}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .doc(productModel.uid)
        .set(productModel.getJson());
  }

  Future deleteProductFromCart({required String uid}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .doc(uid)
        .delete();
  }



  Future<List<Widget>> getProductsFromDiscount(int discount) async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap = await firebaseFirestore
        .collection("products")
        .where("discount", isEqualTo: discount)
        .get();

    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];
      ProductModel model =
      ProductModel.getModelFromJson(json: (docSnap.data() as dynamic));
      children.add(SimpleProductWidget(productModel: model));
    }
    return children;
  }


  Future changeAverageRating(
      {required String productUid, required ReviewModel reviewModel}) async {
    DocumentSnapshot snapshot =
        await firebaseFirestore.collection("products").doc(productUid).get();
    ProductModel model =
        ProductModel.getModelFromJson(json: (snapshot.data() as dynamic));
    int currentRating = model.rating;
    int newRating = ((currentRating + reviewModel.rating) / 2).toInt();
    await firebaseFirestore
        .collection("products")
        .doc(productUid)
        .update({"rating": newRating});
  }
}
