import 'package:final_defense_project/splash_services.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget{
  const SplashScreen({key}) : super(key : key);

  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{

  SplashServices splashScreen = SplashServices();
  @override
  void initState(){
    super.initState();
    splashScreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context){
    return const Scaffold(
      backgroundColor: Color(0xff133337),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 250,),
            Image(image: AssetImage("assets/first.gif"),height: 240,width: 400,fit: BoxFit.cover),
            SizedBox(height: 30,),
            Text("Amar Pharmacy", style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold , color: Colors.white),),
          ],
        ),
        //child: Text("Amar Pharmacy", style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold , color: Colors.white),),
      ),
    );
  }
}