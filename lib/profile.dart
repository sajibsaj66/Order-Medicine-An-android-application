import 'package:final_defense_project/home_page.dart';
import 'package:flutter/material.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile'),
      leading: BackButton(
        onPressed:(){
          Navigator.push(context,MaterialPageRoute(builder: (context)=> home()));
        },
      ),
      //backgroundColor: Colors.transparent,
      elevation: 0,
      ),
      body: const Center(child: Text('Demo Profile')),
    );
  }
}
