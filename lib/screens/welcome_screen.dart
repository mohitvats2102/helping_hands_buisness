import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const String welcomeScreen = '/welcome_screen';
  FirebaseAuth _auth = FirebaseAuth.instance;

  void logout(BuildContext context) async {
    if (_auth.currentUser.providerData != null) {
      if (_auth.currentUser.providerData[0].providerId == 'google.com') {
        print('In If BLOCK');
        await GoogleSignIn().disconnect();
      }
    }
    _auth.signOut();
    Navigator.of(context).pushReplacementNamed(LoginScreen.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Helping Hands',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                logout(context);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Text(
          'Welcome To Your New Project.\nALL THE BEST',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
