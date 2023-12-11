import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String phone;
  final String address;

  const User({
    required this.address,
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.phone,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
        'phone': phone,
        'address': address,
        "photoUrl": photoUrl,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = (snap.data() as Map<String, dynamic>);
    return User(
      email: snapshot["email"],
      uid: snapshot["uid"],
      photoUrl: snapshot["photoUrl"],
      username: snapshot["username"],
      phone: snapshot["phone"],
      address: snapshot["address"],
    );
  }
}
