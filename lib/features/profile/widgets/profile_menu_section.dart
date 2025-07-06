import 'package:flutter/material.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';

class ProfileMenuSection extends StatelessWidget {
  const ProfileMenuSection({
    super.key,
    required this.onBookingsPressed,
    required this.onBookmarksPressed,
    required this.onFollowingPressed,
    required this.onReviewsPressed,
  });

  final VoidCallback onBookingsPressed;
  final VoidCallback onBookmarksPressed;
  final VoidCallback onFollowingPressed;
  final VoidCallback onReviewsPressed;

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
        children: [
          _buildMenuItem(
            icon: Icons.event_note,
            title: '예약한 공연',
            subtitle: '예약 내역 및 티켓 관리',
            onTap: onBookingsPressed,
          ),
          _buildMenuDivider(),
          _buildMenuItem(
            icon: Icons.bookmark,
            title: '북마크',
            subtitle: '관심 공연 및 공연장',
            onTap: onBookmarksPressed,
          ),
          _buildMenuDivider(),
          _buildMenuItem(
            icon: Icons.favorite,
            title: '팔로잉',
            subtitle: '팔로우한 아티스트',
            onTap: onFollowingPressed,
          ),
          _buildMenuDivider(),
          _buildMenuItem(
            icon: Icons.rate_review,
            title: '내 리뷰',
            subtitle: '작성한 리뷰 관리',
            onTap: onReviewsPressed,
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

  Widget _buildMenuDivider() {
    return const Divider(height: 1, color: AppColors.grey200, indent: 56);
  }
}
