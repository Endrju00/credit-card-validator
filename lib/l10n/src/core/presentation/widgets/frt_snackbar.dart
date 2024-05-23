import 'package:flutter/material.dart';

enum FrtSnackBarType { success, error }

class FrtSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    required FrtSnackBarType type,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: _getColor(type),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  static Color _getColor(FrtSnackBarType type) {
    switch (type) {
      case FrtSnackBarType.success:
        return Colors.green;
      case FrtSnackBarType.error:
        return Colors.red;
    }
  }
}
