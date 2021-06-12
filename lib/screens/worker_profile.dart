import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WorkerProfileScreen extends StatelessWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  static const String workerProfileScreen = '/worker_profile_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Profile'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _firestore
            .collection('workers')
            .doc(_auth.currentUser.uid)
            .snapshots(),
        builder: (context, asynSnap) {
          if (asynSnap.hasError) {
            Center(
              child: Text('Something went wrong\nPlease try again later'),
            );
          }
          if (asynSnap.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(color: Color(0xFF033249));
          }
          DocumentSnapshot _workerData = asynSnap.data;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    _workerData.data()['image'],
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  color: Color(0xFF033249),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                _workerData.data()['name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color(0xFFFF8038),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                _workerData.data()['category'].toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color(0xFFFF8038),
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Bookings : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xFFFF8038),
                              ),
                            ),
                            Text(
                              _workerData.data()['totalBookings'] == null
                                  ? '0'
                                  : _workerData
                                      .data()['totalBookings']
                                      .toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xFFFF8038),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Shop Name : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xFFFF8038),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                _workerData.data()['shopname'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color(0xFFFF8038),
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Contacts : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xFFFF8038),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                _workerData.data()['contact'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color(0xFFFF8038),
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ratings : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xFFFF8038),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "${_workerData.data()['rating']} ⭐",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color(0xFFFF8038),
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
