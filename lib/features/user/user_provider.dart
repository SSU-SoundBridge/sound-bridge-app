import 'package:riverpod/riverpod.dart';
import 'package:sound_bridge_app/features/user/user_repository.dart';
import 'package:sound_bridge_app/features/user/user_repository_provider.dart';
import 'package:sound_bridge_app/models/user_model.dart';

class UserState {
  const UserState({this.user});
  final User? user;

  bool get isLoggedIn => user != null;

  UserState copyWith({User? user}) {
    return UserState(user: user ?? this.user);
  }
}

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier(this.repository) : super(const UserState());
  final UserRepository repository;

  Future<void> login(String email, String password) async {
    var user = await repository.login(email: email, password: password);
    state = state.copyWith(user: user);
  }

  void setUser(User user) {
    state = state.copyWith(user: user);
  }

  Future<void> logout() async {
    await repository.logout();
    state = const UserState();
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  var repo = ref.watch(userRepositoryProvider);
  return UserNotifier(repo);
});
