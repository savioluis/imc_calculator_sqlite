import 'package:flutter/material.dart';

class SnackBarUtil {
  static void infoSnackBar(BuildContext context, String text,
      {Function()? onPressed}) {
    final snackBar = SnackBar(
      content: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
