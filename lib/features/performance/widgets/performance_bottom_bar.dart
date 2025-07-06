import 'package:flutter/material.dart';
import 'package:sound_bridge_app/models/performance_model.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';
import 'package:sound_bridge_app/shared/widgets/common_button_widget.dart';

class PerformanceBottomBar extends StatelessWidget {
  const PerformanceBottomBar({
    super.key,
    required this.performance,
    required this.onBooking,
  });

  final PerformanceModel performance;
  final VoidCallback onBooking;

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
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '가격',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
              Text(
                performance.formattedPrice,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: CommonButtonWidget(
              text: performance.isBookingFull ? '매진' : '예약하기',
              onPressed: performance.isBookingFull ? null : onBooking,
              isDisabled: performance.isBookingFull,
            ),
          ),
        ],
      ),
    );
  }
}
