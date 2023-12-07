import 'package:cloud_firestore/cloud_firestore.dart';

class User {

  final String photoUrl;


  const User({
   required this.photoUrl,
  });

  Map<String, dynamic> toJson() =>
      {

        "photoUrl": photoUrl,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = (snap.data() as Map<String, dynamic>);
    return User(
        photoUrl: snapshot["photoUrl"]
       );
  }
}