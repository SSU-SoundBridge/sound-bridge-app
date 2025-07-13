import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

class AppInitializer {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    try {
      await dotenv.load(fileName: '.env');
    } catch (e) {
      debugPrint('환경 변수 로드 실패: $e');
    }

    // 카카오 SDK 초기화
    try {
      KakaoSdk.init(
        nativeAppKey: dotenv.env['KAKAO_NATIVE_APP_KEY'] ?? '',
        javaScriptAppKey: dotenv.env['KAKAO_JAVASCRIPT_APP_KEY'] ?? '',
      );
      debugPrint('카카오 SDK 초기화 완료');
    } catch (e) {
      debugPrint('카카오 SDK 초기화 실패: $e');
    }

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    await SharedPreferences.getInstance();

    await _checkPermissions();

    debugPrint('앱 초기화 완료');
  }

  static Future<void> _checkPermissions() async {
    const permissions = [
      Permission.location,
      Permission.camera,
      Permission.photos,
      Permission.notification,
    ];

    for (Permission permission in permissions) {
      PermissionStatus status = await permission.status;
      if (status.isDenied) {
        debugPrint('권한 필요: $permission');
      }
    }
  }
}
