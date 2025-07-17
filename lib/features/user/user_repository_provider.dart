import 'package:riverpod/riverpod.dart';
import 'package:sound_bridge_app/features/user/user_repository.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});
