
import 'package:blog_app/setting.dart';
import 'package:blog_app/uploadphoto.dart';

import 'package:flutter/material.dart';


import 'allposts.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentindex = 0;

  List tabs=[
    Posts(),
    UploadImage(),
    Setting(),
  ];

 

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body:tabs[currentindex],   
       bottomNavigationBar: BottomNavigationBar(
         currentIndex: currentindex,
          items:[
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home,),        
              
            ),
            BottomNavigationBarItem(
              label: "Add Blog",
              icon: Icon(Icons.cloud_upload,),  
            ),
             BottomNavigationBarItem(
              label: "About",
              icon: Icon(Icons.people_alt_outlined,),  
            ),
          ],
         // type: BottomNavigationBarType.shifting,  
          
          onTap:(index){
            setState(() {
              currentindex=index;          
            });
            
          } , 

          backgroundColor: Colors.lightBlueAccent[300],
          fixedColor: Colors.blue[900],
          elevation: 16.0,
          // selectedItemColor:Colors.blue[800] ,
          // unselectedItemColor: Colors.black87,
          // selectedLabelStyle: TextStyle(fontSize: 17.0),
          // unselectedLabelStyle: TextStyle(color:Colors.black87,fontSize: 14.0),
          // selectedIconTheme: IconThemeData (
          //   color: Colors.blue[800],
          //   opacity: 1.0,
          //   size: 35
          // ),
          // unselectedIconTheme: IconThemeData (
          //     color: Colors.black87,
          //     opacity: 1.0,
          //     size: 25
          // ),
          
          
        ),
    
    );
  
  }
}