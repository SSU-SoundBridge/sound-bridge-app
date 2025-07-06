import 'package:flutter/material.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';

enum AppBarBackgroundType { gradient, image, solid }

class CommonSliverAppBar extends StatelessWidget {
  const CommonSliverAppBar({
    super.key,
    this.title,
    this.expandedHeight = 300,
    this.pinned = true,
    this.backgroundType = AppBarBackgroundType.gradient,
    this.backgroundImage,
    this.backgroundColor,
    this.centerIcon,
    this.centerIconSize = 64,
    this.showBookmark = false,
    this.showShare = false,
    this.showSearch = false,
    this.showSettings = false,
    this.isBookmarked = false,
    this.onBookmarkPressed,
    this.onSharePressed,
    this.onSearchPressed,
    this.onSettingsPressed,
    this.customActions,
    this.gradientColors,
  });

  final String? title;
  final double expandedHeight;
  final bool pinned;
  final AppBarBackgroundType backgroundType;
  final String? backgroundImage;
  final Color? backgroundColor;
  final IconData? centerIcon;
  final double centerIconSize;
  final bool showBookmark;
  final bool showShare;
  final bool showSearch;
  final bool showSettings;
  final bool isBookmarked;
  final VoidCallback? onBookmarkPressed;
  final VoidCallback? onSharePressed;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onSettingsPressed;
  final List<Widget>? customActions;
  final List<Color>? gradientColors;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: expandedHeight,
      pinned: pinned,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textOnPrimary,
      actions: _buildActions(),
      flexibleSpace: FlexibleSpaceBar(
        title:
            title != null
                ? Text(
                  title!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textOnPrimary,
                  ),
                )
                : null,
        background: _buildBackground(),
      ),
    );
  }

  List<Widget> _buildActions() {
    List<Widget> actions = [];

    if (showSearch) {
      actions.add(
        IconButton(icon: const Icon(Icons.search), onPressed: onSearchPressed),
      );
    }

    if (showBookmark) {
      actions.add(
        IconButton(
          icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_outline),
          onPressed: onBookmarkPressed,
        ),
      );
    }

    if (showShare) {
      actions.add(
        IconButton(icon: const Icon(Icons.share), onPressed: onSharePressed),
      );
    }

    if (showSettings) {
      actions.add(
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: onSettingsPressed,
        ),
      );
    }

    if (customActions != null) {
      actions.addAll(customActions!);
    }

    return actions;
  }

  Widget _buildBackground() {
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildBackgroundContent(),
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
    );
  }

  Widget _buildBackgroundContent() {
    switch (backgroundType) {
      case AppBarBackgroundType.image:
        return backgroundImage != null
            ? Image.network(
              backgroundImage!,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => _buildDefaultBackground(),
            )
            : _buildDefaultBackground();

      case AppBarBackgroundType.solid:
        return Container(
          color: backgroundColor ?? AppColors.primary,
          child: _buildCenterIcon(),
        );

      case AppBarBackgroundType.gradient:
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:
                  gradientColors ??
                  [
                    AppColors.primary.withValues(alpha: 0.8),
                    AppColors.secondary.withValues(alpha: 0.8),
                  ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: _buildCenterIcon(),
        );
    }
  }

  Widget _buildDefaultBackground() {
    return Container(
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
      child: _buildCenterIcon(),
    );
  }

  Widget _buildCenterIcon() {
    if (centerIcon == null) return const SizedBox();

    return Center(
      child: Icon(
        centerIcon,
        size: centerIconSize,
        color: AppColors.textOnPrimary,
      ),
    );
  }
}
