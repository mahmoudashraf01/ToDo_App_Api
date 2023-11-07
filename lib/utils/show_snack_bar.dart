import 'package:flutter/material.dart';
import 'package:to_do_api/themes/colors.dart';
import 'package:to_do_api/themes/text.dart';

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
