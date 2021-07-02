import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../screens/welcome_screen.dart';
import '../widget/base_ui.dart';
import '../screens/worker_detail_form.dart';

class LoginScreen extends StatefulWidget {
  static const String loginScreen = '/loginscreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isStartRegister = false;

  Future<void> onTapSignInWithGoogle() async {
    setState(() {
      _isStartRegister = true;
    });
    try {
      UserCredential _loggedInWorker = await signInWithGoogle();

      //geeting workers collection
      QuerySnapshot _workerCollection =
          await _firestore.collection('workers').get();

      //getting all documents from workers collection
      List<QueryDocumentSnapshot> _workerDocIDs =
          _workerCollection.docs.toList();

      bool _doesContain = false;

      //checking if current workerID already exists in worker collection
      for (int i = 0; i < _workerDocIDs.length; i++) {
        if (_workerDocIDs[i].id == _loggedInWorker.user.uid) {
          _doesContain = true;
          break;
        }
      }

      if (_doesContain) {
        Navigator.pushReplacementNamed(context, WelcomeScreen.welcomeScreen);
      } else {
        Navigator.of(context)
            .pushReplacementNamed(WorkerDetailForm.workerDetailForm);
      }
    } catch (e) {
      setState(() {
        _isStartRegister = false;
      });
      print(e.message);
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await _auth.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _globalTheme = Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ModalProgressHUD(
        inAsyncCall: _isStartRegister,
        child: SafeArea(
          child: BaseUI(
            fontWeight2: FontWeight.w500,
            padding: const EdgeInsets.only(
                left: 18, top: 40), //this is to simplyfy widget tree
            text1: 'Helping',
            text2: 'Hands',
            fontWeight1: FontWeight.w900,
            fontsize1: 50,
            fontsize2: 50,
            height: 70,
            radius: BorderRadius.only(
              topLeft: Radius.circular(40),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Container()),
                // RaisedButton.icon(
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   padding:
                //       const EdgeInsets.symmetric(vertical: 8, horizontal: 35),
                //   textColor: _globalTheme.accentColor,
                //   color: _globalTheme.primaryColor,
                //   onPressed: () {},
                //   icon: Icon(
                //     Icons.phone,
                //     color: _globalTheme.accentColor,
                //   ),
                //   label: Text('Sign in using phone'),
                //   highlightElevation: 15,
                // ),
                // SizedBox(height: 20),
                // Text(
                //   'Or',
                //   style: TextStyle(
                //       color: _globalTheme.accentColor,
                //       fontWeight: FontWeight.w600),
                // ),
                // SizedBox(height: 20),
                SignInButton(
                  Buttons.Google,
                  onPressed: onTapSignInWithGoogle,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 3.5),
                ),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Text(
                    'Made  with  ❤  in  UDAIPUR.',
                    style: TextStyle(
                      color: _globalTheme.accentColor,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
