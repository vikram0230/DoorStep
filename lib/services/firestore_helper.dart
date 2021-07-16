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
    billsCollection = firestore.collection(kRentals).doc(rentalId).collection(kBills);
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
    
    //TODO: Check if bill already exists
    if (true) {
      return rentalsCollection
          .doc(rentalDocId)
          .collection(kBills)
          .add(bill.getMap())
          .then((value) => true)
          .catchError((error) {
        print(error);
      });
    } else {
      return rentalsCollection
          .doc(rentalDocId)
          .collection(kBills)
          .doc(billDocId)
          .update(bill.getMap())
          .then((value) => true)
          .catchError((error) {
        print(error);
      });
    }
  }
}
