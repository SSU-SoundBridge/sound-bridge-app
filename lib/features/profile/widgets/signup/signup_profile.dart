import 'package:flutter/material.dart';
import 'package:sound_bridge_app/shared/widgets/custom_textform_field.dart';

class SignupProfile extends StatelessWidget {
  const SignupProfile({
    super.key,
    required this.formKey,
    required this.nicknameController,
    required this.phoneController,
    required this.ageController,
    required this.selectedSex,
    required this.onSexChanged,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nicknameController;
  final TextEditingController phoneController;
  final TextEditingController ageController;
  final String? selectedSex;
  final ValueChanged<String?> onSexChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              controller: nicknameController,
              hintText: '닉네임',
              prefixIcon: Icons.person,
              showClearButton: true,
              validator:
                  (val) => val == null || val.isEmpty ? '닉네임을 입력하세요' : null,
            ),
            CustomTextFormField(
              controller: phoneController,
              hintText: '전화번호',
              prefixIcon: Icons.phone,
              showClearButton: true,
              keyboardType: TextInputType.phone,
              validator: (val) {
                if (val == null || !RegExp(r'^\d{10,11}$').hasMatch(val)) {
                  return '올바른 전화번호를 입력하세요';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            const Text(
              '성별',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Radio<String>(
                  value: 'MALE',
                  groupValue: selectedSex,
                  onChanged: onSexChanged,
                ),
                const Text('남성'),
                const SizedBox(width: 20),
                Radio<String>(
                  value: 'FEMALE',
                  groupValue: selectedSex,
                  onChanged: onSexChanged,
                ),
                const Text('여성'),
              ],
            ),

            if (selectedSex == null)
              const Padding(
                padding: EdgeInsets.only(left: 12, bottom: 12),
                child: Text(
                  '성별을 선택해주세요',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            CustomTextFormField(
              controller: ageController,
              hintText: '나이',
              prefixIcon: Icons.calendar_month_outlined,
              showClearButton: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '나이를 입력해주세요.';
                }
                var age = int.tryParse(value.trim());
                if (age == null) {
                  return '숫자로 입력해주세요.';
                }
                if (age < 1 || age > 120) {
                  return '1세 이상 120세 이하만 입력 가능합니다.';
                }
                return null;
              },
            ),
            // InkWell(
            //   onTap: onSelectBirthDate,
            //   borderRadius: BorderRadius.circular(6),
            //   child: Container(
            //     padding: const EdgeInsets.symmetric(
            //       horizontal: 12,
            //       vertical: 16,
            //     ),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(6),
            //       border: Border.all(color: AppColors.grey300),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text(
            //           birthDate == null
            //               ? '생년월일을 선택하세요'
            //               : DateFormat('yyyy년 MM월 dd일').format(birthDate!),
            //           style: TextStyle(
            //             fontSize: 16,
            //             color:
            //                 birthDate == null
            //                     ? AppColors.grey300
            //                     : AppColors.grey900,
            //           ),
            //         ),
            //         const Icon(Icons.calendar_today),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
