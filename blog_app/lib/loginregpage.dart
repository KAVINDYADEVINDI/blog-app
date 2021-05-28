import 'package:flutter/material.dart';

class LoginRegPage extends StatefulWidget {
  @override
  _LoginRegPageState createState() => _LoginRegPageState();
}
enum FormType {
    login,
    register
}

class _LoginRegPageState extends State<LoginRegPage> {

  
  final formKey= GlobalKey<FormState>();
  FormType _formType=FormType.login;
  String _email="";
  String _password="";
  
  void validateAndSave(){

  }

 void moveToReg() {
  formKey.currentState.reset();//value in the form is reset

    setState(() {
          _formType=FormType.register;
    });
}

  void moveToLogin(){
    formKey.currentState.reset();//value in the form is reset

    setState(() {
          _formType=FormType.login;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

      body: Container(
        margin: EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: 
              createInputs() + createButtons(),

          ),
        ),
      ),
    );
  }

  List<Widget>createInputs(){
    return[
      SizedBox(height: 10.0,),
      logo(),
      SizedBox(height: 20.0,),

      Padding(padding:EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: "Enter Email Address"  
          ),
          validator: (value){
            return value.isEmpty? 'Email is required': null;
          },
          onSaved: (value){
            return _email=value;
          },
        ),
      ),
      SizedBox(height: 10.0,),
      Padding(padding:EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        child: TextField(
          decoration: InputDecoration(
              hintText: "Enter Password"  
          ),
        ),
      ),
    ];

  }

  Widget logo(){
    return Container(
      width: 200,
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

List<Widget>createButtons(){
    if(_formType== FormType.login){
        return [
        Padding(padding:EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child:ElevatedButton(
            onPressed: validateAndSave,
            child:Text('Login',style: TextStyle(fontSize: 16.0),),
        
          ),
        ),
        

        FlatButton(
          onPressed: moveToReg,
          child:Text('Not have an account? Create Account',
            style: TextStyle(fontSize: 16.0),),textColor: Colors.blueAccent,
        ),
      ];
    }
    else{
      return [
        Padding(padding:EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child:ElevatedButton(
            onPressed: validateAndSave,
            child:Text('Create Account',style: TextStyle(fontSize: 16.0),),
        
          ),
        ),
        

        FlatButton(
          onPressed: moveToLogin,
          child:Text('Already have an account? Login',
            style: TextStyle(fontSize: 16.0),),textColor: Colors.blueAccent,
        ),
      ];

    }

  }
}
