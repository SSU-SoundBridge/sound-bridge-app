import 'package:flutter/material.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';

class ProfileSettingsSection extends StatelessWidget {
  const ProfileSettingsSection({
    super.key,
    required this.notificationsEnabled,
    required this.emailNotifications,
    required this.locationEnabled,
    required this.onNotificationsChanged,
    required this.onEmailNotificationsChanged,
    required this.onLocationEnabledChanged,
    required this.onPrivacyPolicyPressed,
    required this.onTermsOfServicePressed,
  });

  final bool notificationsEnabled;
  final bool emailNotifications;
  final bool locationEnabled;
  final ValueChanged<bool> onNotificationsChanged;
  final ValueChanged<bool> onEmailNotificationsChanged;
  final ValueChanged<bool> onLocationEnabledChanged;
  final VoidCallback onPrivacyPolicyPressed;
  final VoidCallback onTermsOfServicePressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              '설정',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          _buildSwitchMenuItem(
            icon: Icons.notifications,
            title: '알림',
            subtitle: '앱 알림 설정',
            value: notificationsEnabled,
            onChanged: onNotificationsChanged,
          ),
          _buildMenuDivider(),
          _buildSwitchMenuItem(
            icon: Icons.email,
            title: '이메일 알림',
            subtitle: '이메일로 공연 정보 받기',
            value: emailNotifications,
            onChanged: onEmailNotificationsChanged,
          ),
          _buildMenuDivider(),
          _buildSwitchMenuItem(
            icon: Icons.location_on,
            title: '위치 서비스',
            subtitle: '내 위치 기반 공연 추천',
            value: locationEnabled,
            onChanged: onLocationEnabledChanged,
          ),
          _buildMenuDivider(),
          _buildMenuItem(
            icon: Icons.lock,
            title: '개인정보 보호',
            subtitle: '개인정보 처리방침',
            onTap: onPrivacyPolicyPressed,
          ),
          _buildMenuDivider(),
          _buildMenuItem(
            icon: Icons.description,
            title: '이용약관',
            subtitle: '서비스 이용약관',
            onTap: onTermsOfServicePressed,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: textColor ?? AppColors.primary, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textColor ?? AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuDivider() {
    return const Divider(height: 1, color: AppColors.grey200, indent: 56);
  }
}
