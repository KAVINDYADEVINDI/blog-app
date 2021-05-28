import 'package:blog_app/homePage.dart';
// import 'package:blog_app/loginregpage.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Blog App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      debugShowCheckedModeBanner:false ,//delete banner in appbar
      
      home:HomePage(),
      
    );
  }
}
