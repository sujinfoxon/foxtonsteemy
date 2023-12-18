
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meal_monkey/Advanced/model/review_model.dart';
import 'package:meal_monkey/Advanced/resources/cloud_firestore_methods.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

import '../provider/user_details_provider.dart';


class ReviewDialog extends StatefulWidget {
  final String uid;
   ReviewDialog({Key? key, required this.uid, }) : super(key: key);

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  var userData = {};
  bool isLoading = false;

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.uid)
          .get();

      // get post lENGTH



      userData = userSnap.data()!;

      setState(() {});
    } catch (e) {

    }
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      title: const Text(
        'Type a review for this Food!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?

      submitButtonText: 'Send',
      submitButtonTextStyle: TextStyle(color: Color(0xFFefcf18)),
      commentHint: 'Type here',

      onSubmitted: (RatingDialogResponse res) async {
        CloudFirestoreClass().uploadReviewToDatabase(
            productUid:userData['uid'],
            model: ReviewModel(
                senderName:
                userData['username'],
                description: res.comment,
                rating: res.rating.toInt()));
      },
    );
  }
}
