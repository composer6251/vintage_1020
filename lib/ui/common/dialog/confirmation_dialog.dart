import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';

Future<OkCancelResult> showConfirmDialog(String title, BuildContext context)  {
  return  showOkCancelAlertDialog(context: context, title: title);
}

Future<Widget> showQuickAddToBoothDialog(
  String title,
  BuildContext context,
) async {
  return await showConfirmationDialog(title: title, context: context);
}
