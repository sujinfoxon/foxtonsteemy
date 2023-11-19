import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:meal_monkey/firebase/datas/profile_pic.dart';
import 'package:meal_monkey/firebase/methods/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String photoUrl =
      await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1(); // creates unique id based on time
      Post post = Post(

        uid: uid,
        username: username,

        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,

      );
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}