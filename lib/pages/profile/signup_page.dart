import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sound_bridge_app/features/profile/widgets/signup/signup_button.dart';
import 'package:sound_bridge_app/features/profile/widgets/signup/signup_email.dart';
import 'package:sound_bridge_app/features/profile/widgets/signup/signup_genre.dart';
import 'package:sound_bridge_app/features/profile/widgets/signup/signup_image.dart';
import 'package:sound_bridge_app/features/profile/widgets/signup/signup_profile.dart';
import 'package:sound_bridge_app/features/user/user_repository.dart';
import 'package:sound_bridge_app/features/user/user_repository_provider.dart';
import 'package:sound_bridge_app/shared/widgets/common_app_bar.dart';
import 'package:sound_bridge_app/shared/widgets/custom_textform_field.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final List<GlobalKey<FormState>> _formKeys = List.generate(
    5,
    (_) => GlobalKey<FormState>(),
  );
  final baseUrl = dotenv.env['BASE_URL'];

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _ageController = TextEditingController();
  String? _selectedSex;

  String? _profileImageUrl;
  final ImagePicker _picker = ImagePicker();
  File? _profileImage;

  int _currentStep = 0;
  bool _codeSent = false;

  List<String> selectedGenres = [];

  bool _isLoading = false;

  Future<void> _pickImage() async {
    ImagePicker picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    var file = File(pickedFile.path);

    setState(() {
      _profileImage = file; // 화면 미리보기 용
    });

    try {
      var url = await uploadImage(file); // 서버 업로드 후 URL 받아오기
      setState(() {
        _profileImageUrl = url; // 실제 서버에 보낼 URL
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('이미지 업로드 실패: $e')));
    }
  }

  Future<String> uploadImage(File file) async {
    //더미
    await Future.delayed(const Duration(milliseconds: 500));
    return 'https://example.com/dummy-profile.jpg'; // 가짜 URL 반환
  }

  Future<void> _onSignup() async {
    setState(() => _isLoading = true);

    try {
      var repository = ref.read(userRepositoryProvider);

      var request = SignupRequest(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        confirmPassword: _passwordController.text.trim(),
        nickname: _nicknameController.text.trim(),
        age: int.tryParse(_ageController.text) ?? 0,
        sex: _selectedSex.toString(),
        genres: selectedGenres,
      );

      var errorMsg = await repository.signUp(request);

      if (errorMsg == null) {
        if (!mounted) return;
        context.go('/');
        showToast('회원가입에 성공하셨습니다.');
      } else {
        showDialogMessage(errorMsg);
      }
    } catch (e) {
      showDialogMessage('회원가입 실패: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _nicknameController.addListener(() => setState(() {}));
    _emailController.addListener(() => setState(() {}));
    _phoneController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nicknameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Step ${_currentStep + 1} of 5'),
            const SizedBox(height: 16),
            Expanded(
              child: IndexedStack(
                index: _currentStep,
                children: [
                  SignupEmail(
                    formKey: _formKeys[0],
                    emailController: _emailController,
                    passwordController: _passwordController,
                    passwordConfirmController: _passwordConfirmController,
                  ),
                  Form(
                    key: _formKeys[1],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('인증번호를 입력하세요'),
                        const SizedBox(height: 12),
                        CustomTextFormField(
                          controller: _codeController,
                          hintText: '인증번호',
                          prefixIcon: Icons.lock_outline,
                          validator:
                              (val) =>
                                  val == null || val.length != 6
                                      ? '6자리 인증번호를 입력하세요'
                                      : null,
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                '인증번호를 못 받으셨나요?',
                                style: TextStyle(fontSize: 12),
                              ),
                              TextButton(
                                onPressed: _handleSendCode,
                                child: const Text(
                                  '재전송',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SignupProfile(
                    formKey: _formKeys[2],
                    nicknameController: _nicknameController,
                    phoneController: _phoneController,
                    ageController: _ageController,
                    selectedSex: _selectedSex,
                    onSexChanged: (val) => setState(() => _selectedSex = val),
                  ),
                  SignupImage(
                    formKey: _formKeys[3],
                    onPickImage: _pickImage,
                    profileImage: _profileImage,
                  ),
                  SignupGenre(
                    formKey: _formKeys[4],
                    selectedGenres: selectedGenres,
                    onGenreToggle: (genre, selected) {
                      setState(() {
                        selected
                            ? selectedGenres.add(genre)
                            : selectedGenres.remove(genre);
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SignupButton(
              currentStep: _currentStep,
              isLoading: _isLoading,
              codeSent: _codeSent,
              onSendCode: _handleSendCode,
              onVerifyCode: _handleVerifyCode,
              onNextStep: _handleNextStep,
              onPrevStep: () => setState(() => _currentStep--),
              onSignup: _onSignup,
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> _selectBirthDate() async {
  //   var picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime(2000, 1, 1),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );

  //   if (picked != null) {
  //     setState(() {
  //       _birthDate = picked;
  //     });
  //   }
  // }

  void _handleSendCode() async {
    if (!_formKeys[0].currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      var repository = ref.read(userRepositoryProvider);
      var success = await repository.sendEmailVerification(
        _emailController.text.trim(),
      );
      if (success) {
        setState(() {
          _codeSent = true;
          _currentStep = 1;
        });
        showToast('인증번호가 전송되었습니다.');
      }
    } catch (e) {
      showToast('이메일 전송 실패: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _handleVerifyCode() async {
    setState(() => _isLoading = true);

    try {
      var repository = ref.read(userRepositoryProvider);
      var success = await repository.verifyEmailCode(
        _emailController.text.trim(),
        _codeController.text.trim(),
      );
      if (success) {
        setState(() => _currentStep = 2);
        '이메일 인증이 완료되었습니다.';
      }
    } catch (e) {
      showToast('인증 실패: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void showDialogMessage(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 다이얼로그 닫기
                },
                child: const Text('확인'),
              ),
            ],
          ),
    );
  }

  void _handleNextStep() {
    if (_formKeys[_currentStep].currentState?.validate() ?? false) {
      setState(() => _currentStep++);
    } else {}
  }

  void showToast(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
