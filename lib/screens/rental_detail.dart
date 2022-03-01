import 'package:doorstep/screens/bill_screen.dart';
import 'package:doorstep/services/firestore_helper.dart';
import 'package:doorstep/utilities/classes.dart';
import 'package:doorstep/utilities/constants.dart';
import 'package:doorstep/widgets/customTF.dart';
import 'package:doorstep/widgets/shared_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RentalDetail extends StatefulWidget {
  static String route = '/rental';
  final Rental? rental;
  final String? rentalId;

  RentalDetail({this.rental, this.rentalId});

  @override
  _RentalDetailState createState() => _RentalDetailState();
}

class _RentalDetailState extends State<RentalDetail> {
  TextEditingController rentalNameController = TextEditingController();
  TextEditingController rentController = TextEditingController();
  TextEditingController meterReadingController = TextEditingController();
  TextEditingController waterChargesController = TextEditingController();
  TextEditingController maintenanceController = TextEditingController();
  TextEditingController tenantNameController = TextEditingController();
  TextEditingController advancePaidController = TextEditingController();
  bool occupancy = false;
  late FirestoreHelper firestoreHelper;
  bool editable = true;

  setValues() {
    rentalNameController.text = widget.rental!.rentalName;
    rentController.text = widget.rental!.rent.toString();
    meterReadingController.text = widget.rental!.meterReading.toString();
    waterChargesController.text = widget.rental!.waterCharges.toString();
    maintenanceController.text = widget.rental!.maintenance.toString();
    tenantNameController.text = widget.rental!.tenantName ?? '';
    advancePaidController.text = widget.rental!.advancePaid == null
        ? '0'
        : widget.rental!.advancePaid.toString();
    occupancy = widget.rental!.tenantName != null;
  }

