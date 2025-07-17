import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_bridge_app/features/user/user_provider.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';

class ProfileTabFunction {
  static void showLoginRequiredDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // 바깥 터치로 닫히지 않도록
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            '알림',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: AppColors.textPrimary,
            ),
          ),
          content: const Text(
            '이 기능을 사용하려면 로그인이 필요합니다.',
            style: TextStyle(fontSize: 14, color: AppColors.grey600),
          ),
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          actionsAlignment: MainAxisAlignment.end,
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.background,
                backgroundColor: AppColors.primaryLight,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  static void showBookingsPage(BuildContext context) {
    context.go('/performance/booking');
  }

  static void showBookmarksPage(BuildContext context) {
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

  static void showAttendancePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => Scaffold(
              appBar: AppBar(
                title: const Text('참석한 방문'),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
              ),
              body: const Center(child: Text('방문한 공연과 공연장이 여기에 표시됩니다.')),
            ),
      ),
    );
  }

  static void showFollowingPage(BuildContext context) {
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

  static void showReviewsPage(BuildContext context) {
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

  static void showPrivacyPolicy(BuildContext context) {
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

  static void showTermsOfService(BuildContext context) {
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

  static void showFAQ(BuildContext context) {
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

  static void showContactSupport(BuildContext context) {
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

  static void showAppInfo(BuildContext context) {
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

  static void showLogoutDialog(BuildContext context, WidgetRef ref) {
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
                  ref.read(userProvider.notifier).logout();
                  context.go('/');
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
