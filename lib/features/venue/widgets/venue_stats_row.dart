import 'package:flutter/material.dart';
import 'package:sound_bridge_app/models/venue_model.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';

class VenueStatsRow extends StatelessWidget {
  const VenueStatsRow({super.key, required this.venue});

  final VenueModel venue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStatItem('평점', venue.rating.toStringAsFixed(1)),
        _buildStatDivider(),
        _buildStatItem('리뷰', '${venue.reviewCount}개'),
        _buildStatDivider(),
        _buildStatItem('수용인원', '${venue.capacity}명'),
        _buildStatDivider(),
        _buildStatItem('상태', venue.isOpen ? '운영중' : '휴무'),
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(
      height: 30,
      width: 1,
      color: AppColors.grey300,
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}
