import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
TextEditingController emailcontroller=TextEditingController();
TextEditingController passwordcontroller=TextEditingController();
final _formKey=GlobalKey<FormState>();
bool _isnotLogin=true;

 void onsave()  async
 {
    final isValid=_formKey.currentState.validate();
      FocusScope.of(context).unfocus();
    try
    {
    if(isValid)
    {
      _formKey.currentState.save();
     
      if(_isnotLogin)
      {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.value.text, 
          password: passwordcontroller.value.text
          );
      }
      else
      {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email:  emailcontroller.value.text, 
            password: passwordcontroller.value.text);
         
      }
    }  
      
    }
    catch(error)
    {
      print(error);
      
    }
    
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
      children:<Widget>[
      Padding(
      padding: const EdgeInsets.only(top:0.0),
      child: Container(
      height:200,
      width: double.infinity,
      child:  Image(image: AssetImage("assets/images/logo.PNG"),),), ),
      Expanded(
      child:Container(
      decoration:BoxDecoration(
      color: Colors.white,
      borderRadius:BorderRadius.only(
      topRight:Radius.circular(60.0),
      )
      ), 
      child: Form(
      key: _formKey,
      child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 50),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  key: ValueKey('email'),
                  controller: emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    labelText:"Email" ),
                     validator: (value) {
                    if (!value.contains('@')) {
                      return 'Please enter a valid e-mail address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                   emailcontroller.text = value;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  key: ValueKey('password'),
                   obscureText: true,
                    decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_open_outlined,),
                    border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    labelText:"Password" ),
                     validator: (value) {
                    if (value.length<8) {
                      return 'Password is too short';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    passwordcontroller.text = value ;
                  },
                ),
                 SizedBox(height: 20),
                if(_isnotLogin)
                  TextFormField(
                    key: ValueKey('confirmPassword'),
                   obscureText: true,
                    decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_open_outlined,),
                    border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    labelText:"ConfirmPassword" ),
                     validator: (value) {
                    if (value.length<8) {
                      return 'Password is too short';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    passwordcontroller.text=value ;
                  },
                  ),
                  
                  SizedBox(height:20.0),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                  onPressed:onsave,
                  child:_isnotLogin?Text("Register",
                  style: TextStyle(color:Colors.white),):
                  Text("Login", style: TextStyle(color:Colors.white),)),
                   Text(
                _isnotLogin
                    ? 'Don\'t have any account.'
                    : 'Already have an account.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                 // color: kdarkBlue,
                ),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    _isnotLogin = !_isnotLogin;
                  });
                },
                child: Text(
                  _isnotLogin? 'Register' : 'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                   // color: kdarkBlue,
                  ),
                ),
              ),
                  
              ],
            ),
          ),
      ),
         ),
       )
  
  
     )
                  
          ]
        ),
  
    );
    
      
      
  
    
  }
}
