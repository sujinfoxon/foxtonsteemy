import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';
class UserReviewCard extends StatefulWidget {
  const UserReviewCard({super.key});

  @override
  State<UserReviewCard> createState() => _UserReviewCardState();
}

class _UserReviewCardState extends State<UserReviewCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/profile.jpg"),
                ),
                SizedBox(width: 10,),
                Text("Anisha",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),

              ],
            ),
            IconButton(onPressed: (){}, icon:Icon(Icons.more_vert))

          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            RatingBarIndicator(
                rating: 4.5,
                itemSize: 20,
                itemBuilder:(_,__)=>Icon(Icons.star,color: Color(0xFFefcf18),)),
           SizedBox(width: 10,),
            Text("01 Nov,2023",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),

          ],
        ),
        SizedBox(height: 10,),
        ReadMoreText("The user interface of the app is quite intvitive. I was able to navigate and make purchese seamlessly.Great job!",trimLines:2,trimExpandedText: "show less",trimCollapsedText: "show more",trimMode: TrimMode.Line,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),)
      ],
    );
  }
}
