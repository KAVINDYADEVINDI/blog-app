
import 'package:cloud_firestore/cloud_firestore.dart';
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
              return Card(
                  elevation: 10.0,
                  margin: EdgeInsets.all(15.0),

                  child: Container(
                    padding: EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children:<Widget> [
                        child:Row(
                          Text(
                          document['date'],
                          style:Theme.of(context).textTheme.subtitle1,
                          textAlign: TextAlign.left,
                        ),
                         Text(
                          document['time'],
                          style:Theme.of(context).textTheme.subtitle1,
                          textAlign: TextAlign.center,
                        ),
                        )
                      ],
                    ),),
                );
                // child: Center(child: Text(document['description'])),
            
            }).toList(),
          );
        },
      ),
    );
  }
}