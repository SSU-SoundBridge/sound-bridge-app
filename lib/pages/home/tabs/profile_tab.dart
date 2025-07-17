import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_bridge_app/features/profile/widgets/profile_settings_section.dart';
import 'package:sound_bridge_app/features/profile/widgets/profile_support_section.dart';
import 'package:sound_bridge_app/features/profile/widgets/profile_tab_function.dart';
import 'package:sound_bridge_app/features/user/user_provider.dart';
import 'package:sound_bridge_app/models/user_model.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';
import 'package:sound_bridge_app/shared/widgets/common_sliver_app_bar.dart';

class ProfileTab extends ConsumerStatefulWidget {
  const ProfileTab({super.key});

  @override
  ConsumerState<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends ConsumerState<ProfileTab> {
  bool _notificationsEnabled = true;
  bool _emailNotifications = false;
  bool _locationEnabled = true;
  @override
  Widget build(BuildContext context) {
    var userState = ref.watch(userProvider);
    var isLoggedIn = userState.isLoggedIn;
    var user = userState.user;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CommonSliverAppBar(
            title: '프로필',
            centerIcon: Icons.person,
            expandedHeight: 120,
            showSettings: true,
            onSettingsPressed:
                isLoggedIn
                    ? () => context.go('/profile/edit')
                    : () => ProfileTabFunction.showLoginRequiredDialog(context),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  isLoggedIn
                      ? _buildLoggedInView(context, user!)
                      : _buildLoggedOutView(context),
                  ProfileSupportSection(
                    onFAQPressed: () => ProfileTabFunction.showFAQ(context),
                    onContactSupportPressed:
                        () => ProfileTabFunction.showContactSupport(context),
                    onAppInfoPressed:
                        () => ProfileTabFunction.showAppInfo(context),
                    onLogoutPressed:
                        isLoggedIn
                            ? () => ProfileTabFunction.showLogoutDialog(
                              context,
                              ref,
                            )
                            : null,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoggedOutView(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextButton(
        onPressed: () => context.push('/login'),
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          foregroundColor: AppColors.textPrimary,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('로그인이 필요합니다.', style: TextStyle(fontSize: 16)),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  Widget _buildLoggedInView(BuildContext context, User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        _buildProfileHeader(user),
        _buildStats(user),
        const SizedBox(height: 12),

        ProfileSettingsSection(
          notificationsEnabled: _notificationsEnabled,
          emailNotifications: _emailNotifications,
          locationEnabled: _locationEnabled,
          onNotificationsChanged:
              (val) => setState(() => _notificationsEnabled = val),
          onEmailNotificationsChanged:
              (val) => setState(() => _emailNotifications = val),
          onLocationEnabledChanged:
              (val) => setState(() => _locationEnabled = val),
          onPrivacyPolicyPressed:
              () => ProfileTabFunction.showPrivacyPolicy(context),
          onTermsOfServicePressed:
              () => ProfileTabFunction.showTermsOfService(context),
        ),
      ],
    );
  }

  Widget _buildProfileHeader(User user) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
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
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(80),
                ),
                child: const Icon(
                  Icons.person,
                  color: AppColors.textOnPrimary,
                  size: 40,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            user.nickname,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            user.favoriteGenre.join(', '),
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildProfileStatButton(
                label: '팔로잉',
                value: user.followingUserIds.length.toString(),
                onPressed: () => ProfileTabFunction.showFollowingPage(context),
              ),
              Container(width: 1, height: 30, color: AppColors.grey200),
              _buildProfileStatButton(
                label: '참석한 공연',
                value: user.attendedPerformanceIds.length.toString(),
                onPressed: () => ProfileTabFunction.showAttendancePage(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStatButton({
    required String label,
    required String value,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStats(User user) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildStatButton(
              icon: Icons.favorite,
              title: '찜한 공연',
              value: user.bookmarkedPerformanceIds.length.toString(),
              color: AppColors.error,
              onPressed: () => ProfileTabFunction.showBookmarksPage(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatButton(
              icon: Icons.schedule,
              title: '예약 공연',
              value: user.bookingIds.length.toString(),
              color: AppColors.warning,
              onPressed: () => ProfileTabFunction.showBookingsPage(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatButton(
              icon: Icons.star,
              title: '리뷰 작성',
              value: user.reviewIds.length.toString(),
              color: AppColors.ratingStar,
              onPressed: () => ProfileTabFunction.showReviewsPage(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatButton({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
