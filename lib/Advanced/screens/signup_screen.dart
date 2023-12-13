import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_monkey/Advanced/components/page_title_bar.dart';
import 'package:meal_monkey/Advanced/components/under_part.dart';
import 'package:meal_monkey/Advanced/components/upside.dart';
import 'package:meal_monkey/Advanced/resources/auth_methods.dart';
import 'package:meal_monkey/Advanced/screens/login_screen.dart';
import 'package:meal_monkey/Advanced/widgets/rounded_button.dart';
import 'package:meal_monkey/Advanced/widgets/rounded_input_field.dart';
import 'package:meal_monkey/Advanced/widgets/rounded_password_field.dart';
import 'package:meal_monkey/utils/utils.dart';
import 'package:meal_monkey/widgets/nav_bar.dart';

import '../../screens/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      phone: _phoneController.text,
      address: _addressController.text,
      file: _image!,
    );
    if (res != "success") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NavBarRoots()));
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                const Upside(
                  imgUrl: "assets/login.json",
                ),
                const PageTitleBar(title: 'Create New Account'),
                Padding(
                  padding: const EdgeInsets.only(top: 320.0),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Stack(
                          children: [
                            _image != null
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundImage: MemoryImage(_image!))
                                : const CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                        "https://cdn2.iconfinder.com/data/icons/avatars-99/62/avatar-370-456322-512.png")),
                            Positioned(
                                bottom: -10,
                                left: 60,
                                child: IconButton(
                                  onPressed: () {
                                    selectImage();
                                  },
                                  icon: const Icon(Icons.add_a_photo),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Form(
                          child: Column(
                            children: [
                              RoundedInputField(
                                hintText: "Name",
                                icon: Icons.person,
                                controller: _usernameController,
                              ),
                              RoundedInputField(
                                  hintText: "Email",
                                  icon: Icons.email,
                                  controller: _emailController),
                              RoundedInputField(
                                  hintText: "Phone",
                                  icon: Icons.phone,
                                  controller: _phoneController),
                              RoundedInputField(
                                  hintText: "Address",
                                  icon: Icons.home,
                                  controller: _addressController),
                              RoundedPasswordField(
                                controller: _passwordController,
                              ),
                              Container(
                                child: _isLoading
                                    ? const Center(
                                        child: SpinKitThreeBounce(
                                        color: Color(0xFFefcf18),
                                      ))
                                    : RoundedButton(
                                        text: 'REGISTER',
                                        press: () {
                                          signUpUser();
                                        }),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              UnderPart(
                                title: "Already have an account?",
                                navigatorText: "Login here",
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()));
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
