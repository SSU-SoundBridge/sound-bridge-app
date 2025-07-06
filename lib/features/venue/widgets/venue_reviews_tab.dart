import 'package:flutter/material.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';

class VenueReviewsTab extends StatelessWidget {
  const VenueReviewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '리뷰',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star, color: AppColors.ratingStar, size: 16),
                  SizedBox(width: 4),
                  Text(
                    '4.3',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    '(45개)',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 리뷰 리스트 (더미 데이터)
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => _buildReviewItem(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(int index) {
    var reviewTexts = [
      '분위기가 정말 좋은 공연장이에요. 음향도 훌륭하고 직원들도 친절합니다.',
      '공연 시설이 잘 갖추어져 있어서 관람하기 편했어요. 다시 오고 싶네요.',
      '위치가 접근성이 좋아서 찾기 쉬웠습니다. 내부 시설도 깔끔하고 좋았어요.',
      '음향 시설이 정말 뛰어나네요. 재즈 공연을 듣기에 최적의 장소인 것 같아요.',
      '좌석이 편안하고 시야도 좋았습니다. 전체적으로 만족스러운 공연장이에요.',
    ];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.primary,
                child: Icon(
                  Icons.person,
                  size: 16,
                  color: AppColors.textOnPrimary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '사용자 ${index + 1}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Row(
                      children: [
                        ...List.generate(
                          5,
                          (starIndex) => Icon(
                            Icons.star,
                            size: 12,
                            color:
                                starIndex < (4 + index % 2)
                                    ? AppColors.ratingStar
                                    : AppColors.ratingEmpty,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${index + 1}일 전',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            reviewTexts[index % reviewTexts.length],
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
