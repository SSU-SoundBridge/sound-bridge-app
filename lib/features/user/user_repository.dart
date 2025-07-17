import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:sound_bridge_app/features/user/token_storage.dart';
import 'package:sound_bridge_app/models/user_model.dart';

class SignupRequest {
  SignupRequest({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.nickname,
    required this.age,
    required this.sex,
    required this.genres,
    //this.phoneNumber,
    //this.profileImageUrl,
  });
  final String email;
  final String password;
  final String confirmPassword;
  final String nickname;
  final int age;
  final String sex;
  final List<String> genres;
  //final String? phoneNumber;
  //final String? profileImageUrl;

  Map<String, dynamic> toJson() {
    var data = {
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
      'nickname': nickname,
      'age': age,
      'sex': sex,
      'genres': genres,
    };

    //if (phoneNumber != null) data['phoneNumber'] = phoneNumber!;
    //if (profileImageUrl != null) data['profileImageUrl'] = profileImageUrl!;

    return data;
  }
}

class UserRepository {
  final String _baseUrl = dotenv.env['BASE_URL'] ?? '';

  // 로그인
  Future<User> login({required String email, required String password}) async {
    var uri = Uri.parse('$_baseUrl/login');
    var response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      var accessToken = response.headers['authorization'];
      var refreshToken = response.headers['authorization-refresh'];

      if (accessToken == null || refreshToken == null) {
        throw Exception('토큰이 응답 헤더에 없습니다.');
      }

      await TokenStorage.saveTokens(accessToken, refreshToken);

      var data = jsonDecode(response.body) as Map<String, dynamic>;
      var user = User.fromJson(data);
      return user;
    } else {
      throw Exception(response.body);
    }
  }

  // 회원가입
  Future<String?> signUp(SignupRequest request) async {
    var url = Uri.parse('$_baseUrl/api/users/sign-up');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      var accessToken = response.headers['authorization'];
      var refreshToken = response.headers['authorization-refresh'];

      if (accessToken != null && refreshToken != null) {
        await TokenStorage.saveTokens(accessToken, refreshToken);
      }

      return null;
    } else {
      var errorMessage = _parseErrorMessage(response.body);
      return errorMessage;
    }
  }

  String _parseErrorMessage(String responseBody) {
    try {
      var bodyMap = jsonDecode(responseBody);
      var stackTrace = bodyMap['stackTrace'] as String?;

      if (stackTrace != null && stackTrace.contains('이미 존재하는 이메일')) {
        return '이미 존재하는 이메일입니다.';
      }

      return '회원가입 중 오류가 발생했습니다.';
    } catch (e) {
      return '예상치 못한 오류가 발생했습니다.';
    }
  }

  // 이메일 인증번호 발송
  Future<bool> sendEmailVerification(String email) async {
    var url = Uri.parse('$_baseUrl/send-email');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('이메일 전송 실패: ${response.body}');
    }
  }

  // 이메일 인증번호 확인
  Future<bool> verifyEmailCode(String email, String code) async {
    var url = Uri.parse('$_baseUrl/verify');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'code': code}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('인증 실패: ${response.body}');
    }
  }

  // 로그아웃
  Future<void> logout() async {
    await TokenStorage.clearTokens();
  }
}
