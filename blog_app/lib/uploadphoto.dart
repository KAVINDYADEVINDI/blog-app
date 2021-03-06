import 'dart:io';
import 'package:blog_app/authentication_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:blog_app/api/firebase_api.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'homePage.dart';
import 'package:google_fonts/google_fonts.dart';

//import 'homePage.dart';

class UploadImage extends StatefulWidget {
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final formKey= GlobalKey<FormState>();
  
  UploadTask task;
  File file;
  String _myvalue;

  bool validateAndSave(){
    final form =formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    else{
      return false;
    }
  }
  
  void savetoDatabase(String url) {
    var dbTimeKey= DateTime.now();
    var formatDate=DateFormat('MMM d,yyyy');
    var formatTime=DateFormat('EEEE,hh:mm aaa');

    String date=formatDate.format(dbTimeKey);
    String time=formatTime.format(dbTimeKey);

    FirebaseFirestore.instance
                .collection('Post')
                .add({"image":url,
      "description":_myvalue,
      "date":date,
      "time":time,});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:Text(
            'Add Blog Post',
            style: GoogleFonts.pacifico(
              textStyle: Theme.of(context).textTheme.headline4,
              fontSize: 24,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
              
            ),
        ),
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
      body: ListView(
        children: <Widget>[
         Container(
          padding: EdgeInsets.all(32),
          
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),            
                  logo(),
                  FloatingActionButton(
                    backgroundColor: Colors.blue[800],
                    foregroundColor: Colors.white70,
                    autofocus: true,
                    onPressed: selectFile,
                    tooltip: 'Add Image',
                    child: Icon(Icons.add_a_photo),
                  ),
                 
                  SizedBox(height: 20),
                  Padding(padding:EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      child:TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter Description",
                          prefixIcon: Icon(Icons.details),
                        ),
                        cursorColor: Colors.blue[900],
                        validator: (value){
                          if(value.isEmpty) {
                            return 'This field is required';
                          }
                          else if(value.trim().length<1) {
                            return "Enter a valid description";
                          }
                          else if(value.length<6) {
                            return "Enter a valid description";
                          }
                          else {
                            return null;
                          }
                          
                        },
                        onSaved: (value){
                          return _myvalue=value;
                        },
                      ),
                    ),
                     
                  SizedBox(height: 10),
                  Padding(padding:EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    child:ElevatedButton(
                    child: Text('Upload Post',style: TextStyle(fontSize: 16.0),),
                    onPressed: ()=>{
                      validateAndSave(),
                      uploadFile(),
                      
                    },
                    style: ButtonStyle(
                      backgroundColor:MaterialStateProperty.all<Color>(Colors.blue[900]),
                      shadowColor: MaterialStateProperty.all<Color>(Colors.grey[700]),
                    ),
                    
                    ),),
                  SizedBox(height: 50,width: 100,),
                  
                  task != null ? buildUploadStatus(task) : Container(),
                  
                ],
              
          ),
            ),
        ),],
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path;

    setState(() => file = File(path));
  }
  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file);
    setState(() {});

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    String url=urlDownload.toString();
    print('Download-Link: $urlDownload');
    savetoDatabase(url);
  }//
  
  
  Widget logo(){
    return Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(
        image: AssetImage('assets/logo.jpg'),
          fit: BoxFit.fill
        ),
      ),
    );
  }
  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
    
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);
            
            return CircularPercentIndicator(
                  radius: 150.0,
                  lineWidth: 7.0,
                  percent: 1.0,
                  animation: true,
                  center: new Text("$percentage%"),
                  progressColor: Colors.green,
                  animationDuration: 5000,
                  footer: new TextButton(
                  onPressed:()=>{
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_){
                        return HomePage();
                      }
                    ))
                  } ,
                   
                  child: Text("Added Blog Post,See Home page",style: TextStyle(fontSize: 16.0,color: Colors.blue[900]),softWrap: true,)),
                  
                  circularStrokeCap: CircularStrokeCap.round,
            );
           
           
            
          } else {
            return Container();
          }
          
        },
       
        
        
  );

 

}