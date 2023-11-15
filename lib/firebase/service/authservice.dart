import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:meal_monkey/firebase/service/database_services.dart';


class AuthService{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future loginWithEmailandPassword(String email ,String password) async{


    try{
      User user = (await firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user!;
      if(user != null){


        return true;
      }
    }on FirebaseAuthException catch(e){
      // print(e);
      return e.message;
    }
  }


  Future registerUserWithEmailandPassword(String fullName,String email ,String password,String address ,String phone) async{


    try{
      User user = (await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user!;
      if(user != null){
        await DatabaseService(uid: user.uid).savingUserData(fullName, email, password,address,phone);

        return true;
      }
    }on FirebaseAuthException catch(e){
      // print(e);
      return e.message;
    }
  }

}