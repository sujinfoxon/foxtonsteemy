import 'package:flutter/material.dart';
import 'package:meal_monkey/utils/utils.dart';
import 'package:meal_monkey/widgets/login_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: _size.width * 0.88,
            height: _size.height,
            left: _size.width * 0.001,
            child: Container(
              color: login_bg,
              child: LoginForm(),
            ),
          ),
          Positioned(
              height: _size.height,
              width: _size.width * 0.88,
              left: _size.width * 0.12,
              child: Container(
            color: signup_bg,
                child: LoginForm(),
          )),
          Positioned(
            left: 0,
              top: _size.height * 0.1,
              right:_size.width * 0.06 ,
              child: CircleAvatar(
            radius: 25,
                child:Image.asset("assets/logo.png"),
                backgroundColor: login_bg,


          ))
        ],
      ),
    );
  }
}
