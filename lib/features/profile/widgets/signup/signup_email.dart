import 'package:flutter/material.dart';
import 'package:sound_bridge_app/shared/widgets/custom_password_field.dart';
import 'package:sound_bridge_app/shared/widgets/custom_textform_field.dart';

class SignupEmail extends StatelessWidget {
  const SignupEmail({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.passwordConfirmController,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: emailController,
            hintText: '이메일',
            prefixIcon: Icons.email_outlined,
            showClearButton: true,
            keyboardType: TextInputType.emailAddress,
            validator: (val) {
              if (val == null || val.isEmpty) return '이메일을 입력하세요';
              var emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
              if (!emailRegex.hasMatch(val)) return '이메일 형식이 올바르지 않아요';
              return null;
            },
          ),
          PasswordTextFormField(
            controller: passwordController,
            hintText: '비밀번호',
            validator: (val) {
              if (val == null || val.isEmpty) return '비밀번호를 입력하세요';
              var passwordRegex = RegExp(
                r'^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*\W)(?=\S+$).{8,16}$',
              );
              if (!passwordRegex.hasMatch(val)) {
                return '8~16자, 숫자, 문자, 특수문자를 포함해야 합니다';
              }
              return null;
            },
          ),
          PasswordTextFormField(
            controller: passwordConfirmController,
            hintText: '비밀번호 확인',
            validator: (val) {
              if (val == null || val.isEmpty) return '비밀번호 확인을 입력하세요';
              if (val != passwordController.text) return '비밀번호가 일치하지 않습니다';
              return null;
            },
          ),
        ],
      ),
    );
  }
}
