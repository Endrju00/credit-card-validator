import 'package:flutter/material.dart';

class FrtTextButton extends StatefulWidget {
  final String labelText;
  final Future<void> Function()? onPressed;

  const FrtTextButton({
    super.key,
    required this.labelText,
    required this.onPressed,
  });

  @override
  State<FrtTextButton> createState() => _FrtTextButtonState();
}

class _FrtTextButtonState extends State<FrtTextButton> {
  bool _isLoading = false;

  bool get _isDisabled => _isLoading || widget.onPressed == null;

  void _onPress() async {
    setState(() => _isLoading = true);
    await widget.onPressed!();
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      onPressed: _isDisabled ? null : _onPress,
      child: _isLoading
          ? const SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator.adaptive(),
            )
          : Text(
              widget.labelText,
              style: TextStyle(
                fontSize: 18,
                color: _isDisabled ? Colors.grey : Colors.white,
              ),
            ),
    );
  }
}
