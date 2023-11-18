import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_monkey/onboard/onboarding_screens.dart';
import 'package:meal_monkey/screens/register_page.dart';


class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 3),
            () => Navigator.push(
            context, CupertinoPageRoute(builder: (_) => OnBoard())));
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

