import 'package:flutter/material.dart';
import 'package:practical_project/app_theme/app_colors.dart';

class LoaderDialog {
  static bool _isLoading = false;

  static void showLoader(BuildContext context) {
    if (!_isLoading) {
      _isLoading = true;
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent user from dismissing the dialog
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false, // Prevent dialog from being dismissed with back button
            child: AlertDialog(
              backgroundColor: AppColors.transparentColors,
              elevation: 0,
              content: Center(
                child: Container(
                  width: 60,
                  height: 60,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.white
                  ),
                  child: const CircularProgressIndicator(),
                ),
              ),
            ),
          );
        },
      );
    }
  }

  static void hideLoader(BuildContext context) {
    if (_isLoading) {
      _isLoading = false;
      Navigator.of(context).pop();
    }
  }
}
