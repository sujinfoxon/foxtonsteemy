import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class ConfermationPage extends StatefulWidget {
  const ConfermationPage({super.key});

  @override
  State<ConfermationPage> createState() => _ConfermationPageState();
}

class _ConfermationPageState extends State<ConfermationPage> with TickerProviderStateMixin{
  late final AnimationController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff009c41),
      body: Center(
        child: Lottie.asset(
          "assets/Animation - 1700584797902.json",controller: _controller,
          onLoaded: (composition){
            _controller ..duration = composition.duration ..forward();
          }
        ),
      ),
    );
  }
}
