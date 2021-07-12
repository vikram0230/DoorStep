import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorstep/services/firestore_helper.dart';
import 'package:doorstep/utilities/classes.dart';
import 'package:doorstep/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BillScreen extends StatefulWidget {
  static String route = '/bill';
  final String rentalId;

  BillScreen({required this.rentalId});

  @override
  _BillScreenState createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  late FirestoreHelper firestoreHelper;

  @override
  void initState() {
    super.initState();
    firestoreHelper = FirestoreHelper(rentalId: widget.rentalId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text(
          'Rental Details',
          style: TextStyle(color: kAccentColor),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kAccentColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Bill>>(
        stream: firestoreHelper.rentalsCollection.withConverter<Bill>(
          toFirestore: (bill, SetOptions? options) {
            return bill.getMap();
          },
          fromFirestore: (
            DocumentSnapshot<Map<String, dynamic>> snapshot,
            SnapshotOptions? options,
          ) {
            var data = snapshot.data()!;
            return Bill.getbill(data);
          },
        ).snapshots(),
        builder: (context, snapshot) {
          // print('--Bill Screen--');
          // print(snapshot.hasData);
          // print(snapshot.hasError);
          List<QueryDocumentSnapshot<Bill>>? snapshotData;
          if (snapshot.connectionState != ConnectionState.waiting) {
            if (snapshot.hasData) {
              snapshotData = snapshot.data!.docs;
              return ListView.separated(
                padding: EdgeInsets.all(10),
                itemCount: snapshotData.length,
                itemBuilder: (context, index) {
                  Bill bill = snapshotData![index].data();
                  // print(bill.getMap());
                  String billId = snapshotData[index].id;
                  // print(billId);

                  return Container();
                  // return ListTile(
                  //   tileColor: kAccentColor,
                  //   leading: Icon(
                  //     Icons.house_siding_rounded,
                  //     color: kPrimaryColor,
                  //     size: 40,
                  //   ),
                  //   title: Text(
                  //     rental.rentalName,
                  //     style: TextStyle(color: kPrimaryColor),
                  //   ),
                  //   subtitle: Text(
                  //     rental.tenantName ?? 'UnOccupied',
                  //     style: TextStyle(color: kPrimaryColor),
                  //   ),
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => RentalDetail(
                  //                   rental: rental,
                  //                   rentalId: rentalId,
                  //                 )));
                  //   },
                  // );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10);
                },
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Lottie.network(
                  'https://assets10.lottiefiles.com/packages/lf20_pNx6yH.json',
                  repeat: true,
                  reverse: true,
                  animate: true,
                ),
              );
            }
          }
          return Center(
            child: Lottie.network(
              'https://assets2.lottiefiles.com/packages/lf20_fp7svyno.json',
              repeat: true,
              reverse: true,
              animate: true,
            ),
          );
        },
      ),
    );
  }
}
