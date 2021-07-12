import 'package:doorstep/utilities/constants.dart';
import 'package:doorstep/widgets/customTF.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BillDetail extends StatefulWidget {
  final billId;
  BillDetail({this.billId});

  @override
  _BillDetailState createState() => _BillDetailState();
}

class _BillDetailState extends State<BillDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          children: [
            CustomTextField(
              controller: TextEditingController(),
              prefixIcon: Icon(
                Icons.house_siding_rounded,
                color: kAccentColor,
              ),
              labelText: 'Rental Name',
              enabled: false,
            ),
            CustomTextField(
              controller: TextEditingController(),
              prefixIcon: Icon(
                Icons.person,
                color: kAccentColor,
              ),
              labelText: 'Tenant Name',
              enabled: false,
            ),
            CustomTextField(
              controller: TextEditingController(),
              prefixIcon: Icon(
                Icons.money_rounded,
                color: kAccentColor,
              ),
              labelText: 'Advance Paid',
              enabled: false,
              inputFormatter: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
            ),
            CustomTextField(
              controller: TextEditingController(),
              prefixIcon: Icon(
                Icons.confirmation_number,
                color: kAccentColor,
              ),
              labelText: 'Meter Reading',
              enabled: false,
              inputFormatter: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
            ),
            CustomTextField(
              controller: TextEditingController(),
              prefixIcon: Icon(
                Icons.money_rounded,
                color: kAccentColor,
              ),
              labelText: 'Rent',
              enabled: false,
              inputFormatter: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
            ),
            CustomTextField(
              controller: TextEditingController(),
              prefixIcon: Icon(
                Icons.confirmation_number,
                color: kAccentColor,
              ),
              labelText: 'Electricity Charges',
              enabled: false,
              inputFormatter: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
            ),
            CustomTextField(
              controller: TextEditingController(),
              prefixIcon: Icon(
                Icons.water,
                color: kAccentColor,
              ),
              labelText: 'Water Charges',
              enabled: false,
              inputFormatter: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
            ),
            CustomTextField(
              controller: TextEditingController(),
              prefixIcon: Icon(
                Icons.money_rounded,
                color: kAccentColor,
              ),
              labelText: 'Maintenance',
              enabled: false,
              inputFormatter: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
            ),
            CustomTextField(
              controller: TextEditingController(),
              prefixIcon: Icon(
                Icons.confirmation_number,
                color: kAccentColor,
              ),
              labelText: 'Total',
              enabled: false,
              inputFormatter: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
