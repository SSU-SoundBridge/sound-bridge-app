plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// .env 파일을 읽는 함수
fun getEnvVariable(key: String): String {
    val envFile = file("../../.env")
    if (!envFile.exists()) {
        throw GradleException(".env 파일이 프로젝트 루트에 없습니다. .env 파일을 생성해주세요.")
    }
    
    return try {
        envFile.readLines()
            .firstOrNull { it.startsWith("$key=") && !it.startsWith("$key=#") }
            ?.substringAfter("=")
            ?.trim()
            ?: ""
    } catch (e: Exception) {
        throw GradleException(".env 파일을 읽을 수 없습니다: ${e.message}")
    }
}

android {
    namespace = "com.soundbridge.sound_bridge_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.soundbridge.sound_bridge_app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // .env 파일에서 카카오 네이티브 앱 키 가져오기 (필수)
        val kakaoNativeAppKey = getEnvVariable("KAKAO_NATIVE_APP_KEY")
        if (kakaoNativeAppKey.isEmpty()) {
            throw GradleException("KAKAO_NATIVE_APP_KEY가 .env 파일에 설정되어 있지 않습니다. .env 파일을 생성하고 키를 설정해주세요.")
        }
        manifestPlaceholders["kakaoNativeAppKey"] = kakaoNativeAppKey
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
