class ArtistModel {
  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
      id: json['id'] as String,
      name: json['name'] as String,
      nickname: json['nickname'] as String?,
      bio: json['bio'] as String?,
      profileImageUrl: json['profile_image_url'] as String?,
      coverImageUrl: json['cover_image_url'] as String?,
      genres: List<String>.from(json['genres'] as List),
      instruments: List<String>.from(json['instruments'] as List),
      contactEmail: json['contact_email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      instagramUrl: json['instagram_url'] as String?,
      youtubeUrl: json['youtube_url'] as String?,
      spotifyUrl: json['spotify_url'] as String?,
      soundcloudUrl: json['soundcloud_url'] as String?,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['review_count'] as int,
      performanceCount: json['performance_count'] as int,
      followerCount: json['follower_count'] as int,
      isVerified: json['is_verified'] as bool,
      isAvailable: json['is_available'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  ArtistModel({
    required this.id,
    required this.name,
    this.nickname,
    this.bio,
    this.profileImageUrl,
    this.coverImageUrl,
    required this.genres,
    required this.instruments,
    this.contactEmail,
    this.phoneNumber,
    this.instagramUrl,
    this.youtubeUrl,
    this.spotifyUrl,
    this.soundcloudUrl,
    required this.rating,
    required this.reviewCount,
    required this.performanceCount,
    required this.followerCount,
    required this.isVerified,
    required this.isAvailable,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final String? nickname;
  final String? bio;
  final String? profileImageUrl;
  final String? coverImageUrl;
  final List<String> genres;
  final List<String> instruments;
  final String? contactEmail;
  final String? phoneNumber;
  final String? instagramUrl;
  final String? youtubeUrl;
  final String? spotifyUrl;
  final String? soundcloudUrl;
  final double rating;
  final int reviewCount;
  final int performanceCount;
  final int followerCount;
  final bool isVerified;
  final bool isAvailable;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nickname': nickname,
      'bio': bio,
      'profile_image_url': profileImageUrl,
      'cover_image_url': coverImageUrl,
      'genres': genres,
      'instruments': instruments,
      'contact_email': contactEmail,
      'phone_number': phoneNumber,
      'instagram_url': instagramUrl,
      'youtube_url': youtubeUrl,
      'spotify_url': spotifyUrl,
      'soundcloud_url': soundcloudUrl,
      'rating': rating,
      'review_count': reviewCount,
      'performance_count': performanceCount,
      'follower_count': followerCount,
      'is_verified': isVerified,
      'is_available': isAvailable,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  String get displayName => nickname ?? name;
  String get genreText => genres.join(', ');
  String get instrumentText => instruments.join(', ');
  String get ratingText => rating.toStringAsFixed(1);
  String get followerText =>
      followerCount >= 1000
          ? '${(followerCount / 1000).toStringAsFixed(1)}K'
          : followerCount.toString();

  bool get hasContact => contactEmail != null || phoneNumber != null;
  bool get hasSocialMedia =>
      instagramUrl != null ||
      youtubeUrl != null ||
      spotifyUrl != null ||
      soundcloudUrl != null;

  ArtistModel copyWith({
    String? id,
    String? name,
    String? nickname,
    String? bio,
    String? profileImageUrl,
    String? coverImageUrl,
    List<String>? genres,
    List<String>? instruments,
    String? contactEmail,
    String? phoneNumber,
    String? instagramUrl,
    String? youtubeUrl,
    String? spotifyUrl,
    String? soundcloudUrl,
    double? rating,
    int? reviewCount,
    int? performanceCount,
    int? followerCount,
    bool? isVerified,
    bool? isAvailable,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ArtistModel(
      id: id ?? this.id,
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      bio: bio ?? this.bio,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      genres: genres ?? this.genres,
      instruments: instruments ?? this.instruments,
      contactEmail: contactEmail ?? this.contactEmail,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      instagramUrl: instagramUrl ?? this.instagramUrl,
      youtubeUrl: youtubeUrl ?? this.youtubeUrl,
      spotifyUrl: spotifyUrl ?? this.spotifyUrl,
      soundcloudUrl: soundcloudUrl ?? this.soundcloudUrl,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      performanceCount: performanceCount ?? this.performanceCount,
      followerCount: followerCount ?? this.followerCount,
      isVerified: isVerified ?? this.isVerified,
      isAvailable: isAvailable ?? this.isAvailable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ArtistReviewModel {
  ArtistReviewModel({
    required this.id,
    required this.artistId,
    required this.userId,
    required this.userName,
    this.userProfileImageUrl,
    required this.performanceId,
    required this.performanceTitle,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory ArtistReviewModel.fromJson(Map<String, dynamic> json) {
    return ArtistReviewModel(
      id: json['id'] as String,
      artistId: json['artist_id'] as String,
      userId: json['user_id'] as String,
      userName: json['user_name'] as String,
      userProfileImageUrl: json['user_profile_image_url'] as String?,
      performanceId: json['performance_id'] as String,
      performanceTitle: json['performance_title'] as String,
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  final String id;
  final String artistId;
  final String userId;
  final String userName;
  final String? userProfileImageUrl;
  final String performanceId;
  final String performanceTitle;
  final double rating;
  final String comment;
  final DateTime createdAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'artist_id': artistId,
      'user_id': userId,
      'user_name': userName,
      'user_profile_image_url': userProfileImageUrl,
      'performance_id': performanceId,
      'performance_title': performanceTitle,
      'rating': rating,
      'comment': comment,
      'created_at': createdAt.toIso8601String(),
    };
  }

  String get ratingText => rating.toStringAsFixed(1);
  String get timeAgo {
    DateTime now = DateTime.now();
    Duration difference = now.difference(createdAt);

    if (difference.inDays > 0) {
      return '${difference.inDays}일 전';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}시간 전';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}분 전';
    } else {
      return '방금 전';
    }
  }
}

class ArtistPortfolioModel {
  ArtistPortfolioModel({
    required this.id,
    required this.artistId,
    required this.title,
    this.description,
    this.videoUrl,
    this.audioUrl,
    this.imageUrl,
    required this.type,
    required this.createdAt,
  });

  factory ArtistPortfolioModel.fromJson(Map<String, dynamic> json) {
    return ArtistPortfolioModel(
      id: json['id'] as String,
      artistId: json['artist_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      videoUrl: json['video_url'] as String?,
      audioUrl: json['audio_url'] as String?,
      imageUrl: json['image_url'] as String?,
      type: PortfolioType.fromString(json['type'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  final String id;
  final String artistId;
  final String title;
  final String? description;
  final String? videoUrl;
  final String? audioUrl;
  final String? imageUrl;
  final PortfolioType type;
  final DateTime createdAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'artist_id': artistId,
      'title': title,
      'description': description,
      'video_url': videoUrl,
      'audio_url': audioUrl,
      'image_url': imageUrl,
      'type': type.toString(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}

enum PortfolioType {
  video,
  audio,
  image;

  static PortfolioType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'video':
        return PortfolioType.video;
      case 'audio':
        return PortfolioType.audio;
      case 'image':
        return PortfolioType.image;
      default:
        return PortfolioType.video;
    }
  }

  String get displayName {
    switch (this) {
      case PortfolioType.video:
        return '영상';
      case PortfolioType.audio:
        return '음원';
      case PortfolioType.image:
        return '이미지';
    }
  }
}
