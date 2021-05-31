
import 'package:blog_app/authentication_service.dart';
import 'package:blog_app/homePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_app/loginregpage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignUp extends StatefulWidget {

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey= GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();


   bool _obscureText = true;

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
 //alert
    showAlert(){
      Alert(
        context:context,
        title: ' Welcome to the Blog App',
        buttons: [
          DialogButton(
            child: Text('Ok'),
            onPressed: ()=>{
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_){
                    return HomePage();
                  }
                ))
            },
          )
        ]
        ).show();
    }
    

   
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title:Text('Blog App',style:TextStyle(fontSize: 20.0)),

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
        children: <Widget>[ Container(
          child: Form(
            key: formKey,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10.0,),
                logo(),
                SizedBox(height: 20.0,),
                Padding(padding:EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child:TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Enter Email Address",
                      prefixIcon: Icon(Icons.email) 
                    ),
                    validator: (value){
                     if(value.isEmpty) {
                        return 'Email is required';
                      }
                      else if(EmailValidator.validate(value)){
                        return null;
                      }
                      else{
                        return "Please enter a valid email";
                      }
                    },
                    // onSaved: (value){
                    //   return _email=value;
                    // },
                  ),
                ),
                
                SizedBox(height: 10.0,),
                Padding(padding:EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child:TextFormField(
                    controller: passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child:
                          Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                      ),
                    ),
                    validator: (value){
                      if(value.isEmpty) {
                        return 'Password is required';
                      }
                      else if(value.trim().length<1) {
                        return "Enter a valid password";
                      }
                      else if(value.length<6) {
                        return "Enter a password 6+ characters";
                      }
                      else {
                        return null;
                      }
                      
                    },
                    // onSaved: (value){
                    //   return _password=value;
                    // },
                  ),
                ),

                SizedBox(height: 10.0,),
                Padding(padding:EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child:ElevatedButton(
                    onPressed: () {
                      validate();
                        context.read<AuthenticationService>().signUp(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                      if(validate()){
                        showAlert();
                      }                
                     
                    },
                    child:Text('Create Account',style: TextStyle(fontSize: 16.0),),
                  ),
                ),

                TextButton(
                  onPressed:()=>{
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_){
                        return LoginRegPage();
                      }
                      ))
                    },
                  child:Text('Already have an account? LogIn',
                  style: TextStyle(fontSize: 16.0),),
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

