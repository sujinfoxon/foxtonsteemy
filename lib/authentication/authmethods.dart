import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:meal_monkey/authentication/user.dart' as model;
import '../firebase/methods/storage_methods.dart';


class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<String> signUpUser({

    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      if (
      file != null) {
        String photoUrl = await StorageMethods()
            .uploadImageToStorage("profilePics", file, false);
        model.User user = model.User(

            photoUrl: photoUrl,
          );
        await _firestore.collection("users").doc(
            FirebaseAuth.instance.currentUser!.uid).set(user.toJson());
        return "Success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}