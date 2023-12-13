import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:meal_monkey/Advanced/provider/user_provider.dart';
import 'package:meal_monkey/Advanced/screens/login_screen.dart';
import 'package:meal_monkey/UI/allStores.dart';
import 'package:meal_monkey/firebase_options.dart';
import 'package:meal_monkey/onboard/onboarding_screens.dart';
import 'package:meal_monkey/screens/home_screen.dart';
import 'package:meal_monkey/screens/login_page.dart';
import 'package:meal_monkey/screens/register_page.dart';
import 'package:meal_monkey/screens/splash_screen.dart';
import 'package:meal_monkey/screens/splash_screen_main.dart';
import 'package:meal_monkey/testing/home_screen.dart';
import 'package:meal_monkey/widgets/nav_bar.dart';
import 'package:meal_monkey/widgets/ratings_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? isviewed;
Future<void>_firebaseMessagingBackgroundHandler(RemoteMessage message)async{
  print("Handling a background message:${message.messageId}");
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message){
    print("Got a message whilst in the foreground!");
    print("Message data :${message.data}");
    if(message.notification != null){
      print("Message also contained a notification:${message.notification}");

    }
  });
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startStreaming();
  }

  late ConnectivityResult result;
  late StreamSubscription subscription;
  var isConnected = false;

  checkInternet() async {
    result = await Connectivity().checkConnectivity();
    if (result != ConnectivityResult.none) {
      isConnected = true;
    } else {
      isConnected = false;
      showDialogBox();
    }
    setState(() {});
  }

  showDialogBox() {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text("No Internet"),
              content: Text("Please check your internet connection"),
              actions: [
                CupertinoButton.filled(child: Text("Retry"), onPressed: () {}),
              ],
            ));
  }

  startStreaming() {
    subscription = Connectivity().onConnectivityChanged.listen((event) async {
      checkInternet();
    });
  }

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, AsyncSnapshot<User?> user) {
                if (user.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  );
                } else if (user.hasData) {
                  return SplashScreenMain();
                  //return const SellScreen();
                } else {
                  return Splashscreen();
                }
              })),
    );
  }
}
