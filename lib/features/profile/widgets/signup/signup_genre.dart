import 'package:flutter/material.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';

class SignupGenre extends StatelessWidget {
  SignupGenre({
    required this.formKey,
    required this.selectedGenres,
    required this.onGenreToggle,
    super.key,
  });
  final GlobalKey<FormState> formKey;
  final List<String> selectedGenres;
  final Function(String genre, bool selected) onGenreToggle;

  final List<String> genreList = [
    '랙타임',
    '스윙',
    '비밥',
    '재즈 퓨전',
    '닥실랜드 재즈',
    '스윙 재즈',
    '모던 재즈',
    '트래디셔널 재즈(트래드)',
    '웨스트 코스트 재즈',
    '이스트 코스트 재즈',
    '부기 우기',
    '하드밥',
    '펑키(솔 재즈)',
    '전위 재즈',
    '프로그레시브 재즈',
    '쿨 재즈',
    '핫 재즈',
    '리얼 재즈',
    '커머셜 재즈',
    '캄보 재즈',
    '보사 노바',
    '캔자스 시티 재즈',
    '메인스트림 재즈',
    '모드 재즈',
    '래그타임',
    '저그 밴트',
    '가스펠 송',
    '리듬 앤 블루스',
    '서드 스트림',
    '칵테일 피아노',
    '랩',
    '레게',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '선호 장르를 선택하세요',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  genreList.map((genre) {
                    var selected = selectedGenres.contains(genre);
                    return FilterChip(
                      label: Text(genre),
                      selected: selected,
                      selectedColor: AppColors.primary.withAlpha(2),
                      onSelected: (value) {
                        onGenreToggle(genre, value);
                      },
                    );
                  }).toList(),
            ),
            const SizedBox(height: 16),
            if (selectedGenres.isEmpty)
              const Text(
                '최소 1개 이상 선택해주세요',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
          ],
        ),
      ),
    );
  }
}
