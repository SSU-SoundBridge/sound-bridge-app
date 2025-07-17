import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_bridge_app/shared/widgets/common_app_bar.dart';
import 'package:sound_bridge_app/shared/widgets/common_button_widget.dart';
import 'package:sound_bridge_app/shared/widgets/custom_textform_field.dart';

class FindIdPage extends StatefulWidget {
  const FindIdPage({super.key});

  @override
  State<FindIdPage> createState() => _FindIdPageState();
}

class _FindIdPageState extends State<FindIdPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  void _onFindId() async {
    var phone = _phoneController.text.trim();

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
    ).showSnackBar(SnackBar(content: Text('$phone으로 아이디를 보냈습니다.')));
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
                controller: _phoneController,
                hintText: '전화번호',
                prefixIcon: Icons.phone,
                showClearButton: true,
                keyboardType: TextInputType.phone,
                validator: (val) {
                  if (val == null || val.isEmpty) return '전화번호를 입력하세요';
                  if (!RegExp(r'^\d{10,11}$').hasMatch(val)) {
                    return '올바른 전화번호를 입력하세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              CommonButtonWidget(
                text: '아이디 찾기',
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
