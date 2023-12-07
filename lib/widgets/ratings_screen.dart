import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:meal_monkey/widgets/user_reviw_card.dart';

class Ratings_screen extends StatefulWidget {
  const Ratings_screen({super.key});

  @override
  State<Ratings_screen> createState() => _Ratings_screenState();
}

class _Ratings_screenState extends State<Ratings_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Reviews & Ratings",
          style: TextStyle(
              fontSize: 22, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Ratings and reviews are verified and are from who use the same type of device that you use.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
              SizedBox(height: 20,),
              overall_rating(),
              RatingBarIndicator(
                  rating: 4.5,
                  itemSize: 20,
                  itemBuilder:(_,__)=>Icon(Icons.star,color: Color(0xFFefcf18),)),
            Text("(12,611)",style: TextStyle(fontSize: 20),),
              SizedBox(height: 25,),
              UserReviewCard(),
              SizedBox(height: 20,),
              UserReviewCard(),
              SizedBox(height: 20,),
              UserReviewCard(),
              SizedBox(height: 20,),
              UserReviewCard(),
              SizedBox(height: 20,),
              UserReviewCard(),
            ],
          ),
        ),
      ),
    );

  }
}

class overall_rating extends StatelessWidget {
  const overall_rating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 3,
            child: Text("4.8",style: TextStyle(fontSize: 45),)),
        Expanded(
          flex: 7,
          child: Column(
            children: [
              rating_progress_indicator(text: '5', value: 1.0,),
              rating_progress_indicator(text: '4', value: 0.8,),
              rating_progress_indicator(text: '3', value: 0.6,),
              rating_progress_indicator(text: '2', value: 0.4,),
              rating_progress_indicator(text: '1', value: 0.2,),
            ],
          ),
        )
      ],
    );
  }
}

class rating_progress_indicator extends StatelessWidget {
  const rating_progress_indicator({
    super.key, required this.text, required this.value,
  });
final String text;
final double value;

@override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex:1,
            child: Text(text)),
        Expanded(
          flex: 11,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: LinearProgressIndicator(
              value:value,
              minHeight: 11,
              backgroundColor: Colors.grey[400],
              valueColor: AlwaysStoppedAnimation(Color(0xFFefcf18)),
              borderRadius: BorderRadius.circular(7),

            ),
          ),
        )
      ],
    );
  }
}
