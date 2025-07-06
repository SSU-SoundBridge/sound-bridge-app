import 'package:flutter/material.dart';
import 'package:sound_bridge_app/models/artist_model.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';
import 'package:sound_bridge_app/shared/widgets/common_button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ArtistBottomBar extends StatelessWidget {
  const ArtistBottomBar({
    super.key,
    required this.artist,
    required this.isFollowing,
    required this.onFollowToggle,
  });

  final ArtistModel artist;
  final bool isFollowing;
  final VoidCallback onFollowToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.grey200)),
      ),
      child: Row(
        children: [
          // 팔로우 버튼
          Expanded(
            child: CommonButtonWidget(
              text: isFollowing ? '팔로잉' : '팔로우',
              type: isFollowing ? ButtonType.secondary : ButtonType.primary,
              onPressed: onFollowToggle,
            ),
          ),
          const SizedBox(width: 12),

          // 연락하기 버튼
          Expanded(
            child: CommonButtonWidget(
              text: '연락하기',
              type: ButtonType.outline,
              onPressed: () => _showContactDialog(context),
            ),
          ),
        ],
      ),
    );
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('연락하기'),
            content: const Text('어떤 방법으로 연락하시겠습니까?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('취소'),
              ),
              if (artist.phoneNumber != null)
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _launchUrl('tel:${artist.phoneNumber}');
                  },
                  child: const Text('전화'),
                ),
              if (artist.contactEmail != null)
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _launchUrl('mailto:${artist.contactEmail}');
                  },
                  child: const Text('이메일'),
                ),
            ],
          ),
    );
  }

  void _launchUrl(String url) async {
    var uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
