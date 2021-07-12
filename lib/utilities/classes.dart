class Rental {
  late String rentalName;
  late int rent;
  late int meterReading;
  late int waterCharges;
  late int maintenance;
  String? tenantName;
  int? advancePaid;

  Rental({
    required this.rentalName,
    required this.rent,
    required this.meterReading,
    required this.waterCharges,
    required this.maintenance,
    this.tenantName,
    this.advancePaid,
  });

  Map<String, dynamic> getMap() {
    return {
      'rentalName': rentalName,
      'rent': rent,
      'meterReading': meterReading,
      'waterCharges': waterCharges,
      'maintenance': maintenance,
      'tenantName': tenantName,
      'advancePaid': advancePaid,
    };
  }

  static getRental(Map data) {
    return Rental(
      rentalName: data['rentalName'],
      rent: data['rent'],
      meterReading: data['meterReading'],
      waterCharges: data['waterCharges'],
      maintenance: data['maintenance'],
      tenantName: data['tenantName'],
      advancePaid: data['advancePaid'],
    );
  }
}

class Bill extends Rental {
  Rental rental;
  DateTime billDate;
  int total;

  Bill({
    required this.rental,
    required this.billDate,
    required this.total,
  }) : super(
          rentalName: rental.rentalName,
          rent: rental.rent,
          meterReading: rental.meterReading,
          waterCharges: rental.waterCharges,
          maintenance: rental.maintenance,
          tenantName: rental.tenantName,
          advancePaid: rental.advancePaid,
        );

  Map<String, dynamic> getMap() {
    return {
      'rentalName': rentalName,
      'rent': rent,
      'meterReading': meterReading,
      'waterCharges': waterCharges,
      'maintenance': maintenance,
      'tenantName': tenantName,
      'advancePaid': advancePaid,
      'billDate': billDate,
      'total': total,
    };
  }

  static getbill(Map data) {
    return Bill(
      rental: Rental.getRental(data),
      billDate: data['billDate'],
      total: data['total'],
    );
  }
}
