import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:meal_monkey/screens/login_page.dart';
import 'package:meal_monkey/widgets/text_field_widget.dart';
import '../authentication/firebase_authentication/auth_service.dart';
import 'home_screen.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  String fullName = "";
  String email ="";
  String phone ="";
  String address ="";
  String password = "";
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF282828),
      body: _isLoading ? Center(child:  SpinKitCubeGrid(
        color: Color(0xFFefcf18),
        size: 50.0,
      ),): SafeArea(
        child: SingleChildScrollView(
          child:   Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 80),
            child:   Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:<Widget> [
                  Text("Groups",style: TextStyle(

                      fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white
                  ),),
                  SizedBox(height: 10,),
                  Text("Create your account now to explore",style: TextStyle(
                      fontSize: 15,fontWeight:FontWeight.w400,color: Colors.white
                  ),),
                  Center(
                    child: Lottie.asset("assets/animation_lmp2gl7h.json",height: 300,width: 300),

                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    style:TextStyle(color: Colors.white),
                    decoration:textInputDecoration.copyWith(

                        labelText: "Full Name",
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.person,color:  Color(0xFFefcf18),)
                    ),
                    onChanged: (val){
                      setState(() {
                        fullName = val;
                        print(fullName);
                      });
                    },
                    validator: (val){
                      if(val!.isNotEmpty){
                        return null;
                      }
                      else{
                        return "Name cannot be empty";
                      }
                    },
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    style:TextStyle(color: Colors.white),
                    decoration:textInputDecoration.copyWith(

                        labelText: "Phone",
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.phone,color:  Color(0xFFefcf18),)
                    ),
                    onChanged: (val){
                      setState(() {
                        phone = val;
                        print(phone);
                      });
                    },
                    validator: (val){
                      if(val!.isNotEmpty){
                        return null;
                      }
                      else{
                        return "Phone number cannot be empty";
                      }
                    },
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    style:TextStyle(color: Colors.white),
                    decoration:textInputDecoration.copyWith(

                        labelText: "Address",
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.home,color:  Color(0xFFefcf18),)
                    ),
                    onChanged: (val){
                      setState(() {
                        address = val;
                        print(address);
                      });
                    },
                    validator: (val){
                      if(val!.isNotEmpty){
                        return null;
                      }
                      else{
                        return "Address cannot be empty";
                      }
                    },
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    style:TextStyle(color: Colors.white),
                    decoration:textInputDecoration.copyWith(
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.email,color:  Color(0xFFefcf18),)
                    ),
                    onChanged: (val){
                      setState(() {
                        email = val;
                        print(email);
                      });
                    },
                    validator: (value){
                      return RegExp(
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                          .hasMatch(value!) ? null : "Please enter the valid email";
                    },
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    style:TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration:textInputDecoration.copyWith(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.lock,color:  Color(0xFFefcf18),)
                    ),
                    validator: (val){
                      if(val!.length < 6){
                        return "Password must be at least 6 characters ";
                      }
                      else{
                        return null;
                      }
                    },
                    onChanged: (val){
                      setState(() {
                        password = val;
                        print(password);
                      });
                    },

                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (){
                        register();
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xFFefcf18)
                      ),
                      child: Text("Register",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    ),
                  ),
                  SizedBox(height: 25,),
                  Text.rich(
                      TextSpan(
                        text: "Already have an account!  ",

                        style: TextStyle(
                            color: Colors.white,fontSize: 18
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: "Login now", style: TextStyle(
                              color: Color(0xFFefcf18),fontSize: 20
                          ),
                              recognizer: TapGestureRecognizer()..onTap=(){
                                Get.to(LoginPage());
                              }
                          )
                        ],
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
  void register() async{
    if(_formkey.currentState!.validate()){
      setState(() {
        _isLoading = true;
      });
      await authService.registerUserWithEmailandPassword(fullName, email, password,phone,address).then((value)async{
        if(value == true){

          Get.to(HomeScreen());

        }else{
          showSnackbar(context, value, Colors.red);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }

  }

}

