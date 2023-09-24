import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_defense_project/profile.dart';
import 'package:final_defense_project/review_cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class menubar extends StatefulWidget {
  const menubar({Key? key}) : super(key: key);

  @override
  _menubarState createState() => _menubarState();
}

class _menubarState extends State<menubar> {
  String name="Name loading..",email="Email loadin...";

   void getData() async{
     User? user= await FirebaseAuth.instance.currentUser;
     var value= await FirebaseFirestore.instance.collection("user_data").doc(user?.uid).get();
     setState(() {
       name = value.data()!['name'];
       email = value.data()!['email'];
     });
   }
   @override
  void initState(){
     getData();
     super.initState();
   }

  final List drawerMenuListname = const [
    {
      "leading": Icon(
        Icons.account_circle,
        color: Color(0xFF13C0E3),
      ),
      "title": "Profile",
      "trailing": Icon(
        Icons.chevron_right,
      ),
      "action_id": 1,
    },
    {
      "leading": Icon(
        Icons.add_chart_rounded,
        color: Color(0xFF13C0E3),
      ),
      "title": "My Order",
      "trailing": Icon(Icons.chevron_right),
      "action_id": 2,
    },
    {
      "leading": Icon(
        Icons.help,
        color: Color(0xFF13C0E3),
      ),
      "title": "Help",
      "trailing": Icon(Icons.chevron_right),
      "action_id": 3,
    },
    {
      "leading": Icon(
        Icons.settings,
        color: Color(0xFF13C0E3),
      ),
      "title": "Settings",
      "trailing": Icon(Icons.chevron_right),
      "action_id": 4,
    },
    {
      "leading": Icon(
        Icons.animation_rounded,
        color: Color(0xFF13C0E3),
      ),
      "title": "About Us",
      "trailing": Icon(Icons.chevron_right),
      "action_id": 5,
    },
    {
      "leading": Icon(
        Icons.exit_to_app,
        color: Color(0xFF13C0E3),
      ),
      "title": "Log Out",
      "trailing": Icon(Icons.chevron_right),
      "action_id": 6,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
          width: 220,
          child: Drawer(
            child: ListView(children: [
              ListTile(
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://rcpsg.ac.uk/images/people/default.jpg"),
                ),
                title: Text(name, style: const TextStyle(color: Colors.black,),),
                subtitle: Text(email, style: const TextStyle(color: Colors.black,),),
              ),
              const SizedBox(
                height: 1,
              ),
              ...drawerMenuListname.map((sideMenuData) {
                return ListTile(
                  leading: sideMenuData['leading'],
                  title: Text(
                    sideMenuData['title'],
                  ),
                  trailing: sideMenuData['trailing'],
                  onTap: () {
                    Navigator.pop(context);
                    if (sideMenuData['action_id'] == 1) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const profile(),
                        ),
                      );
                    }
                    else if (sideMenuData['action_id'] == 2) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const reviewCart(),
                        ),
                      );
                    }
                    else if (sideMenuData['action_id'] == 6) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      );
                    }
                    // else if (sideMenuData['action_id'] == 4) {
                    //   Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (context) => const SettingScreen(),
                    //     ),
                    //   );
                    // }
                  },
                );
              }).toList(),
            ],),
          ),
        ));
  }
}
