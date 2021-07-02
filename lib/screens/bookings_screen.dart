import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';

class BookingsScreen extends StatefulWidget {
  static const String bookingsScreen = '/bookings_screen';

  @override
  _BookingsScreenState createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String currentWorkerUID;
  List _currentWorkerBookingsList = [];
  bool isStartAcceptingOrRejecting = false;
  bool isStartRejecting = false;
  bool isNull = false;
  Widget buildRow({String title, String detail}) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.ideographic,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Expanded(
              child: Text(
                detail,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20)
      ],
    );
  }

  @override
  void didChangeDependencies() async {
    print('INSIDE DIDCHANGEDEPENDENCIES');
    currentWorkerUID = _auth.currentUser.uid;
    try {
      DocumentSnapshot _currentWorkerDoc =
          await _firestore.collection('workers').doc(currentWorkerUID).get();

      _currentWorkerBookingsList = _currentWorkerDoc.data()['bookings'];
      if (_currentWorkerBookingsList == null ||
          _currentWorkerBookingsList.length == 0) {
        isNull = true;
      }
      setState(() {});
    } catch (e) {
      print(e.toString());
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return isNull
        ? Center(
            child: Text(
              'No new bookings',
            ),
          )
        : ModalProgressHUD(
            inAsyncCall: isStartAcceptingOrRejecting,
            child: FutureBuilder<QuerySnapshot>(
              future: _firestore
                  .collection('bookings')
                  .orderBy('booking_date')
                  .get(),
              builder: (context, asyncSnap) {
                if (asyncSnap.hasError) {
                  return Center(
                    child:
                        Text('Something went wrong!!\nPlease try again later'),
                  );
                }
                if (asyncSnap.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                }

                List<QueryDocumentSnapshot> _currentWorkerServices =
                    asyncSnap.data.docs.where(
                  (bookingID) {
                    return _currentWorkerBookingsList.contains(bookingID.id);
                  },
                ).toList();

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemBuilder: (context, i) {
                      return Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildRow(
                                title: 'Address :   ',
                                detail: _currentWorkerServices[i]
                                    .data()['booker_address'],
                              ),
                              buildRow(
                                title: 'Date :         ',
                                detail: _currentWorkerServices[i]
                                    .data()['booking_date'],
                              ),
                              buildRow(
                                title: 'Time :         ',
                                detail: _currentWorkerServices[i]
                                    .data()['booking_time'],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        isStartAcceptingOrRejecting = true;
                                      });
                                      await _firestore
                                          .collection('bookings')
                                          .doc(_currentWorkerServices[i].id)
                                          .update({
                                        'status': 'accepted',
                                      });
                                      await _firestore
                                          .collection('workers')
                                          .doc(_auth.currentUser.uid)
                                          .update(
                                        {
                                          'acceptedBookings':
                                              FieldValue.arrayUnion([
                                            _currentWorkerServices[i].id
                                          ]),
                                          'bookings': FieldValue.arrayRemove(
                                            [_currentWorkerServices[i].id],
                                          ),
                                        },
                                      );
                                      didChangeDependencies();
                                      setState(() {
                                        isStartAcceptingOrRejecting = false;
                                      });
                                    },
                                    child: Text(
                                      'Accept',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 30,
                                        vertical: 10,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        isStartAcceptingOrRejecting = true;
                                      });
                                      await _firestore
                                          .collection('bookings')
                                          .doc(_currentWorkerServices[i].id)
                                          .update({
                                        'status': 'rejected',
                                      });
                                      await _firestore
                                          .collection('workers')
                                          .doc(_auth.currentUser.uid)
                                          .update(
                                        {
                                          'rejectedBookings':
                                              FieldValue.arrayUnion([
                                            _currentWorkerServices[i].id
                                          ]),
                                          'bookings': FieldValue.arrayRemove(
                                            [_currentWorkerServices[i].id],
                                          ),
                                        },
                                      );
                                      didChangeDependencies();
                                      setState(() {
                                        isStartAcceptingOrRejecting = false;
                                      });
                                    },
                                    child: Text(
                                      'Reject',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 30,
                                        vertical: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: _currentWorkerServices.length,
                  ),
                );
              },
            ),
          );
  }
}

// if (_currentWorkerServices[i].data()['status'] ==
// 'accepted')
// ElevatedButton(
// onPressed: () {
// customLaunch('tel:+91 ' +
// _currentWorkerServices[i]
//     .data()['booker_contact']);
// },
// child: Text(
// 'Call',
// style: TextStyle(fontWeight: FontWeight.bold),
// ),
// style: ElevatedButton.styleFrom(
// primary: Theme.of(context).primaryColor,
// padding: EdgeInsets.symmetric(
// horizontal: 30,
// vertical: 10,
// ),
// ),
// ),

// if (_currentWorkerServices[i].data()['status'] ==
// 'pending')
// isStartAccepting
// ? Padding(
// padding: const EdgeInsets.only(
// left: 20,
// ),
// child: CircularProgressIndicator(
// color: Color(0xFF033249),
// ),
// )
// :

// if (_currentWorkerServices[i].data()['status'] ==
// 'pending')
// isStartRejecting
// ? Padding(
// padding: const EdgeInsets.only(
// left: 20,
// ),
// child: CircularProgressIndicator(
// color: Color(0xFF033249),
// ),
// )
// :
