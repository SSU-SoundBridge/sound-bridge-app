import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sound_bridge_app/models/venue_model.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class VenueContactTab extends StatelessWidget {
  const VenueContactTab({super.key, required this.venue});

  final VenueModel venue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '연락처 정보',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),

          // 연락처 정보 카드
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.grey200),
            ),
            child: Column(
              children: [
                _buildContactItem(
                  icon: Icons.location_on,
                  title: '주소',
                  value: venue.fullAddress,
                  onTap: () => _launchMaps(venue.latitude, venue.longitude),
                ),
                if (venue.phoneNumber != null) ...[
                  _buildContactDivider(),
                  _buildContactItem(
                    icon: Icons.phone,
                    title: '전화번호',
                    value: venue.phoneNumber!,
                    onTap: () => _launchPhone(venue.phoneNumber!),
                  ),
                ],
                if (venue.website != null) ...[
                  _buildContactDivider(),
                  _buildContactItem(
                    icon: Icons.language,
                    title: '웹사이트',
                    value: venue.website!,
                    onTap: () => _launchWebsite(venue.website!),
                  ),
                ],
                if (venue.instagramUrl != null) ...[
                  _buildContactDivider(),
                  _buildContactItem(
                    icon: Icons.camera_alt,
                    title: '인스타그램',
                    value: venue.instagramUrl!,
                    onTap: () => _launchWebsite(venue.instagramUrl!),
                  ),
                ],
                if (venue.facebookUrl != null) ...[
                  _buildContactDivider(),
                  _buildContactItem(
                    icon: Icons.facebook,
                    title: '페이스북',
                    value: venue.facebookUrl!,
                    onTap: () => _launchWebsite(venue.facebookUrl!),
                  ),
                ],
                if (venue.operatingHours.isNotEmpty) ...[
                  _buildContactDivider(),
                  _buildContactItem(
                    icon: Icons.access_time,
                    title: '운영시간',
                    value: _formatOperatingHours(venue.operatingHours),
                    onTap: null,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 지도
          const Text(
            '위치',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.grey200),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(venue.latitude, venue.longitude),
                  zoom: 15,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('venue'),
                    position: LatLng(venue.latitude, venue.longitude),
                    infoWindow: InfoWindow(title: venue.name),
                  ),
                },
                zoomControlsEnabled: true,
                scrollGesturesEnabled: true,
                rotateGesturesEnabled: true,
                tiltGesturesEnabled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String value,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              const Icon(
                Icons.open_in_new,
                color: AppColors.textSecondary,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactDivider() {
    return const Divider(height: 1, color: AppColors.grey200);
  }

  String _formatOperatingHours(Map<String, String> hours) {
    if (hours.isEmpty) return '운영시간 정보 없음';

    var today = DateTime.now().weekday;
    var weekdays = ['월', '화', '수', '목', '금', '토', '일'];
    var englishDays = [
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
      'sunday',
    ];

    String todayKey = englishDays[today - 1];
    String todayHours = hours[todayKey] ?? '정보 없음';

    return '오늘 (${weekdays[today - 1]}): $todayHours';
  }

  void _launchMaps(double latitude, double longitude) async {
    var uri = Uri.parse('https://maps.google.com/?q=$latitude,$longitude');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchPhone(String phoneNumber) async {
    var uri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchWebsite(String website) async {
    var uri = Uri.parse(website);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
