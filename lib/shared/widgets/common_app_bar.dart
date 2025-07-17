import 'package:flutter/material.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.music_note, size: 32, color: AppColors.textSecondary),
          SizedBox(width: 8),
          Text('Sound Bridge', style: TextStyle(color: AppColors.textPrimary)),
        ],
      ),
      centerTitle: true,
      backgroundColor: AppColors.background,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
