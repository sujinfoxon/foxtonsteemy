import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:meal_monkey/UI/allStores.dart';
import 'package:meal_monkey/firebase_options.dart';
import 'package:meal_monkey/onboard/onboarding_screens.dart';
import 'package:meal_monkey/screens/home_screen.dart';
import 'package:meal_monkey/screens/login_page.dart';
import 'package:meal_monkey/screens/register_page.dart';
import 'package:meal_monkey/testing/home_screen.dart';
import 'package:meal_monkey/widgets/nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
int? isviewed;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:  StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, AsyncSnapshot<User?> user) {
            if (user.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              );
            } else if (user.hasData) {
              return   HomeScreen();
              //return const SellScreen();
            } else {
              return  OnBoard();
            }
          })
    );
  }
}
