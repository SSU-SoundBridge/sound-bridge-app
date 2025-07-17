import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sound_bridge_app/features/user/user_provider.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';
import 'package:sound_bridge_app/shared/widgets/common_app_bar.dart';

class ProfileEditPage extends ConsumerStatefulWidget {
  const ProfileEditPage({super.key});

  @override
  ConsumerState<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends ConsumerState<ProfileEditPage> {
  late TextEditingController _nicknameController;
  late List<String> _selectedGenres;

  File? _newProfileImageFile;
  String? _newProfileImageUrl;

  final List<String> genreList = ['재즈', '클래식', '팝', '블루스', '힙합', '소울'];

  @override
  void initState() {
    super.initState();
    var user = ref.read(userProvider).user!;
    _nicknameController = TextEditingController(text: user.nickname);
    _selectedGenres = List.from(user.favoriteGenre);
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    var picker = ImagePicker();
    var picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );
    if (picked != null) {
      setState(() => _newProfileImageFile = File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    var user = ref.watch(userProvider).user!;

    return Scaffold(
      appBar: const CommonAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      _newProfileImageFile != null
                          ? FileImage(_newProfileImageFile!)
                          : (user.profileImageUrl != null
                              ? NetworkImage(user.profileImageUrl!)
                                  as ImageProvider
                              : null),
                  child:
                      _newProfileImageFile == null &&
                              user.profileImageUrl == null
                          ? const Icon(Icons.camera_alt, size: 30)
                          : null,
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _nicknameController,
              decoration: const InputDecoration(labelText: '닉네임'),
            ),
            const SizedBox(height: 24),
            const Text(
              '선호 장르',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children:
                  genreList.map((genre) {
                    return FilterChip(
                      label: Text(genre),
                      selected: _selectedGenres.contains(genre),
                      onSelected: (selected) {
                        setState(() {
                          selected
                              ? _selectedGenres.add(genre)
                              : _selectedGenres.remove(genre);
                        });
                      },
                    );
                  }).toList(),
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              '개인정보',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _infoRow('이메일', user.email),
            _infoRow('전화번호', user.phoneNumber),
            _infoRow('생년월일', user.age.toString()),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // var updatedUser = user.copyWith(
                  //   nickname: _nicknameController.text,
                  //   favoriteGenre: _selectedGenres,
                  //   // 프로필 이미지 업데이트 처리 필요 시 추가
                  // );
                  // ref.read(userProvider.notifier).login(updatedUser);
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('프로필이 수정되었습니다.')),
                  // );
                  // context.go('/profile');
                },
                child: const Text('저장'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
