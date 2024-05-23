import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FrtTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Widget icon;
  final String? Function(String? value)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;
  final int errorMaxLines;
  final bool readOnly;

  const FrtTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.icon = const Icon(Icons.credit_card),
    this.validator,
    this.inputFormatters,
    this.keyboardType = const TextInputType.numberWithOptions(signed: true),
    this.errorMaxLines = 2,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          icon: icon,
          labelText: labelText,
          errorMaxLines: errorMaxLines,
          suffixIcon: IconButton(
            onPressed: readOnly ? null : () => controller.clear(),
            icon: const Icon(Icons.clear),
          ),
        ),
      ),
    );
  }
}
