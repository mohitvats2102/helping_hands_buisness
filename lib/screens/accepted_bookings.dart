import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class AcceptedBookings extends StatefulWidget {
  @override
  _AcceptedBookingsState createState() => _AcceptedBookingsState();
}

class _AcceptedBookingsState extends State<AcceptedBookings> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String currentWorkerUID;
  List _currentWorkerAcceptedBookingsList = [];
  bool isNull = false;

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('can\'t make call');
    }
  }

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
    print('INSIDE DIDCHANGEDEPENDENCIES123');
    currentWorkerUID = _auth.currentUser.uid;
    try {
      DocumentSnapshot _currentWorkerDoc =
          await _firestore.collection('workers').doc(currentWorkerUID).get();

      _currentWorkerAcceptedBookingsList =
          _currentWorkerDoc.data()['acceptedBookings'];
      if (_currentWorkerAcceptedBookingsList == null ||
          _currentWorkerAcceptedBookingsList.length == 0) {
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
              'No bookings accepted yet',
            ),
          )
        : FutureBuilder<QuerySnapshot>(
            future:
                _firestore.collection('bookings').orderBy('booking_date').get(),
            builder: (context, asyncSnap) {
              if (asyncSnap.hasError) {
                return Center(
                  child: Text('Something went wrong!!\nPlease try again later'),
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
                  return _currentWorkerAcceptedBookingsList
                      .contains(bookingID.id);
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
                            ElevatedButton(
                              onPressed: () {
                                customLaunch('tel:+91 ' +
                                    _currentWorkerServices[i]
                                        .data()['booker_contact']);
                              },
                              child: Text(
                                'Call',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF033249),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 10,
                                ),
                              ),
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
          );
  }
}
