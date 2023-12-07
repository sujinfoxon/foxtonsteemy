import 'package:flutter/material.dart';
import 'package:meal_monkey/profile_pages/add_new_address.dart';
import 'package:meal_monkey/widgets/address_widget.dart';

class UserAddressScreen extends StatefulWidget {
  const UserAddressScreen({super.key});

  @override
  State<UserAddressScreen> createState() => _UserAddressScreenState();
}

class _UserAddressScreenState extends State<UserAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF282828),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddnewAddressScreen()));
        },
        child: Icon(
          Icons.add_circle,
          color: Color(0xFFefcf18),
        ),
      ),
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
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SingleAddress(
                selectedAddress:false,
              ),
              SingleAddress(
                selectedAddress: false,
              ),
              SingleAddress(
                selectedAddress: true,
              ),
              SingleAddress(
                selectedAddress: false,
              ),
              SingleAddress(
                selectedAddress: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
