import 'package:flutter/material.dart';
import 'package:sound_bridge_app/models/venue_model.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';

class VenueAmenitiesTab extends StatelessWidget {
  const VenueAmenitiesTab({super.key, required this.venue});

  final VenueModel venue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '편의시설',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 3,
              ),
              itemCount: venue.amenities.length,
              itemBuilder: (context, index) {
                var amenity = venue.amenities[index];
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.grey200),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _getAmenityIcon(amenity),
                        size: 20,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          amenity,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _getAmenityIcon(String amenity) {
    switch (amenity) {
      case '주차장':
        return Icons.local_parking;
      case '음향시설':
        return Icons.volume_up;
      case '조명':
        return Icons.lightbulb;
      case '무대':
        return Icons.theater_comedy;
      case '화장실':
        return Icons.wc;
      case '바':
        return Icons.local_bar;
      case '댄스플로어':
        return Icons.sports_handball;
      case '카페':
        return Icons.local_cafe;
      case '기념품샵':
        return Icons.shopping_bag;
      case '엘리베이터':
        return Icons.elevator;
      case 'VIP룸':
        return Icons.star;
      case '금고':
        return Icons.lock;
      default:
        return Icons.check_circle;
    }
  }
}
