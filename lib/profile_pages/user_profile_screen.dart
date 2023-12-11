import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_monkey/Advanced/screens/login_screen.dart';
import 'package:meal_monkey/authentication/authmethods.dart';
import 'package:meal_monkey/screens/login_page.dart';
import 'package:meal_monkey/widgets/nav_bar.dart';

import '../utils/utils.dart';
import 'address_page.dart';
class UserProfileScreen extends StatefulWidget {
  final String uid;
  UserProfileScreen({super.key,required this.uid});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  var userData = {};
  bool isLoading = false;

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      // get post lENGTH



      userData = userSnap.data()!;

      setState(() {});
    } catch (e) {

    }
    setState(() {
      isLoading = false;
    });
  }
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
    getData();
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
    return  isLoading
        ? const Center(
      child: CircularProgressIndicator(),
    ):Scaffold(
       appBar: AppBar(

          title: Text(
           "My Profile",
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,

          leading: InkWell(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NavBarRoots()));
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black45,
            ),
          ),
          actions: [

          ],
        ),
      body: Material(
        
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 30,),
                ListTile(
                  leading:  GestureDetector(
                    onTap: (){selectImage();},
                    child: Stack(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(
                                userData['photoUrl'],
                              ),
                              radius: 30,
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),

                  title: Text(userData['username'],style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25),),
                  subtitle: Text( userData['phone'],style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
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
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
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
