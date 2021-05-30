

import 'package:flutter/material.dart';

class Posts extends StatefulWidget {
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      
      body: ListView(
        children: <Widget>[
         Container(
          padding: EdgeInsets.all(32),    
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                 Text("sdjhsa"),
                 
                 
                  
                ],
              
          ),
            ),
        ],
      ),
    );
  }
}