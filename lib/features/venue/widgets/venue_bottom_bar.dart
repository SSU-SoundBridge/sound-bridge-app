import 'package:flutter/material.dart';
import 'package:sound_bridge_app/models/venue_model.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';
import 'package:sound_bridge_app/shared/widgets/common_button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class VenueBottomBar extends StatelessWidget {
  const VenueBottomBar({
    super.key,
    required this.venue,
    required this.isFollowing,
    required this.onFollowToggle,
  });

  final VenueModel venue;
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
          // 전화걸기 버튼
          if (venue.phoneNumber != null) ...[
            IconButton(
              onPressed: () => _launchPhone(venue.phoneNumber!),
              icon: const Icon(Icons.phone, color: AppColors.primary),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],

          // 팔로우 버튼
          Expanded(
            child: CommonButtonWidget(
              text: isFollowing ? '팔로잉' : '팔로우',
              onPressed: onFollowToggle,
              type: isFollowing ? ButtonType.outline : ButtonType.primary,
            ),
          ),

          // 지도 버튼
          const SizedBox(width: 12),
          IconButton(
            onPressed: () => _launchMaps(venue.latitude, venue.longitude),
            icon: const Icon(Icons.map, color: AppColors.primary),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchPhone(String phoneNumber) async {
    var uri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchMaps(double latitude, double longitude) async {
    var uri = Uri.parse('https://maps.google.com/?q=$latitude,$longitude');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
