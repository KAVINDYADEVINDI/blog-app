
import 'package:blog_app/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_app/signUp.dart';
import 'package:email_validator/email_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginRegPage extends StatelessWidget {

  final formKey= GlobalKey<FormState>();
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
      appBar: AppBar(
        centerTitle: true,
        title:Text(
            'Blog App',
            style: GoogleFonts.pacifico(
              textStyle: Theme.of(context).textTheme.headline4,
              fontSize: 24,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
              
            ),
        ),
        

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
                Row(children: <Widget>[
                    Expanded(
                      child: new Container(
                          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Divider(
                            color: Colors.black,
                            height: 50,
                          )),
                    ),
                      SizedBox(height: 10.0,),
                      Padding(padding:EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        child:Text(
                          "Let's Get Started!",
                          style: GoogleFonts.pattaya(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            
                          ),
                        ),
                      ),
        
                    Expanded(
                      child: new Container(
                          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Divider(
                            color: Colors.black,
                            height: 50,
                          )),
                    ),
                  ]
                ),
        
                
                SizedBox(height: 20.0,),
                Padding(padding:EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child:TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Enter Email Address",
                      prefixIcon: Icon(Icons.email),
                     
                    ),
                    cursorColor: Colors.blue[900],
                    validator: (value){
                     if(value.isEmpty) {
                        return 'Email is required';
                      }
                      else if(EmailValidator.validate(value)){
                        return null;
                      }
                      else if(!RegExp("^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*").hasMatch(value)){
                       return 'Enter a valid email address';
                      }
                      else{
                        return "Please enter a valid email";
                      }
                    },
                  ),
                ),
                
                SizedBox(height: 10.0,),
                Padding(padding:EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child:TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      prefixIcon: Icon(Icons.lock_outline),
                       
                    ),
                    obscureText: true,
                    cursorColor: Colors.blue[900],
                    validator: (value){
                      if(value.isEmpty) {
                        return 'Password is required';
                      }
                      else if(value.trim().length<1) {
                        return "Enter a valid password";
                      }
                      else{
                        return null;
                      }
                      
                    },
                  ),
                ),

                SizedBox(height: 10.0,),
                Padding(padding:EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child:ElevatedButton(
                    onPressed: () {
                      validate();
                      context.read<AuthenticationService>().signIn(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                      
                      
                    },
                    style: ButtonStyle(
                      backgroundColor:MaterialStateProperty.all<Color>(Colors.blue[900]),
                      shadowColor: MaterialStateProperty.all<Color>(Colors.grey[700]),
                    ),
                    child:Text('Login',style: TextStyle(fontSize: 16.0),),
                  ),
                ),

                TextButton(
                  onPressed:()=>{
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_){
                        return SignUp();
                      }
                      ))
                  },
                  child:Text('Not have an account? Create Account',
                  style: TextStyle(fontSize: 16.0,color: Colors.blue[900]),softWrap: true,),
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