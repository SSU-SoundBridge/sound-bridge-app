import 'package:flutter/material.dart';
import 'package:sound_bridge_app/models/artist_model.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';

class ArtistSliverAppBar extends StatelessWidget {
  const ArtistSliverAppBar({super.key, required this.artist});

  final ArtistModel artist;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textOnPrimary,
      actions: [
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () {
            // 공유 기능 구현
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          artist.displayName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
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
                  Icons.person,
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
