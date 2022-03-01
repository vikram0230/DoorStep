import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorstep/screens/bill_screen.dart';
import 'package:doorstep/screens/rental_detail.dart';
import 'package:doorstep/services/firestore_helper.dart';
import 'package:doorstep/utilities/classes.dart';
import 'package:doorstep/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  static String route = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0,
          title: Text(
            'Rentals',
            style: TextStyle(color: kAccentColor),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => Navigator.pushNamed(context, RentalDetail.route),
              icon: Icon(
                Icons.add_business_rounded,
                color: kAccentColor,
              ),
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot<Rental>>(
          stream: FirestoreHelper().rentalsCollection
              .orderBy('rentalName')
              .withConverter<Rental>(
            toFirestore: (rental, SetOptions? options) {
              return rental.getMap();
            },
            fromFirestore: (
              DocumentSnapshot<Map<String, dynamic>> snapshot,
              SnapshotOptions? options,
            ) {
              var data = snapshot.data()!;
              return Rental.getRental(data);
            },
          ).snapshots(),
          builder: (context, snapshot) {
            // print('--Rental Screen--');
            // print(snapshot.hasData);
            // print(snapshot.hasError);
            List<QueryDocumentSnapshot<Rental>>? snapshotData;
            if (snapshot.connectionState != ConnectionState.waiting) {
              if (snapshot.hasData) {
                snapshotData = snapshot.data!.docs;
                return ListView.separated(
                  padding: EdgeInsets.all(10),
                  itemCount: snapshotData.length,
                  itemBuilder: (context, index) {
                    Rental rental = snapshotData![index].data();
                    String rentalId = snapshotData[index].id;

                    // FirestoreHelper firestoreHelper = FirestoreHelper(rentalId: rentalId);

                    // bool generatedCurrentMonthBill =
                    //     await firestoreHelper.generatedCurrentMonthBill();

                    return ListTile(
                      tileColor: rental.tenantName == null
                          ? kAccentColor.withOpacity(0.9)
                          : kAccentColor,
                      leading: Icon(
                        Icons.house_siding_rounded,
                        color: kPrimaryColor,
                        size: 40,
                      ),
                      trailing: IconButton(
                        icon: Icon(
                                Icons.receipt,
                                color: kPrimaryColor,
                              ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BillScreen(
                                rentalId: rentalId,
                              ),
                            ),
                          );
                        },
                      ),
                      title: Text(
                        rental.rentalName,
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      subtitle: Text(
                        rental.tenantName ?? 'UnOccupied',
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RentalDetail(
                              rental: rental,
                              rentalId: rentalId,
                            ),
                          ),
                        );
                      },
                    );
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
      ),
    );
  }
}
