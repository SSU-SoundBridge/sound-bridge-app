import 'package:flutter/material.dart';
import 'package:sound_bridge_app/features/performance/widgets/performance_card.dart';
import 'package:sound_bridge_app/models/performance_model.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';

class VenuePerformancesTab extends StatelessWidget {
  const VenuePerformancesTab({
    super.key,
    required this.performances,
    required this.onPerformancePressed,
  });

  final List<PerformanceModel> performances;
  final void Function(PerformanceModel) onPerformancePressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '예정된 공연',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),

          if (performances.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Text(
                  '등록된 공연이 없습니다.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: performances.length,
                itemBuilder: (context, index) {
                  var performance = performances[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: PerformanceCard(
                      performance: performance,
                      onTap: () => onPerformancePressed(performance),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
