import 'package:doorstep/utilities/constants.dart';
import 'package:flutter/material.dart';

// https://assets2.lottiefiles.com/packages/lf20_vu0n2eh3.json
kLoadingDialog(context) {
  showDialog(
    context: context,
    barrierColor: kPrimaryColor.withOpacity(0.5),
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircularProgressIndicator(
                  backgroundColor: kPrimaryColor,
                  valueColor: AlwaysStoppedAnimation<Color>(kAccentColor),
                ),
                Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 20,
                    color: kAccentColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}