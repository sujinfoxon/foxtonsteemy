import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_monkey/authentication/authmethods.dart';
import 'package:meal_monkey/screens/login_page.dart';
import 'package:meal_monkey/widgets/nav_bar.dart';

import '../utils/utils.dart';
import 'address_page.dart';
class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool _isLoading = false;
  Uint8List? _image;
  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }
  String name = '';
  String address = '';
  String phone = '';
  @override
  void initState() {
    super.initState();
    // Get the current user ID.
    final userID = FirebaseAuth.instance.currentUser?.uid;

    // Get the current user document from Firestore.
    final userDoc = FirebaseFirestore.instance.collection('users').doc(userID);

    // Get the data from the current user document.
    userDoc.get().then((doc) {
      // Set the name and email state variables.
      setState(() {
        name = doc['fullName'];
        address = doc['phone'];
        address = doc['address'];
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Material(
      child: SafeArea(
        child: Padding(padding: EdgeInsets.only(top: 50,left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("MyProfile",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
                TextButton(onPressed: (){

                }, child:Text("Save",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),))
              ],
            ),
            SizedBox(height: 30,),
            ListTile(
              leading:  GestureDetector(
                onTap: (){selectImage();},
                child: Stack(
                  children: [
                    Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                          radius:30,
                            backgroundImage: MemoryImage(_image!))
                            : CircleAvatar(
                            radius:30,
                            backgroundImage: NetworkImage("https://cdn2.iconfinder.com/data/icons/avatars-99/62/avatar-370-456322-512.png")
                        ),

                      ],
                    ),

                  ],
                ),
              ),

              title: Text("${name}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25),),
              subtitle: Text("${address}"),
            ),
            Divider(height: 50,),
            ListTile(
              onTap: (){},
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFF282828),
                  shape: BoxShape.circle,
                ),
                child: Icon(CupertinoIcons.person,color: Color(0xFFefcf18),size: 35,),
              ),
              title: Text("My Account",style: TextStyle(fontWeight: FontWeight.w500,
              fontSize: 20),),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            Divider(height: 30,),
            ListTile(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder:(context)=>UserAddressScreen()));
              },
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFF282828),
                  shape: BoxShape.circle,
                ),
                child: Icon(CupertinoIcons.house_fill,color: Color(0xFFefcf18),size: 35,),
              ),
              title: Text("Address",style: TextStyle(fontWeight: FontWeight.w500,
                  fontSize: 20),),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            SizedBox(height: 20,),
            Divider(height: 30,),
            ListTile(
              onTap: (){},
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFF282828),
                  shape: BoxShape.circle,
                ),
                child: Icon(CupertinoIcons.gift_fill,color: Color(0xFFefcf18),size: 35,),
              ),
              title: Text("Gift Cards",style: TextStyle(fontWeight: FontWeight.w500,
                  fontSize: 20),),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            SizedBox(height: 20,),
            Divider(height: 30,),
            ListTile(
              onTap: (){},
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFF282828),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.support_agent,color: Color(0xFFefcf18),size: 35,),
              ),
              title: Text(""
                  "Help",style: TextStyle(fontWeight: FontWeight.w500,
                  fontSize: 20),),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            SizedBox(height: 20,),
            Divider(height: 30,),
            ListTile(
              onTap: () async {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Logout"),
                        content: Text("Are you sure you want to logout?"),
                        actions: [
                          IconButton(
                              onPressed: () {
                              Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.red,
                              )),
                          IconButton(
                              onPressed: () async {
                                _signOut();
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                              },
                              icon: Icon(
                                Icons.done,
                                color: Colors.green,
                              ))
                        ],
                      );
                    });
              },

              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.logout,color: Color(0xFFFF2F08),size: 35,),
              ),
              title: Text(""
                  "Log Out",style: TextStyle(fontWeight: FontWeight.w500,
                  fontSize: 20),),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            SizedBox(height: 20,),

          ],
        ),
        ),
      ),
    );
  }
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }
  void saveProfile() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(

      file: _image!,
    );
    if (res != "success") {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
     NavBarRoots()));
    }
    setState(()
    {
      _isLoading = false;
    });
  }
}
