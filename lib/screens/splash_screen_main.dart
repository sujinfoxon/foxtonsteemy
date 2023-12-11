import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_monkey/screens/home_screen.dart';
import 'package:meal_monkey/widgets/nav_bar.dart';
import 'package:page_transition/page_transition.dart';


class SplashScreenMain extends StatefulWidget {
  const SplashScreenMain({Key? key}) : super(key: key);

  @override
  State<SplashScreenMain> createState() => _SplashScreenMainState();
}

class _SplashScreenMainState extends State<SplashScreenMain> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 3),
            () =>Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: NavBarRoots())));
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF282828),
      body: SafeArea(
          child: Center(
              child:  Image.asset("assets/logo.png")
          )
      ),
    );
  }
}

