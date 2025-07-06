import 'package:flutter/material.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';

class ProfileUserHeader extends StatelessWidget {
  const ProfileUserHeader({super.key, required this.userData});

  final Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // 프로필 사진
          CircleAvatar(
            radius: 50,
            backgroundColor: AppColors.textOnPrimary,
            child:
                userData['profileImage'] != null
                    ? ClipOval(
                      child: Image.network(
                        userData['profileImage'],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                    : const Icon(
                      Icons.person,
                      size: 50,
                      color: AppColors.primary,
                    ),
          ),
          const SizedBox(height: 16),

          // 사용자 이름
          Text(
            userData['name'],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textOnPrimary,
            ),
          ),
          const SizedBox(height: 4),

          // 이메일
          Text(
            userData['email'],
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textOnPrimary.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 8),

          // 가입일
          Text(
            '가입일: ${userData['joinDate']}',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textOnPrimary.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
