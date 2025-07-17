import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';

class SignupImage extends StatelessWidget {
  const SignupImage({
    super.key,
    required this.formKey,
    required this.onPickImage,
    required this.profileImage,
  });
  final GlobalKey<FormState> formKey;
  final VoidCallback onPickImage;
  final File? profileImage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onPickImage,
              child: CircleAvatar(
                radius: 100,
                backgroundColor: AppColors.grey300,
                backgroundImage:
                    profileImage != null ? FileImage(profileImage!) : null,
                child:
                    profileImage == null
                        ? const Icon(
                          Icons.camera_alt,
                          color: AppColors.background,
                          size: 40,
                        )
                        : null,
              ),
            ),
            const SizedBox(height: 16),
            const Text('프로필 이미지를 선택하세요'),
          ],
        ),
      ),
    );
  }
}
