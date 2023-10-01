import 'package:flutter/material.dart';

class Utils {
  static void showSnackbar(
    BuildContext context, {
    required String content,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(content),
        dismissDirection: DismissDirection.vertical,
      ),
    );
  }
}
