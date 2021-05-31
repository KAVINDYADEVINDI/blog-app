import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';



class Setting extends StatelessWidget {
  final formKey= GlobalKey<FormState>();

  
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