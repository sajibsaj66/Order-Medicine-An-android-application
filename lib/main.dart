


import 'package:final_defense_project/Provider/product_provider.dart';
import 'package:final_defense_project/Provider/review_cart_provider.dart';

import 'package:final_defense_project/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (context)=> ProductProvider(),
        ),
        ChangeNotifierProvider<ReviewCartProvider>(
          create: (context)=> ReviewCartProvider(),
        ),
  ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
        initialRoute: 'login_page',
        routes: {'login_page': (context) => const SplashScreen()},
    ),
  ),
  );
}

