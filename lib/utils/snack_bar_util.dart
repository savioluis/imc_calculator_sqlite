import 'package:flutter/material.dart';

class SnackBarUtil {
  static void infoSnackBar(BuildContext context, String text,
      {Function()? onPressed}) {
    final snackBar = SnackBar(
      content: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
      action: SnackBarAction(
        label: 'OK',
        textColor: Colors.blueAccent,
        onPressed: () {
          onPressed;
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
