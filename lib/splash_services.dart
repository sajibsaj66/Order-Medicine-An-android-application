import 'dart:async';
import 'package:final_defense_project/login_page.dart';
import 'package:flutter/material.dart';


class SplashServices {
  void isLogin(BuildContext context) {
    Timer(const Duration(seconds: 5),
        ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()))
    );
  }
}