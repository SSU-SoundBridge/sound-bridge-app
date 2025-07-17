import 'package:flutter/material.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';

class ProfileSupportSection extends StatelessWidget {
  const ProfileSupportSection({
    super.key,
    required this.onFAQPressed,
    required this.onContactSupportPressed,
    required this.onAppInfoPressed,
    this.onLogoutPressed,
  });

  final VoidCallback onFAQPressed;
  final VoidCallback onContactSupportPressed;
  final VoidCallback onAppInfoPressed;
  final VoidCallback? onLogoutPressed;

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
              '지원',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          _buildMenuItem(
            icon: Icons.help,
            title: '자주 묻는 질문',
            subtitle: 'FAQ 및 도움말',
            onTap: onFAQPressed,
          ),
          _buildMenuDivider(),
          _buildMenuItem(
            icon: Icons.contact_support,
            title: '고객 지원',
            subtitle: '문의하기',
            onTap: onContactSupportPressed,
          ),
          _buildMenuDivider(),
          _buildMenuItem(
            icon: Icons.info,
            title: '앱 정보',
            subtitle: '버전 1.0.0',
            onTap: onAppInfoPressed,
          ),
          if (onLogoutPressed != null) ...[
            _buildMenuDivider(),
            _buildMenuItem(
              icon: Icons.logout,
              title: '로그아웃',
              subtitle: '계정에서 로그아웃',
              onTap: onLogoutPressed!,
              textColor: AppColors.error,
            ),
          ],
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

  Widget _buildMenuDivider() {
    return const Divider(height: 1, color: AppColors.grey200, indent: 56);
  }
}
