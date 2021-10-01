import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DialogAlert {
  alertCustom(String msg, BuildContext context) {
    AlertDialog alert = AlertDialog(
      title:
          Text("PERINGATAN", style: TextStyle(fontSize: 12, letterSpacing: 2)),
      content: Text(msg),
      actions: [
        TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  confirmAlertDialog(BuildContext context, String title, String msg) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Ya"),
      onPressed: () {
        Navigator.of(context).pop(true);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    ).then((valueFromDialog) {
      // use the value as you wish
      return valueFromDialog;
    });
  }

  toastCustom(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0);
  }
}
