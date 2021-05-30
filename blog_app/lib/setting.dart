import 'package:flutter/material.dart';



class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      
      body: Container( 
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/kk.jpg"),
              fit: BoxFit.cover,
            ),
          ),
      ),
    );
  }

 
  

   
}