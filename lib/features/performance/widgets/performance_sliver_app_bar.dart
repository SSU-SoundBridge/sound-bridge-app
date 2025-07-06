import 'package:flutter/material.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';

class PerformanceSliverAppBar extends StatelessWidget {
  const PerformanceSliverAppBar({
    super.key,
    required this.isBookmarked,
    required this.onBookmarkToggle,
    required this.onShare,
  });

  final bool isBookmarked;
  final VoidCallback onBookmarkToggle;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textOnPrimary,
      actions: [
        IconButton(
          icon: Icon(
            isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
            color: AppColors.textOnPrimary,
          ),
          onPressed: onBookmarkToggle,
        ),
        IconButton(
          icon: const Icon(Icons.share, color: AppColors.textOnPrimary),
          onPressed: onShare,
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // 배경 이미지 (실제 앱에서는 네트워크 이미지)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.8),
                    AppColors.secondary.withValues(alpha: 0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.music_note,
                  size: 64,
                  color: AppColors.textOnPrimary,
                ),
              ),
            ),
            // 오버레이
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black54],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
