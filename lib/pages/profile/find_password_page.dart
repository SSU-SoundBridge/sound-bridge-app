import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_bridge_app/shared/widgets/common_app_bar.dart';
import 'package:sound_bridge_app/shared/widgets/common_button_widget.dart';
import 'package:sound_bridge_app/shared/widgets/custom_textform_field.dart';

class FindPasswordPage extends StatefulWidget {
  const FindPasswordPage({super.key});

  @override
  State<FindPasswordPage> createState() => _FindPasswordPage();
}

class _FindPasswordPage extends State<FindPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  void _onFindId() async {
    var email = _emailController.text.trim();

    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _isLoading = true);

    //더미
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$email로 비밀번호 재설정 메일이 발송되었습니다.')));
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextFormField(
                controller: _emailController,
                hintText: '이메일',
                prefixIcon: Icons.email_outlined,
                showClearButton: true,
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val == null || val.isEmpty) return '이메일을 입력하세요';
                  if (!val.contains('@')) return '이메일 형식이 올바르지 않아요';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              CommonButtonWidget(
                text: '비밀번호 찾기 찾기',
                onPressed: _isLoading ? null : _onFindId,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
