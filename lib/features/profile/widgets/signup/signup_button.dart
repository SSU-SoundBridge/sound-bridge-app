import 'package:flutter/material.dart';
import 'package:sound_bridge_app/shared/widgets/common_button_widget.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({
    super.key,
    required this.currentStep,
    required this.isLoading,
    required this.codeSent,
    required this.onSendCode,
    required this.onVerifyCode,
    required this.onNextStep,
    required this.onPrevStep,
    required this.onSignup,
  });
  final int currentStep;
  final bool isLoading;
  final bool codeSent;
  final VoidCallback onSendCode;
  final VoidCallback onVerifyCode;
  final VoidCallback onNextStep;
  final VoidCallback onPrevStep;
  final VoidCallback onSignup;

  @override
  Widget build(BuildContext context) {
    switch (currentStep) {
      case 0:
        return _buildSingleButton(text: '인증번호 발송', onPressed: onSendCode);
      case 1:
        return _buildSingleButton(text: '인증', onPressed: onVerifyCode);
      case 2:
      case 3:
        return _buildDoubleButton(onPrev: onPrevStep, onNext: onNextStep);
      case 4:
        return _buildSingleButton(text: '회원가입', onPressed: onSignup);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildSingleButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: SizedBox(
        width: double.infinity,
        child: CommonButtonWidget(
          text: text,
          onPressed: isLoading ? null : onPressed,
          isLoading: isLoading,
        ),
      ),
    );
  }

  Widget _buildDoubleButton({
    required VoidCallback onPrev,
    required VoidCallback onNext,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: isLoading ? null : onPrev,
            child: const Text('이전'),
          ),
          CommonButtonWidget(
            text: '다음',
            onPressed: isLoading ? null : onNext,
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }
}
