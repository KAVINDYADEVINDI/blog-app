import 'package:blog_app/authentication_service.dart';
import 'package:blog_app/setting.dart';
import 'package:blog_app/uploadphoto.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentindex = 0;

  List tabs=[
    null,
    UploadImage(),
    Setting(),
  ];

 

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:Text('Blog Post',style:TextStyle(fontSize: 20.0)),
        actions:<Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              context.read<AuthenticationService>().signOut();
            },
              //child: Text("Sign out"),
          ),
        ],
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
         
          items: const <BottomNavigationBarItem>[
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
         // type: BottomNavigationBarType.shifting,  
          
          onTap:(index){
            setState(() {
              currentindex=index;          
            });
            
          } , 

          backgroundColor: Colors.lightBlueAccent[300],
          //fixedColor: Colors.blue[900],
          elevation: 63.0,
          // selectedItemColor:Colors.blue[800] ,
          // unselectedItemColor: Colors.black87,
          selectedLabelStyle: TextStyle(fontSize: 17.0),
          unselectedLabelStyle: TextStyle(color:Colors.black87,fontSize: 14.0),
          selectedIconTheme: IconThemeData (
            color: Colors.blue[800],
            opacity: 1.0,
            size: 35
          ),
          unselectedIconTheme: IconThemeData (
              color: Colors.black87,
              opacity: 1.0,
              size: 25
          ),
          
          
        ),
    
    );
  
  }
}