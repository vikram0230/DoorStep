import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorstep/utilities/classes.dart';

class FirestoreHelper {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference rentalsCollection;
  late CollectionReference billsCollection;
  String kRentals = 'rentals';
  String kBills = 'bills';
  String? rentalDocId;
  String? billDocId;

  FirestoreHelper({rentalId, billId}) {
    rentalsCollection = firestore.collection(kRentals);
    billsCollection =
        firestore.collection(kRentals).doc(rentalId).collection(kBills);
    rentalDocId = rentalId;
    billDocId = billId;
  }

  // Rental Related

  Future<bool> addRental(Rental rental) async {
    return await rentalsCollection
        .doc()
        .set(rental.getMap())
        .then((value) => true)
        .catchError((error) {
      print(error);
    });
  }

  Future updateRental(Rental rental) async {
    return await rentalsCollection
        .doc(rentalDocId)
        .update(rental.getMap())
        .then((value) => true)
        .catchError((error) {
      print(error);
    });
  }

  Future<bool> deleteRental() {
    return rentalsCollection
        .doc(rentalDocId)
        .delete()
        .then((value) => true)
        .catchError((error) {
      print(error);
    });
  }

  // Tenant Related

  Future<bool> updateTenant({
    tenantName,
    advancePaid,
  }) async {
    return rentalsCollection
        .doc(rentalDocId)
        .update({
          'tenantName': tenantName,
          'advancePaid': advancePaid,
        })
        .then((value) => true)
        .catchError((error) {
          print(error);
        });
  }

  // Bill Related

  Future<bool> generateBill(Bill bill) async {
    DateTime now = DateTime.now();
    DateTime firstOfMonth = DateTime(now.year, now.month, 1);
    print(firstOfMonth);

    QuerySnapshot document = await billsCollection
        .where('billDate', isGreaterThanOrEqualTo: firstOfMonth)
        .get();
    print(document.docs);

    //TODO: Check if bill already exists
    if (document.docs.isEmpty) {
      return rentalsCollection
          .doc(rentalDocId)
          .collection(kBills)
          .add(bill.getMap())
          .then((value) => true)
          .catchError((error) {
        print(error);
      });
    } else {
      print(document.docs[0].data());
      String docId = document.docs[0].id;
      return rentalsCollection
          .doc(rentalDocId)
          .collection(kBills)
          .doc(docId)
          .update(bill.getMap())
          .then((value) => true)
          .catchError((error) {
        print(error);
      });
    }
  }
}
