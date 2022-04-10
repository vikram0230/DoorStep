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

  /// Creates a monthly bill
  Future<bool> createBill(Bill bill) async {
    return rentalsCollection
          .doc(rentalDocId)
          .collection(kBills)
          .add(bill.getMap())
          .then((value) => true)
          .catchError((error) {
        print(error);
      });
  }

  /// Updates an existing bill
  Future<bool> updateBill(String docId, Bill bill) {
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

  /// Checks if current month bill already exists
  /// 
  /// Return : docId of the bill
  Future<String?> checkCurrentBill() async {
    DateTime now = DateTime.now();
    DateTime firstOfMonth = DateTime(now.year, now.month, 1);
    DateTime nextMonth = DateTime(now.year, now.month + 1, 1);

    QuerySnapshot currentMonthBill = await billsCollection
        .where('billDate', isGreaterThanOrEqualTo: firstOfMonth)
        .where('billDate', isLessThan: nextMonth)
        .get();

    if (currentMonthBill.docs.isEmpty) return null;
    return currentMonthBill.docs[0].id;
  }

  Future<int?> getPreviousReading() async {
    DateTime now = DateTime.now();
    DateTime currentMonth = DateTime(now.year, now.month, 1);
    DateTime prevMonth = DateTime(now.year, now.month - 1, 1);

    QuerySnapshot prevDocument = await billsCollection
        .where('billDate', isLessThan: currentMonth)
        .where('billDate', isGreaterThanOrEqualTo: prevMonth)
        .get();

    if (prevDocument.docs.isNotEmpty) {
      var prevData = prevDocument.docs[0];
      return prevData['meterReading'];
    }
    return null;
  }

  Future<bool> generatedCurrentMonthBill() async {
    DateTime now = DateTime.now();
    DateTime firstOfMonth = DateTime(now.year, now.month, 1);
    DateTime nextMonth = DateTime(now.year, now.month + 1, 1);

    QuerySnapshot currentMonthBill = await billsCollection
        .where('billDate', isGreaterThanOrEqualTo: firstOfMonth)
        .where('billDate', isLessThan: nextMonth)
        .get();

    return currentMonthBill.docs.isNotEmpty;
  }
}
