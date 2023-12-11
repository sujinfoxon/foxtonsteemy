import 'package:flutter/material.dart';
import 'package:meal_monkey/widgets/login_form.dart';

import '../widgets/text_field_widget.dart';
class AddnewAddressScreen extends StatefulWidget {
  const AddnewAddressScreen({super.key});

  @override
  State<AddnewAddressScreen> createState() => _AddnewAddressScreenState();
}

class _AddnewAddressScreenState extends State<AddnewAddressScreen> {
  final _formkey = GlobalKey<FormState>();
  String email ="";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.black54,),
        ),
        title: Text(
          "Addresses",
          style: TextStyle(
              fontSize: 22, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 200,
                  child: TextFormField(
                  decoration: InputDecoration(
                  hintText: "Email"
                  ),
          ),
                ),
                Container(
                  width: 200,
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Email"
                    ),
                  ),
                ),
              ],
            ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){

                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFF282828)
                    ),
                    child: Text("Save Address",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color(0xFFefcf18)),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
