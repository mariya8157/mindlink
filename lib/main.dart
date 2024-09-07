import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'feature/detailsAdding/screen/homeScreen.dart';
import 'firebase_options.dart';
var width;
var height;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: HomeScreen(),

    );
  }
}


