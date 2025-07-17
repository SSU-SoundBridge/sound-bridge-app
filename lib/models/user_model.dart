class User {
  User({
    required this.id,
    required this.email,
    required this.nickname,
    required this.age,
    this.profileImageUrl,
    this.bookmarkedPerformanceIds = const [],
    this.bookingIds = const [],
    this.reviewIds = const [],
    this.followingUserIds = const [],
    this.followerUserIds = const [],
    this.attendedPerformanceIds = const [],
    required this.createdAt,
    required this.favoriteGenre,
    required this.phoneNumber,
    required this.sex,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      email: json['email'] as String,
      nickname: json['nickname'] as String,
      age:
          (json['age'] is int)
              ? json['age']
              : int.tryParse(json['age'].toString()) ?? 0,
      profileImageUrl: json['profileImageUrl'] as String?,
      bookmarkedPerformanceIds: List<String>.from(
        json['bookmarkedPerformanceIds'] ?? [],
      ),
      bookingIds: List<String>.from(json['bookingIds'] ?? []),
      reviewIds: List<String>.from(json['reviewIds'] ?? []),
      followingUserIds: List<String>.from(json['followingUserIds'] ?? []),
      followerUserIds: List<String>.from(json['followerUserIds'] ?? []),
      attendedPerformanceIds: List<String>.from(
        json['attendedPerformanceIds'] ?? [],
      ),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      favoriteGenre: List<String>.from(json['favoriteGenre'] ?? []),
      phoneNumber: json['phoneNumber'] as String? ?? '',
      sex: json['sex'] as String? ?? '',
    );
  }

  final int id;
  final String email;
  final String nickname;
  final String? profileImageUrl;
  final int age;
  final List<String> bookmarkedPerformanceIds;
  final List<String> bookingIds;
  final List<String> reviewIds;
  final List<String> followingUserIds;
  final List<String> followerUserIds;
  final List<String> attendedPerformanceIds;
  final DateTime createdAt;
  final List<String> favoriteGenre;
  final String phoneNumber;
  final String sex;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'nickname': nickname,
      'age': age,
      'profileImageUrl': profileImageUrl,
      'bookmarkedPerformanceIds': bookmarkedPerformanceIds,
      'bookingIds': bookingIds,
      'reviewIds': reviewIds,
      'followingUserIds': followingUserIds,
      'followerUserIds': followerUserIds,
      'attendedPerformanceIds': attendedPerformanceIds,
      'createdAt': createdAt.toIso8601String(),
      'favoriteGenre': favoriteGenre,
      'phoneNumber': phoneNumber,
      'sex': sex,
    };
  }

  User copyWith({
    int? id,
    String? email,
    String? nickname,
    int? age,
    String? profileImageUrl,
    List<String>? bookmarkedPerformanceIds,
    List<String>? bookingIds,
    List<String>? reviewIds,
    List<String>? followingUserIds,
    List<String>? followerUserIds,
    List<String>? attendedPerformanceIds,
    DateTime? createdAt,
    List<String>? favoriteGenre,
    String? phoneNumber,
    String? sex,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      nickname: nickname ?? this.nickname,
      age: age ?? this.age,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      bookmarkedPerformanceIds:
          bookmarkedPerformanceIds ?? this.bookmarkedPerformanceIds,
      bookingIds: bookingIds ?? this.bookingIds,
      reviewIds: reviewIds ?? this.reviewIds,
      followingUserIds: followingUserIds ?? this.followingUserIds,
      followerUserIds: followerUserIds ?? this.followerUserIds,
      attendedPerformanceIds:
          attendedPerformanceIds ?? this.attendedPerformanceIds,
      createdAt: createdAt ?? this.createdAt,
      favoriteGenre: favoriteGenre ?? this.favoriteGenre,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      sex: sex ?? this.sex,
    );
  }
}
