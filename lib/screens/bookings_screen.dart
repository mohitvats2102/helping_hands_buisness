import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingsScreen extends StatefulWidget {
  static const String bookingsScreen = '/bookings_screen';

  @override
  _BookingsScreenState createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  String address =
      'Flat No 3R-4/3 488, Ganpati Nagar, Jaipur, Rajastha 302006,India';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List _currentWorkerBookingsList = [];

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
            Container(
              width: 200,
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
    DocumentSnapshot _currentWorkerDoc =
        await _firestore.collection('workers').doc('mohit').get();
    _currentWorkerBookingsList = _currentWorkerDoc.data()['bookings'];
    print('HERE IS THE BOOKING : ' + _currentWorkerBookingsList[0]);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Bookings'),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: FutureBuilder<QuerySnapshot>(
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
                asyncSnap.data.docs.where((bookingID) {
              return _currentWorkerBookingsList.contains(bookingID.id);
            }).toList();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
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
      ),
    );
  }
}
