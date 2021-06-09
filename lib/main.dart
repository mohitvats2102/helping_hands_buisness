import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helping_hands_buisness/screens/bookings_screen.dart';
import 'package:helping_hands_buisness/screens/login_screen.dart';
import 'package:helping_hands_buisness/screens/worker_detail_form.dart';

import './screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final User _firebaseUser = FirebaseAuth.instance.currentUser;
// Define a widget
  Widget _firstWidget;
  @override
  Widget build(BuildContext context) {
    if (_firebaseUser != null) {
      _firstWidget = WelcomeScreen();
    } else {
      _firstWidget = LoginScreen();
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Color(0xFFFF8038),
        primaryColor: Color(0xFF033249),
        fontFamily: 'Montserrat',
      ),
      title: 'Helping Hands',
      home: _firstWidget,
      routes: {
        LoginScreen.loginScreen: (context) => LoginScreen(),
        WorkerDetailForm.workerDetailForm: (context) => WorkerDetailForm(),
        WelcomeScreen.welcomeScreen: (context) => WelcomeScreen(),
      },
    );
  }
}
