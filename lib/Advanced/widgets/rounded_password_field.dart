import 'package:flutter/material.dart';

import 'package:meal_monkey/Advanced/constants.dart';
import 'package:meal_monkey/Advanced/widgets/text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
   RoundedPasswordField({ Key? key, this.hintText, this.icon = Icons.person,required this.controller }) : super(key: key);
   final String? hintText;
   final IconData icon;
   TextEditingController controller =TextEditingController();
  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  late bool _passwordVisible;
  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller:widget.controller,
        obscureText: !_passwordVisible,
        cursorColor: kPrimaryColor,
         decoration: InputDecoration(
            icon: Icon(
              Icons.lock,
              color: kPrimaryColor,
            ),
            hintText: "Password",
            hintStyle:  TextStyle(fontFamily: 'OpenSans'),
             suffixIcon: IconButton(
         icon: Icon(
         // Based on passwordVisible state choose the icon
         _passwordVisible
         ? Icons.visibility
           : Icons.visibility_off,
           color: kPrimaryColor,
         ),
        onPressed: () {
          // Update the state i.e. toogle the state of passwordVisible variable
          setState(() {
            _passwordVisible = !_passwordVisible;
          });
        },
      ),

            border: InputBorder.none),
      ),
    );
  }
}