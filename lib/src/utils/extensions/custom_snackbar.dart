import 'package:flutter/material.dart';

void showSuccessSnackBar(BuildContext context, String message,{bool issuc = true}) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor:issuc ? Colors.green[400] : Colors.red,
    duration: const Duration(seconds: 3),
    action: SnackBarAction(
      label: 'Dismiss',
      textColor: Colors.white,
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

// Example usage in your code
// final successfulMessage = 'Your action was successful!';
// showSuccessSnackBar(context, successfulMessage);
