import 'package:flutter/material.dart';

class AppColors {
  // 사운드브릿지 브랜드 컬러
  static const Color primary = Color(0xFF6C5CE7);
  static const Color primaryLight = Color(0xFFA29BFE);
  static const Color primaryDark = Color(0xFF5A4FCF);
  static const Color secondary = Color(0xFFE17055);
  static const Color accent = Color(0xFFFFD93D);

  // 배경 색상
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F5F5);

  // 텍스트 색상
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);
  static const Color textTertiary = Color(0xFF95A5A6);
  static const Color textDisabled = Color(0xFFB2BEC3);
  static const Color textOnDark = Color(0xFFFFFFFF);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // 상태 색상
  static const Color success = Color(0xFF00B894);
  static const Color error = Color(0xFFE74C3C);
  static const Color warning = Color(0xFFFDCB6E);
  static const Color info = Color(0xFF74B9FF);

  // 회색 팔레트
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // 그라데이션
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, Color(0xFFFFAB91)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // 그림자
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowMedium = Color(0x33000000);
  static const Color shadowDark = Color(0x4D000000);

  // 장르별 색상
  static const Color genreJazz = Color(0xFF6C5CE7);
  static const Color genreIndie = Color(0xFFE17055);
  static const Color genreBusking = Color(0xFF00B894);
  static const Color genreClassical = Color(0xFF5A4FCF);
  static const Color genreHiphop = Color(0xFFFF4757);
  static const Color genreRock = Color(0xFF2F3542);
  static const Color genreFolk = Color(0xFF3742FA);
  static const Color genreElectronic = Color(0xFF9C88FF);
  static const Color genreOther = Color(0xFF95A5A6);

  // 평점 색상
  static const Color ratingStar = Color(0xFFFFA726);
  static const Color ratingEmpty = Color(0xFFE0E0E0);

  // 상태 표시 색상
  static const Color statusUpcoming = Color(0xFF74B9FF);
  static const Color statusOngoing = Color(0xFF00B894);
  static const Color statusCompleted = Color(0xFF95A5A6);
  static const Color statusCancelled = Color(0xFFE74C3C);
  static const Color statusSoldOut = Color(0xFFFDCB6E);
}

// 테마별 색상 확장
extension AppColorsExtension on AppColors {
  static Color getGenreColor(String genre) {
    switch (genre.toLowerCase()) {
      case 'jazz':
        return AppColors.genreJazz;
      case 'indie':
        return AppColors.genreIndie;
      case 'busking':
        return AppColors.genreBusking;
      case 'classical':
        return AppColors.genreClassical;
      case 'hiphop':
        return AppColors.genreHiphop;
      case 'rock':
        return AppColors.genreRock;
      case 'folk':
        return AppColors.genreFolk;
      case 'electronic':
        return AppColors.genreElectronic;
      default:
        return AppColors.genreOther;
    }
  }

  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'upcoming':
        return AppColors.statusUpcoming;
      case 'ongoing':
        return AppColors.statusOngoing;
      case 'completed':
        return AppColors.statusCompleted;
      case 'cancelled':
        return AppColors.statusCancelled;
      case 'soldout':
        return AppColors.statusSoldOut;
      default:
        return AppColors.statusUpcoming;
    }
  }
}
