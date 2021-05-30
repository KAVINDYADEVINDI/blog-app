
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Posts extends StatefulWidget {
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      
       body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Post').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
  
          return ListView(
            children: snapshot.data.docs.map((document) {
              return Container(
                child: Center(child: Text(document['date'])),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}