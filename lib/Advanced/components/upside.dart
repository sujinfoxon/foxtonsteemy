import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:meal_monkey/Advanced/constants.dart';

class Upside extends StatelessWidget {
  const Upside({Key? key, required this.imgUrl}) : super(key: key);
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height / 2,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Lottie.asset(
              imgUrl,
              alignment: Alignment.topCenter,

            ),
          ),
        ),
        iconBackButton(context),

      ],
    );
  }
}

iconBackButton(BuildContext context) {
  return IconButton(
    color: Colors.white,
    iconSize: 28,
    icon: const Icon(CupertinoIcons.arrow_left),
    onPressed: (){
      Navigator.pop(context);
    },
  );
}
