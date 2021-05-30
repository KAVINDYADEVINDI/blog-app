
import 'package:flutter/material.dart';



class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      
      body: Container( 
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pinterest.com%2Fpin%2F582512533026278262%2F&psig=AOvVaw2T4F8Q_8b6neumYXJqhKGH&ust=1622392611425000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCIiXx7fR8PACFQAAAAAdAAAAABAD"),
              fit: BoxFit.cover,
            ),
          ),
      ),
    );
  }

 
  

   
}