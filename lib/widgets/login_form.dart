import 'package:flutter/material.dart';
import 'package:meal_monkey/utils/utils.dart';
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width *0.13
    ),child:Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Email"
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: defaultPadding),
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Password"
            ),
          ),
          ),
          TextButton(onPressed:(){}, child:Text("Forgot Password?",style: TextStyle(color: Colors.white),),
          ),
          Spacer(flex: 2,)
        ],
      ),
    ) ,

    );
  }
}
