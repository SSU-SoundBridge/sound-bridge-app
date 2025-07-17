import 'package:flutter/material.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    super.key,
    required this.controller,
    this.hintText = '비밀번호',
    this.borderRadius,
    this.validator,
  });
  final TextEditingController controller;
  final String hintText;
  final BorderRadius? borderRadius;
  final FormFieldValidator<String>? validator;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscure,
      validator:
          widget.validator ??
          (val) => (val == null || val.length < 6) ? '6자 이상 입력하세요' : null,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: const Icon(
          Icons.lock_outline,
          color: AppColors.textSecondary,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscure ? Icons.visibility_off : Icons.visibility,
            color: AppColors.grey500,
          ),
          onPressed: () {
            setState(() {
              _obscure = !_obscure;
            });
          },
        ),
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
