import 'package:flutter/material.dart';
import 'package:sound_bridge_app/features/profile/widgets/profile_menu_section.dart';
import 'package:sound_bridge_app/features/profile/widgets/profile_settings_section.dart';
import 'package:sound_bridge_app/features/profile/widgets/profile_stats_section.dart';
import 'package:sound_bridge_app/features/profile/widgets/profile_support_section.dart';
import 'package:sound_bridge_app/features/profile/widgets/profile_user_header.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';
import 'package:sound_bridge_app/shared/widgets/common_sliver_app_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _notificationsEnabled = true;
  bool _emailNotifications = false;
  bool _locationEnabled = true;

  // 더미 사용자 데이터
  final Map<String, dynamic> _userData = {
    'name': '김사용자',
    'email': 'user@example.com',
    'phone': '010-1234-5678',
    'profileImage': null,
    'joinDate': '2023.01.15',
    'bookingCount': 12,
    'reviewCount': 8,
    'favoriteGenre': '재즈',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CommonSliverAppBar(
            title: '프로필',
            backgroundType: AppBarBackgroundType.gradient,
            centerIcon: Icons.person,
            expandedHeight: 200,
            showSettings: true,
            onSettingsPressed: _showEditProfileDialog,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                ProfileUserHeader(userData: _userData),
                ProfileStatsSection(userData: _userData),
                ProfileMenuSection(
                  onBookingsPressed: _showBookingsPage,
                  onBookmarksPressed: _showBookmarksPage,
                  onFollowingPressed: _showFollowingPage,
                  onReviewsPressed: _showReviewsPage,
                ),
                ProfileSettingsSection(
                  notificationsEnabled: _notificationsEnabled,
                  emailNotifications: _emailNotifications,
                  locationEnabled: _locationEnabled,
                  onNotificationsChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                  onEmailNotificationsChanged: (value) {
                    setState(() {
                      _emailNotifications = value;
                    });
                  },
                  onLocationEnabledChanged: (value) {
                    setState(() {
                      _locationEnabled = value;
                    });
                  },
                  onPrivacyPolicyPressed: _showPrivacyPolicy,
                  onTermsOfServicePressed: _showTermsOfService,
                ),
                ProfileSupportSection(
                  onFAQPressed: _showFAQ,
                  onContactSupportPressed: _showContactSupport,
                  onAppInfoPressed: _showAppInfo,
                  onLogoutPressed: _showLogoutDialog,
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('프로필 편집'),
            content: const Text('프로필 편집 기능이 구현되면 여기에 편집 폼이 표시됩니다.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('취소'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('저장'),
              ),
            ],
          ),
    );
  }

  void _showBookingsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => Scaffold(
              appBar: AppBar(
                title: const Text('예약한 공연'),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
              ),
              body: const Center(child: Text('예약한 공연 목록이 여기에 표시됩니다.')),
            ),
      ),
    );
  }

  void _showBookmarksPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => Scaffold(
              appBar: AppBar(
                title: const Text('북마크'),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
              ),
              body: const Center(child: Text('북마크한 공연과 공연장이 여기에 표시됩니다.')),
            ),
      ),
    );
  }

  void _showFollowingPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => Scaffold(
              appBar: AppBar(
                title: const Text('팔로잉'),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
              ),
              body: const Center(child: Text('팔로우한 아티스트가 여기에 표시됩니다.')),
            ),
      ),
    );
  }

  void _showReviewsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => Scaffold(
              appBar: AppBar(
                title: const Text('내 리뷰'),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
              ),
              body: const Center(child: Text('작성한 리뷰가 여기에 표시됩니다.')),
            ),
      ),
    );
  }

  void _showPrivacyPolicy() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => Scaffold(
              appBar: AppBar(
                title: const Text('개인정보 보호'),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
              ),
              body: const Padding(
                padding: EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Text(
                    '개인정보 처리방침 내용이 여기에 표시됩니다.\n\n'
                    '사운드브릿지는 사용자의 개인정보를 소중히 여기며, '
                    '관련 법률에 따라 안전하게 처리하고 있습니다.',
                    style: TextStyle(fontSize: 14, height: 1.6),
                  ),
                ),
              ),
            ),
      ),
    );
  }

  void _showTermsOfService() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => Scaffold(
              appBar: AppBar(
                title: const Text('이용약관'),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
              ),
              body: const Padding(
                padding: EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Text(
                    '서비스 이용약관 내용이 여기에 표시됩니다.\n\n'
                    '본 약관은 사운드브릿지 서비스 이용에 관한 '
                    '조건과 절차를 규정합니다.',
                    style: TextStyle(fontSize: 14, height: 1.6),
                  ),
                ),
              ),
            ),
      ),
    );
  }

  void _showFAQ() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => Scaffold(
              appBar: AppBar(
                title: const Text('자주 묻는 질문'),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
              ),
              body: const Center(child: Text('FAQ 목록이 여기에 표시됩니다.')),
            ),
      ),
    );
  }

  void _showContactSupport() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => Scaffold(
              appBar: AppBar(
                title: const Text('고객 지원'),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
              ),
              body: const Center(child: Text('고객 지원 연락처가 여기에 표시됩니다.')),
            ),
      ),
    );
  }

  void _showAppInfo() {
    showAboutDialog(
      context: context,
      applicationName: 'Sound Bridge',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(
        Icons.music_note,
        size: 48,
        color: AppColors.primary,
      ),
      children: const [
        Text('로컬 공연 정보 통합 플랫폼'),
        SizedBox(height: 16),
        Text('© 2024 Sound Bridge. All rights reserved.'),
      ],
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('로그아웃'),
            content: const Text('정말 로그아웃하시겠습니까?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('취소'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // 로그아웃 처리
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('로그아웃되었습니다.')));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                ),
                child: const Text('로그아웃'),
              ),
            ],
          ),
    );
  }
}
