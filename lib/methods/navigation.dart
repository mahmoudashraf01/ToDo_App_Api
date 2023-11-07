import 'package:flutter/material.dart';

Future<void> goTo({required BuildContext context, required Widget screen}) async{
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}
Future<void> goToWithNoBackButton({required BuildContext context, required Widget screen}) async{
  await Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );


}


