import 'package:flutter/material.dart';

class FrtSecondaryTextButton extends StatelessWidget {
  final String labelText;
  final Function()? onPressed;

  const FrtSecondaryTextButton({
    super.key,
    required this.labelText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
      ),
      onPressed: onPressed,
      child: Text(
        labelText,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
