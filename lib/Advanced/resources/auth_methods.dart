import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:meal_monkey/Advanced/model/user.dart' as model;
import 'package:meal_monkey/Advanced/model/food_model.dart' as food;

import 'package:meal_monkey/Advanced/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String phone,
    required String address,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          phone.isNotEmpty ||
          address.isNotEmpty ||
          username.isNotEmpty ||
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage("profilePics", file, false);
        model.User user = model.User(
          username: username,
          email: email,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          phone: phone,
          address: address,
        );
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());
        return "Success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

   addFoods({
    required String calories,
    required String description,
    required String name,
    required int price,
    required String volume,
    required Uint8List file,
    required int latitude,
    required int longitude,
    required int distance,
    required String foodtype,
    required String from,
  }) async {
    String res = "Some error occurred";
    try {
      if (calories.isNotEmpty ||
          description.isNotEmpty ||
          name.isNotEmpty ||
          volume.isNotEmpty ||
          foodtype.isNotEmpty ||
          from.isNotEmpty ||
          file != null) {
        String photoUrl = await StorageMethods()
            .uploadImageToStorage("popular_foods", file, false);
        food.Food user = food.Food(
          photoUrl: photoUrl,
          calories: calories,
          description: description,
          price: price,
          name: name,
          volume: volume,
          latitude: latitude,
          longitude: longitude,
          distance: distance,
          foodtype: foodtype,
          from: from,
        );
        await _firestore.collection("popular_foods").doc().set(user.toJson());
        return "Success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = " Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
