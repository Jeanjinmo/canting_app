import 'package:flutter/material.dart';

extension SnackbarExtensions on BuildContext {
  void snackbarShow(String message) {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        // action: SnackBarAction(
        //   label: 'TUTUP',
        //   onPressed: () {
        //     ScaffoldMessenger.of(this).hideCurrentSnackBar();
        //   },
        // ),
      ),
    );
  }

  void featNotAvailable() {
    snackbarShow("Fitur belum tersedia saat ini");
  }
}
