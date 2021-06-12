import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helping_hands_buisness/screens/bookings_screen.dart';
import 'package:helping_hands_buisness/screens/login_screen.dart';
import 'package:helping_hands_buisness/screens/tabs_screen.dart';
import 'package:helping_hands_buisness/screens/worker_detail_form.dart';
import 'package:helping_hands_buisness/screens/worker_profile.dart';
import './screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final User _firebaseUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _doesContain = false;

  Widget _firstWidget;

  @override
  void didChangeDependencies() async {
    if (_firebaseUser != null) {
      QuerySnapshot _workerCollection =
          await _firestore.collection('workers').get();

      //getting all documents from workers collection
      List<QueryDocumentSnapshot> _workerDocIDs =
          _workerCollection.docs.toList();

      _doesContain = false;

      //checking if current workerID already exists in worker collection
      for (int i = 0; i < _workerDocIDs.length; i++) {
        if (_workerDocIDs[i].id == _firebaseUser.uid) {
          _doesContain = true;
          break;
        }
      }

      if (_doesContain) setState(() {});
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_firebaseUser == null || !_doesContain) {
      _firstWidget = LoginScreen();
    } else {
      _firstWidget = WelcomeScreen();
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
        BookingsScreen.bookingsScreen: (context) => BookingsScreen(),
        TabsScreen.tabScreen: (context) => TabsScreen(),
        WorkerProfileScreen.workerProfileScreen: (context) =>
            WorkerProfileScreen(),
      },
    );
  }
}
