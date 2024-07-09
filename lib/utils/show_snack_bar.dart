import 'package:ToDo/themes/colors.dart';
import 'package:ToDo/themes/text.dart';
import 'package:flutter/material.dart';

class ShowMessage {
  static void showSuccessMessage(
    BuildContext context, {
    required String message,
  }) {
    final snackBar = SnackBar(
        backgroundColor: purple,
        duration: const Duration(seconds: 2),
        content: Text(
          message,
          style: title1Bold,
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showFailedMessage(
    BuildContext context, {
    required String message,
  }) {
    final snackBar = SnackBar(
        backgroundColor: ligthRed,
        duration: const Duration(seconds: 2),
        content: Text(
          message,
          style: title1Bold,
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
