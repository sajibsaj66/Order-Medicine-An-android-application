//import 'package:defence_project/signup_page.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:final_defense_project/home_page.dart';
import 'package:final_defense_project/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState  createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey= GlobalKey<FormState>();
  final TextEditingController _email= TextEditingController();
  final TextEditingController _pass= TextEditingController();
  final _auth= FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/login.png'),fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35,top: 150),
              child: const Text('Welcome\nBack',style: TextStyle(color: Colors.white,fontSize: 33)
                , ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.5,right: 35,left: 35),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: false,
                        controller: _email,
                        validator: (value){
                          if(value!.isEmpty){
                            return ("Email Addressed Required");
                          }
                          if(!EmailValidator.validate(value,true)) {
                            return ("Enter Valid Email Addressed");
                          }
                          return null;
                        },
                        // validator: (value){
                        //   if(value!.isEmpty){
                        //     return ("Please Enter Your Email");
                        //   }
                        //   if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                        //     return ("Pleas Enter a Valid Email");
                        //   }
                        //   return null;
                        // },
                        onSaved: (value){
                          _email.text=value!;
                        },
                        textInputAction: TextInputAction.next,
                        //controller: TextEditingController(),
                        decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: const Icon(Icons.mail),
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        autofocus: false,
                        controller: _pass,
                        validator: (value){
                          if(value!.isEmpty){
                            return ("Password is required for Signing");
                          }
                          if(value.length<6) {
                            return ("Minimum 6 character Required");
                          }
                          // if(!RegExp(r'^.{5,}&').hasMatch(value)){
                          //   return ("Password required minimum 6 character");
                          // }
                        },
                        onSaved: (value){
                          _pass.text=value!;
                        },
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                        //controller: TextEditingController(),
                        decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const SizedBox(
                        width: 350,
                        child: Text(
                          'Forgot your password?',
                          textAlign: TextAlign.right,
                          style: TextStyle(decoration: TextDecoration.underline,fontSize: 14),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MaterialButton(
                        color: Colors.lightBlue,
                        minWidth: 120,
                        height: 50,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        onPressed: (){
                          if(_formkey.currentState!.validate()){
                            _auth.signInWithEmailAndPassword(email: _email.text, password: _pass.text)
                                .then((uid) =>{
                                  Fluttertoast.showToast(msg: "Login Successfully"),
                            Navigator.push(context,MaterialPageRoute(builder: (context)=> home())),
                            }).catchError((e){
                              Fluttertoast.showToast(msg: "Invalid Email or Password");
                            });
                          }
                        },
                        child: const Text('Login',style: TextStyle(color: Colors.white,fontSize: 20),),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      // Text('Don\'t have an account?',
                      //   style: TextStyle(color: Colors.grey.shade700,fontSize: 20),),
                      // GestureDetector(
                      //   child: Text('Create Account',
                      //     style: TextStyle(color: Colors.black,fontSize: 20),),
                      //   onTap: (){
                      //     Navigator.push(context,MaterialPageRoute(builder: (context)=> signup()));
                      //   },
                      // )
                      RichText(text: TextSpan(
                        text: 'Don\'t have an account?',
                        style: TextStyle(color: Colors.grey.shade700,fontSize: 18),
                        children: [TextSpan(
                          text: ' Create',
                          style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()..onTap=(){
                              Navigator.push(context,MaterialPageRoute(builder: (context)=> const signup()));
                            }
                          )
                        ]
                      )
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
