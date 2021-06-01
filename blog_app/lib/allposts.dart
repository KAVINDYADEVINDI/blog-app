
import 'package:blog_app/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Posts extends StatefulWidget {
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:Text('Home Page',style:TextStyle(fontSize: 20.0)),
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
                       new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Text(
                            document['date'],
                            style:TextStyle(color: Colors.grey[400],fontSize: 14.0),textAlign: TextAlign.center,
                            
                          ),
                          Text(
                            document['time'],
                            style:TextStyle(color: Colors.grey[400],fontSize: 14.0),textAlign: TextAlign.center,
                          ),
                        ],
                      ),

                      SizedBox(height: 10.0,),

                      Image.network(document['image'],fit: BoxFit.cover,),
                      
                      SizedBox(height: 10.0,),

                      Divider(color:Colors.grey[400]),
                      Text(
                        document['description'],
                        style:Theme.of(context).textTheme.subtitle1,
                        textAlign: TextAlign.left,
                      ),
                        
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