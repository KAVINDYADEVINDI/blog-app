
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentindex=0;
  List tabs=[
    logoutUser(),
  ];

  void logoutUser(){
    setState(() {
          
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:Text('Home',style:TextStyle(fontSize: 20.0)),

        elevation: 13.0, //shadow of the bottom
          // backgroundColor: Colors.blueAccent[1000],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue,Colors.black],
              begin:Alignment.topCenter ,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),

      body:tabs[currentindex],

       bottomNavigationBar: BottomNavigationBar(
         currentIndex: currentindex,
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home,),
              
            ),
            BottomNavigationBarItem(
              label: "Add Blog",
              icon: Icon(Icons.cloud_upload,),  
            ),
             BottomNavigationBarItem(
              label: "Settings",
              icon: Icon(Icons.settings,),  
            ),
          ],
          backgroundColor: Colors.blue[100],
          fixedColor: Colors.blue[900],
          elevation: 13.0,
          selectedLabelStyle: TextStyle(fontSize: 17.0),
          mouseCursor: SystemMouseCursors.click,
          unselectedLabelStyle: TextStyle(color:Colors.black87,fontSize: 14.0),
          selectedIconTheme: IconThemeData (
            color: Colors.blue[900],
            opacity: 1.0,
            size: 35
          ),
          unselectedIconTheme: IconThemeData (
              color: Colors.black87,
              opacity: 0.5,
              size: 25
          ),
          
          
        ),
    
    );
  }
}