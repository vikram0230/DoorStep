import 'dart:io';

import 'package:doorstep/services/firestore_helper.dart';
import 'package:doorstep/utilities/classes.dart';
import 'package:doorstep/utilities/constants.dart';
import 'package:doorstep/widgets/customTF.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class BillDetail extends StatefulWidget {
  final Bill bill;
  final String billId;
  BillDetail({required this.billId, required this.bill});

  @override
  _BillDetailState createState() => _BillDetailState();
}

class _BillDetailState extends State<BillDetail> {
  TextEditingController rentalNameController = TextEditingController();
  TextEditingController electricityChargesController = TextEditingController();
  TextEditingController rentController = TextEditingController();
  TextEditingController meterReadingController = TextEditingController();
  TextEditingController consumtionController = TextEditingController();
  TextEditingController waterChargesController = TextEditingController();
  TextEditingController maintenanceController = TextEditingController();
  TextEditingController tenantNameController = TextEditingController();
  TextEditingController advancePaidController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  late FirestoreHelper firestoreHelper;
  ScreenshotController screenshotController = ScreenshotController();
  late String? captured_image;

  setValues() {
    rentalNameController.text = widget.bill.rentalName;
    electricityChargesController.text =
        widget.bill.electricityCharges.toString();
    rentController.text = widget.bill.rent.toString();
    meterReadingController.text = widget.bill.meterReading.toString();
    consumtionController.text = widget.bill.electricityConsumption.toString();
    electricityChargesController.text =
        widget.bill.electricityCharges.toString();
    waterChargesController.text = widget.bill.waterCharges.toString();
    maintenanceController.text = widget.bill.maintenance.toString();
    tenantNameController.text = widget.bill.tenantName ?? '';
    advancePaidController.text = widget.bill.advancePaid == null
        ? '0'
        : widget.bill.advancePaid.toString();
    totalController.text = widget.bill.total.toString();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setValues();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text(
            'Bill Details',
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
          actions: [
            IconButton(
              icon: Icon(
                Icons.share,
                color: kAccentColor,
              ),
              onPressed: () async {
                final directory = await getTemporaryDirectory();
                captured_image = await screenshotController.captureAndSave(
                  directory.path,
                  fileName: 'DoorStep_bill.jpg',
                );
                String imagePath = '${directory.path}/DoorStep_bill.jpg';

                Share.shareFiles(
                  [imagePath],
                );
              },
            ),
          ],
        ),
        body: Screenshot(
          controller: screenshotController,
          child: Container(
            color: kPrimaryColor,
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              children: [
                Text(
                  DateFormat.yMMMMd().format(widget.bill.billDate),
                  style: TextStyle(color: kAccentColor, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                CustomTextField(
                  controller: rentalNameController,
                  prefixIcon: Icon(
                    Icons.house_siding_rounded,
                    color: kAccentColor,
                  ),
                  labelText: 'Rental Name',
                  enabled: false,
                ),
                CustomTextField(
                  controller: tenantNameController,
                  prefixIcon: Icon(
                    Icons.person,
                    color: kAccentColor,
                  ),
                  labelText: 'Tenant Name',
                  enabled: false,
                ),
                // CustomTextField(
                //   controller: advancePaidController,
                //   prefixIcon: Icon(
                //     Icons.money_rounded,
                //     color: kAccentColor,
                //   ),
                //   labelText: 'Advance Paid',
                //   enabled: false,
                //   inputFormatter: [
                //     FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                //   ],
                // ),
                CustomTextField(
                  controller: meterReadingController,
                  prefix: SizedBox(
                    width: 220,
                    child: Text(
                      'Meter Reading: ',
                      style: TextStyle(
                          color: kAccentColor, fontWeight: FontWeight.w600),
                    ),
                  ),
                  suffix: Text(
                    'KWPH',
                  ),
                  enabled: false,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                ),
                CustomTextField(
                  controller: consumtionController,
                  prefix: SizedBox(
                    width: 220,
                    child: Text(
                      'Electricity Consumption: ',
                      style: TextStyle(
                          color: kAccentColor, fontWeight: FontWeight.w600),
                    ),
                  ),
                  suffix: Text(
                    'units',
                  ),
                  enabled: false,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  boldUnderLine: true,
                ),
                CustomTextField(
                  controller: rentController,
                  prefix: SizedBox(
                    width: 220,
                    child: Text(
                      'Rent: ',
                      style: TextStyle(
                          color: kAccentColor, fontWeight: FontWeight.w600),
                    ),
                  ),
                  enabled: false,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                ),
                CustomTextField(
                  controller: electricityChargesController,
                  prefix: SizedBox(
                    width: 220,
                    child: Text(
                      'Electricity Charges: ',
                      style: TextStyle(
                          color: kAccentColor, fontWeight: FontWeight.w600),
                    ),
                  ),
                  enabled: false,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                ),
                CustomTextField(
                  controller: waterChargesController,
                  prefix: SizedBox(
                    width: 220,
                    child: Text(
                      'Water Charges: ',
                      style: TextStyle(
                          color: kAccentColor, fontWeight: FontWeight.w600),
                    ),
                  ),
                  enabled: false,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                ),
                CustomTextField(
                  controller: maintenanceController,
                  prefix: SizedBox(
                    width: 220,
                    child: Text(
                      'Maintenance: ',
                      style: TextStyle(
                          color: kAccentColor, fontWeight: FontWeight.w600),
                    ),
                  ),
                  enabled: false,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  boldUnderLine: true,
                ),
                CustomTextField(
                  controller: totalController,
                  boldText: true,
                  prefix: SizedBox(
                    width: 220,
                    child: Text(
                      'Total: ',
                      style: TextStyle(
                          color: kAccentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ),
                  enabled: false,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  boldUnderLine: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
