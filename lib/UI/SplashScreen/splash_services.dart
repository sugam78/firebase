
import 'dart:async';

import 'package:all_firebase/UI/Authentatication/login_screen.dart';
import 'package:all_firebase/UI/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashServices{

  void isLogin(BuildContext context){
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if(user!=null){
      Timer(Duration(seconds: 3), () { Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage())); });
    }
    else{
      Timer(Duration(seconds: 3), () { Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen())); });
    }
  }

}