import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_bridge_app/features/user/user_provider.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';
import 'package:sound_bridge_app/shared/widgets/common_app_bar.dart';
import 'package:sound_bridge_app/shared/widgets/common_button_widget.dart';
import 'package:sound_bridge_app/shared/widgets/custom_password_field.dart';
import 'package:sound_bridge_app/shared/widgets/custom_textform_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _onLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _isLoading = true);
    try {
      await ref
          .read(userProvider.notifier)
          .login(_emailController.text.trim(), _passwordController.text.trim());
      if (!mounted) return;
      context.go('/');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
            mainAxisSize: MainAxisSize.min,
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
              PasswordTextFormField(
                controller: _passwordController,
                hintText: '비밀번호',
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(6),
                ),
                validator: (val) {
                  if (val == null || val.length < 8) {
                    return '8자 이상 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: CommonButtonWidget(
                  text: '로그인',
                  onPressed: _isLoading ? null : _onLogin,
                  isLoading: _isLoading,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      context.push('/profile/findId');
                    },
                    child: const Text('아이디 찾기', style: TextStyle(fontSize: 13)),
                  ),
                  const SizedBox(width: 4),
                  const Text('|', style: TextStyle(color: AppColors.grey900)),
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: () {
                      context.push('/profile/findPassword');
                    },
                    child: const Text(
                      '비밀번호 찾기',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text('|', style: TextStyle(color: AppColors.grey900)),
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: () => context.push('/signup'),
                    child: const Text('회원가입', style: TextStyle(fontSize: 13)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