  @override
  void initState() {
    super.initState();
    firestoreHelper = FirestoreHelper(rentalId: widget.rentalId);
    if (widget.rental != null) {
      editable = false;
      setValues();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: editable ? () async => false : () async => true,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: AppBar(
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
            actions: editable
                ? []
                : [
                    IconButton(
                      icon: Icon(
                        Icons.receipt,
                        color: kAccentColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BillScreen(
                              rentalId: widget.rentalId!,
                            ),
                          ),
                        );
                      },
                    ),
                    PopupMenuButton(
                      icon: Icon(
                        Icons.adaptive.more,
                        color: kAccentColor,
                      ),
                      onSelected: (value) {
                        switch (value) {
                          case 'Edit':
                            setState(() {
                              editable = true;
                            });
                            break;
                          case 'Delete':
                            deleteRental(context);
                            break;
                        }
                      },
                      color: kPrimaryColor,
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: Text('Edit'),
                            value: 'Edit',
                          ),
                          PopupMenuItem(
                            child: Text('Delete'),
                            value: 'Delete',
                          ),
                        ];
                      },
                    ),
                  ],
          ),
          body: Container(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              children: [
                CustomTextField(
                  controller: rentalNameController,
                  prefixIcon: Icon(
                    Icons.house_siding_rounded,
                    color: kAccentColor,
                  ),
                  labelText: 'Rental Name',
                  enabled: editable,
                ),
                CustomTextField(
                  controller: rentController,
                  prefixIcon: Icon(
                    Icons.money_rounded,
                    color: kAccentColor,
                  ),
                  labelText: 'Rent',
                  enabled: editable,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                ),
                CustomTextField(
                  controller: meterReadingController,
                  prefixIcon: Icon(
                    Icons.confirmation_number,
                    color: kAccentColor,
                  ),
                  labelText: 'Meter Reading',
                  enabled: editable,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                ),
                CustomTextField(
                  controller: waterChargesController,
                  prefixIcon: Icon(
                    Icons.water,
                    color: kAccentColor,
                  ),
                  labelText: 'Water Charges',
                  enabled: editable,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                ),
                CustomTextField(
                  controller: maintenanceController,
                  prefixIcon: Icon(
                    Icons.money_rounded,
                    color: kAccentColor,
                  ),
                  labelText: 'Maintenance',
                  enabled: editable,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 8, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Occupancy',
                        style: TextStyle(
                            color: kAccentColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      Switch(
                        value: occupancy,
                        onChanged: editable
                            ? (value) {
                                setState(() {
                                  occupancy = !occupancy;
                                });
                              }
                            : (value) {},
                        activeColor: kAccentColor,
                        activeTrackColor: kAccentColor.withOpacity(0.6),
                        inactiveThumbColor: kAccentColor,
                      ),
                    ],
                  ),
                ),
                occupancy
                    ? Column(
                        children: [
                          CustomTextField(
                            controller: tenantNameController,
                            prefixIcon: Icon(
                              Icons.person,
                              color: kAccentColor,
                            ),
                            labelText: 'Tenant Name',
                            enabled: editable,
                          ),
                          CustomTextField(
                            controller: advancePaidController,
                            prefixIcon: Icon(
                              Icons.money_rounded,
                              color: kAccentColor,
                            ),
                            labelText: 'Advance Paid',
                            enabled: editable,
                            inputFormatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]'))
                            ],
                          ),
                          SizedBox(height: 10),
                          MaterialButton(
                            onPressed: () {
                              generateBill(
                                  context, widget.rental!.meterReading);
                            },
                            child: Text(
                              'Generate Bill',
                              style:
                                  TextStyle(color: kPrimaryColor, fontSize: 18),
                            ),
                            color: kAccentColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
          bottomNavigationBar: Visibility(
            visible: editable,
            child: Container(
              child: MaterialButton(
                onPressed: () async {
                  kLoadingDialog(context);

                  Rental rental = Rental(
                    rentalName: rentalNameController.text,
                    rent: int.parse(rentController.text),
                    meterReading: int.parse(meterReadingController.text),
                    waterCharges: int.parse(waterChargesController.text),
                    maintenance: int.parse(maintenanceController.text),
                    tenantName: occupancy ? tenantNameController.text : null,
                    advancePaid: occupancy
                        ? int.tryParse(advancePaidController.text)
                        : null,
                  );

                  if (widget.rental == null) {
                    bool result = await firestoreHelper.addRental(rental);

                    Navigator.pop(context);
                    if (result) {
                      Fluttertoast.showToast(
                        msg: 'Rental Created',
                        backgroundColor: kAccentColor,
                        textColor: kPrimaryColor,
                        gravity: ToastGravity.BOTTOM,
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Error! Rental not created',
                        backgroundColor: kAccentColor,
                        textColor: kPrimaryColor,
                        gravity: ToastGravity.BOTTOM,
                      );
                    }
                  } else {
                    bool result = await firestoreHelper.updateRental(rental);

                    Navigator.pop(context);
                    if (result) {
                      Fluttertoast.showToast(
                        msg: 'Rental Updated',
                        backgroundColor: kAccentColor,
                        textColor: kPrimaryColor,
                        gravity: ToastGravity.BOTTOM,
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Error! Rental not updated',
                        backgroundColor: kAccentColor,
                        textColor: kPrimaryColor,
                        gravity: ToastGravity.BOTTOM,
                      );
                    }
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  'Save',
                  style: TextStyle(color: kPrimaryColor, fontSize: 18),
                ),
                color: kAccentColor,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              color: Colors.transparent,
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> deleteRental(BuildContext context) {
    bool error = false;
    return showDialog(
      context: context,
      builder: (context) {
        TextEditingController rentalNameController = TextEditingController();
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return AlertDialog(
              backgroundColor: kPrimaryColor,
              title: Text('Delete Rental'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Enter ',
                      style: TextStyle(color: kAccentColor, fontSize: 16),
                      children: [
                        TextSpan(
                          text: widget.rental!.rentalName,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(text: ' to confirm'),
                      ],
                    ),
                  ),
                  CustomTextField(
                    labelText: 'Rental Name',
                    controller: rentalNameController,
                    errorText: error ? 'Enter Rental Name' : null,
                  ),
                ],
              ),
              contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 10.0),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                MaterialButton(
                  onPressed: () async {
                    bool res;
                    if (rentalNameController.text ==
                        widget.rental!.rentalName) {
                      res = await firestoreHelper.deleteRental();
                      if (res) {
                        Fluttertoast.showToast(
                          msg: 'Rental Deleted',
                          backgroundColor: kAccentColor,
                          textColor: kPrimaryColor,
                          gravity: ToastGravity.BOTTOM,
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: 'Error! Rental not deleted',
                          backgroundColor: kAccentColor,
                          textColor: kPrimaryColor,
                          gravity: ToastGravity.BOTTOM,
                        );
                      }
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        error = true;
                      });
                    }
                  },
                  child: Text('Confirm'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  getTotal(int electricityConsumption) {
    int total = widget.rental!.rent +
        widget.rental!.waterCharges +
        widget.rental!.maintenance +
        electricityConsumption * 7;
    return total;
  }

  Future<dynamic> generateBill(BuildContext context, int lastReading) {
    bool error = false;
    return showDialog(
      context: context,
      builder: (context) {
        TextEditingController readingController = TextEditingController();
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return AlertDialog(
              backgroundColor: kPrimaryColor,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Enter the EB meter readings'),
                  CustomTextField(
                    labelText: 'Meter Reading',
                    controller: readingController,
                    errorText: error ? 'Enter correct Meter Readings' : null,
                    inputFormatter: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                    prefixIcon: Icon(
                      Icons.confirmation_number,
                      color: kAccentColor,
                    ),
                  ),
                ],
              ),
              contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 10.0),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                MaterialButton(
                  onPressed: () async {
                    int prevReading =
                        await firestoreHelper.getPreviousReading() ??
                            lastReading;
                    if (readingController.text != '' &&
                        int.parse(readingController.text) >= prevReading) {
                      Map data = widget.rental!.getMap();

                      int electricityConsumption =
                          int.parse(readingController.text) - prevReading;

                      Map<String, dynamic> temp = {
                        'billDate': DateTime.now(),
                        'meterReading': int.parse(readingController.text),
                        'electricityConsumption': electricityConsumption,
                        'electricityCharges': electricityConsumption * 7,
                        'total': getTotal(electricityConsumption),
                      };

                      data.addAll(temp);

                      Bill bill = Bill.getbill(data);
                      bool result = await firestoreHelper.generateBill(bill);

                      Rental rental = widget.rental!;
                      rental.meterReading = int.parse(readingController.text);
                      meterReadingController.text = readingController.text;

                      bool res = await firestoreHelper.updateRental(rental);
                      Navigator.pop(context);
                      setState(() {});
                      if (result && res) {
                        Fluttertoast.showToast(
                          msg: 'Bill Generated',
                          backgroundColor: kAccentColor,
                          textColor: kPrimaryColor,
                          gravity: ToastGravity.BOTTOM,
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: 'Error! Bill not generated',
                          backgroundColor: kAccentColor,
                          textColor: kPrimaryColor,
                          gravity: ToastGravity.BOTTOM,
                        );
                      }
                    } else {
                      setState(() {
                        error = true;
                      });
                    }
                  },
                  child: Text('Confirm'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
