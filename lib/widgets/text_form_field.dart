import 'package:flutter/material.dart';

class MTextFormField extends StatelessWidget {
  const MTextFormField({
    super.key,
    this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.readOnly = false,
    this.onTap,
    this.onIconPressed,
    this.isOpened = false,
  });

  final TextEditingController? controller;
  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final bool readOnly, isOpened;
  final VoidCallback? onTap;
  final VoidCallback? onIconPressed;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      controller: controller,
      keyboardType: keyboardType,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: hintText,
        isDense: true,
        prefixIcon: Icon(prefixIcon, size: 16, color: Colors.grey),
        suffixIcon: IconButton(
          onPressed: onIconPressed,
          icon: Icon(suffixIcon, size: 16, color: Colors.grey),
        ),
        border: OutlineInputBorder(
          borderRadius: isOpened
              ? BorderRadius.vertical(top: Radius.circular(15))
              : BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white38,
      ),
    );
  }
}
