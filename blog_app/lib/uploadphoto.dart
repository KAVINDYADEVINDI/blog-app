
import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:blog_app/api/firebase_api.dart';
import 'package:blog_app/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

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
  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file.path) : 'No File Selected';

    return Scaffold(
      
      body: ListView(
        children: <Widget>[
         Container(
          padding: EdgeInsets.all(32),
          
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [            
                  logo(),
                  ButtonWidget(
                    text: 'Select File',
                    icon: Icons.attach_file,
                    onClicked: selectFile,
                  ),
                  SizedBox(height: 8),
                  Text(
                    fileName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,),
                  ),
                  
                  SizedBox(height: 38),
                  ButtonWidget(
                    text: 'Upload File',
                    icon: Icons.cloud_upload_outlined,
                    onClicked: uploadFile,
                  ),
                  SizedBox(height: 20),
                  
                  task != null ? buildUploadStatus(task) : Container(),

                  SizedBox(height: 20),
                  Padding(padding:EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      child:TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter Description",
                          prefixIcon: Icon(Icons.details),
                        ),
                        validator: (value){
                          if(value.isEmpty) {
                            return 'This field is required';
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
                  SizedBox(height: 10.0,),
                  Padding(padding:EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    child:ElevatedButton(
                      onPressed: () {             
                       validateAndSave();
                      },
                      child:Text('Submit Post',style: TextStyle(fontSize: 16.0),),
                    ),
                  ),
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

    print('Download-Link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
  );

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
}