import 'package:blog_app/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/mailgun.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homePage.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final formKey= GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();

  String _name;

  String _email;

  String _subject;


sendMail(String email,String name,String subject) async {
  print("email"+email);
  print("name"+name);
  String username = '$email';
  String password = 'kavi1997ucsc';

 final smtpServer = mailgun(username, password);
  // Create our message.
  final message = Message()
    ..from = Address(username, '$name')
    ..recipients.add('kavindyadewindi12345678@gmail.com')
    ..subject = 'The Blog Post Mobile Application :: 😀 :: ${DateTime.now()}'
    ..text = '$subject\n'
    ..html = "<h1>Test</h1>\n<p>Hey! I wants to connect with you</p>";

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}'); 
    }
  }
  // DONE
}
 
  
  bool validate(){
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

    showAlert(){
      Alert(
        context:context,
        title: ' Successfully Send message.Thank you',
        buttons: [
          DialogButton(
            child: Text('Ok',style: TextStyle(color: Colors.white70),),
            onPressed: ()=>{
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_){
                    return HomePage();
                  }
                ))
            },
            color: Colors.blue[900],
          )
        ]
        ).show();
    }
  return Scaffold(
       appBar: AppBar(
        centerTitle: true,
        title:Text(
            'About',
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
           
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/kk.jpg"),
                  fit: BoxFit.cover,
                ),
            ),
    
          padding: EdgeInsets.all(32),
          
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),            
                  logo(),
                  SizedBox(height: 10),
                  Padding(padding:EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      child:Text("You can create your own blog posts as your wish using this blog application and see all blog posts creted by all users.If you have any question please ask me."),
                  ),
                  Padding(padding:EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      child:Text("WANT TO GET IN TOUCH!",
                      style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.w800,color: Colors.black87),),
                  ),
                  SizedBox(height: 10),
                  Padding(padding:EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      child:TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "Your Name",
                          prefixIcon: Icon(Icons.person),
                        ),
                        cursorColor: Colors.blue[900],
                        validator: (value){
                          if(value.isEmpty) {
                            return 'This field is required';
                          }
                          else if(value.trim().length<1) {
                            return "Enter a valid Name";
                          }
                          else if(value.length<3) {
                            return "Enter a valid Name";
                          }
                          else {
                            return null;
                          }
                          
                        },
                        // onSaved: (value){
                        //   return _name=value.trim();
                        // },
                        
                      ),
                  ),
                  SizedBox(height: 10),
                  Padding(padding:EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      child:TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Your Email Address",
                          prefixIcon: Icon(Icons.email),
                        ),
                        cursorColor: Colors.blue[900],
                        validator: (value){
                          if(value.isEmpty) {
                            return 'This field is required';
                          }
                          else if(EmailValidator.validate(value)){
                            return null;
                          }
                          else {
                            return 'Please enter a valid email';
                          }
                          
                        },
                        //  onSaved: (value){
                        //   return _email=value;
                        // },
                        
                      ),
                  ),
                  SizedBox(height: 10),
                  Padding(padding:EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      child:TextFormField(
                        controller: subjectController,
                        decoration: InputDecoration(
                          hintText: "Subject",
                          prefixIcon: Icon(Icons.message),
                        ),
                        cursorColor: Colors.blue[900],
                        validator: (value){
                          if(value.isEmpty) {
                            return 'This field is required';
                          }
                          else if(value.trim().length<1) {
                            return "Enter a valid Subject";
                          }
                          else if(value.length<5) {
                            return "Enter a valid Subject";
                          }
                          else {
                            return null;
                          }
                          
                        },
                        // onSaved: (value){
                        //   return _subject=value;
                        // },
                        
                      ),
                  ),
                     
                  SizedBox(height: 10),
                  Padding(padding:EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      child:ElevatedButton(
                      child: Text('Send message',style: TextStyle(fontSize: 16.0),),
                      onPressed: (){ 

                        _email=emailController.text;
                        _subject=subjectController.text;
                        _name=nameController.text;

                        sendMail(_email,_name,_subject);
                        if(validate()){
                          
                          showAlert();
                        }                     
                      },
                      style: ButtonStyle(
                        backgroundColor:MaterialStateProperty.all<Color>(Colors.blue[900]),
                        shadowColor: MaterialStateProperty.all<Color>(Colors.grey[700]),
                      ),
                    ),
                  ),
                  
                  
                ],
              
          ),
          ),
        ),
      ],
    ),
  );

  }

   Widget logo(){
    return Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
      image: DecorationImage(
        image: AssetImage('assets/logo.jpg'),
          fit: BoxFit.fill
        ),
      ),
    );
  }
}