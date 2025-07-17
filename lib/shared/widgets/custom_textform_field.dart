import 'package:flutter/material.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.showClearButton = false,
    this.borderRadius,
  });
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool showClearButton;
  final BorderRadius? borderRadius;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var showSuffix =
        widget.showClearButton && widget.controller.text.isNotEmpty;

    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Icon(widget.prefixIcon, color: AppColors.textSecondary),
        suffixIcon:
            showSuffix
                ? IconButton(
                  onPressed: () {
                    widget.controller.clear();
                    setState(() {});
                  },
                  icon: const Icon(Icons.clear),
                )
                : null,
        border: OutlineInputBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.zero,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.zero,
          borderSide: const BorderSide(color: AppColors.grey300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.zero,
          borderSide: const BorderSide(color: AppColors.statusUpcoming),
        ),
      ),
    );
  }
}
