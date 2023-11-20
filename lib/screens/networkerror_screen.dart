import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ConnectionChecker extends StatefulWidget {
  const ConnectionChecker({super.key});

  @override
  State<ConnectionChecker> createState() => _ConnectionCheckerState();
}

class _ConnectionCheckerState extends State<ConnectionChecker> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startStreaming();
  }
  late ConnectivityResult result;
  late StreamSubscription subscription;
  var isConnected = false;
  checkInternet() async{
    result = await Connectivity().checkConnectivity();
    if(result != ConnectivityResult.none){
      isConnected = true;
    }else{
      isConnected = false;
      showDialogBox();
    }
    setState(() {

    });
  }
  showDialogBox(){
    showDialog(context: context, builder:(context)=>CupertinoAlertDialog(
      title: Text("No Internet"),
      content: Text("Please check your internet connection"),
      actions: [
        CupertinoButton.filled(child: Text("Retry"), onPressed:(){}),
      ],
    ));
  }
  startStreaming(){
    subscription = Connectivity().onConnectivityChanged.listen((event) async{
      checkInternet();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );


  }
}
