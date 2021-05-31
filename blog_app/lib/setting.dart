import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/mailgun.dart';


class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final formKey= GlobalKey<FormState>();

  String _name;

  String _email;

  String _subject;

//   main() async {
//   String username = kavindyadewindi12345678@gmail.com;
//   String password = kavi1997ucsc;
//   final smtpServer = gmail(username, password); 

//   // Create our email message.
//   final message = Message()
//     ..from = Address(username)
//     ..recipients.add('dest@example.com') //recipent email
//     ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com']) //cc Recipents emails
//     ..bccRecipients.add(Address('bccAddress@example.com')) //bcc Recipents emails
//     ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}' //subject of the email
//     ..text = 'This is the plain text.\nThis is line 2 of the text part.'
//      //body of the email

//   try {
//     final sendReport = await send(message, smtpServer);
//     print('Message sent: ' + sendReport.toString()); //print if the email is sent
//   } on MailerException catch (e) {
//     print('Message not sent. \n'+ e.toString()); //print if the email is not sent
//     // e.toString() will show why the email is not sending
//   }
// } 
  
  
  bool validate(){
    final form =formKey.currentState;
    if(form.validate()){
      return true;
    }
    else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      
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
                      style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.w400,color: Colors.black54),),
                  ),
                  SizedBox(height: 10),
                  Padding(padding:EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      child:TextFormField(
                        decoration: InputDecoration(
                          hintText: "Your Name",
                          prefixIcon: Icon(Icons.person),
                        ),
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
                        onSaved: (value){
                          return _name=value;
                        },
                        
                      ),
                  ),
                  SizedBox(height: 10),
                  Padding(padding:EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      child:TextFormField(
                        decoration: InputDecoration(
                          hintText: "Your Email Address",
                          prefixIcon: Icon(Icons.email),
                        ),
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
                         onSaved: (value){
                          return _email=value;
                        },
                        
                      ),
                  ),
                  SizedBox(height: 10),
                  Padding(padding:EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      child:TextFormField(
                        decoration: InputDecoration(
                          hintText: "Subject",
                          prefixIcon: Icon(Icons.message),
                        ),
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
                        onSaved: (value){
                          return _subject=value;
                        },
                        
                      ),
                  ),
                     
                  SizedBox(height: 10),
                  Padding(padding:EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      child:ElevatedButton(
                      child: Text('Send message'),
                      onPressed: ()=>{ 
                        validate()  
                      },
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
      image: DecorationImage(
        image: AssetImage('assets/logo.jpg'),
          fit: BoxFit.fill
        ),
      ),
    );
  }
}