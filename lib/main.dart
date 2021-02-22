import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './screens/homescreen.dart';
import './screens/auth_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Color(0xFFFF8038),
        primaryColor: Color(0xFF033249),
        fontFamily: 'Montserrat',
      ),
      title: 'Helping Hands',
      home: StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapShot) {
          if (userSnapShot.hasData) {
            return  HomeScreen();
          }
          return AuthScreen();
        },
      ),
    );
  }
}
