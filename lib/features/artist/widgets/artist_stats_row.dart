import 'package:flutter/material.dart';
import 'package:sound_bridge_app/models/artist_model.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';

class ArtistStatsRow extends StatelessWidget {
  const ArtistStatsRow({super.key, required this.artist});

  final ArtistModel artist;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStatItem('팔로워', artist.followerCount.toString()),
        _buildStatDivider(),
        _buildStatItem('평점', artist.rating.toStringAsFixed(1)),
        _buildStatDivider(),
        _buildStatItem('리뷰', '${artist.reviewCount}개'),
        _buildStatDivider(),
        _buildStatItem('공연', '${artist.performanceCount}회'),
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
              fontSize: 18,
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
